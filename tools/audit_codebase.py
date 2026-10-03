import os
import glob
import re
import json
import sys
import io

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')

project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), os.pardir))
lib_dir = os.path.join(project_root, "lib")

all_dart_files = []
for root, dirs, files in os.walk(lib_dir):
    for f in files:
        if f.endswith(".dart"):
            all_dart_files.append(os.path.relpath(os.path.join(root, f), project_root))

print(f"Total Dart files found in lib: {len(all_dart_files)}")

# Build import graph to check connectivity
import_map = {f.replace("\\", "/"): [] for f in all_dart_files}
imported_by = {f.replace("\\", "/"): [] for f in all_dart_files}

for rel_path in all_dart_files:
    full_path = os.path.join(project_root, rel_path)
    norm_path = rel_path.replace("\\", "/")
    with open(full_path, "r", encoding="utf-8", errors="ignore") as f:
        content = f.read()

    # find all imports in file
    all_imports = re.findall(r"import\s+['\"]([^'\"]+)['\"];", content)

    for imp in all_imports:
        if imp.startswith("package:noor_app/"):
            target = imp.replace("package:noor_app/", "lib/")
        elif not imp.startswith("package:") and not imp.startswith("dart:"):
            curr_dir = os.path.dirname(norm_path)
            target = os.path.normpath(os.path.join(curr_dir, imp)).replace("\\", "/")
        else:
            continue

        if target in import_map:
            import_map[norm_path].append(target)
            imported_by[target].append(norm_path)

file_audits = {}

for rel_path in sorted(all_dart_files):
    norm_path = rel_path.replace("\\", "/")
    full_path = os.path.join(project_root, rel_path)
    with open(full_path, "r", encoding="utf-8", errors="ignore") as f:
        lines = f.readlines()
        content = "".join(lines)

    line_count = len(lines)

    # Checks
    todos = [f"L{i+1}: {l.strip()}" for i, l in enumerate(lines) if "TODO" in l or "FIXME" in l]
    prints = [f"L{i+1}: {l.strip()}" for i, l in enumerate(lines) if re.search(r"\bprint\s*\(", l) and not l.strip().startswith("//")]
    nav_push = [f"L{i+1}: {l.strip()}" for i, l in enumerate(lines) if "Navigator.push" in l or "Navigator.of(context).push" in l]
    empty_catch = [f"L{i+1}: {l.strip()}" for i, l in enumerate(lines) if re.search(r"catch\s*\(.*?\)\s*\{\s*\}", l)]
    listview_unbounded = [f"L{i+1}: {l.strip()}" for i, l in enumerate(lines) if re.search(r"ListView\(", l) and "ListView.builder" not in l and "ListView.separated" not in l]

    is_generated = norm_path.endswith(".g.dart")
    is_empty = line_count < 10
    is_entry = norm_path == "lib/main.dart"
    incoming_count = len(imported_by[norm_path])
    is_connected = incoming_count > 0 or is_entry or is_generated

    # Determine status
    if line_count == 0 or (line_count < 15 and "placeholder" in content.lower()):
        status = "❌ فاضي أو placeholder"
        status_code = "EMPTY"
    elif len(todos) > 0 or not is_connected:
        status = "⚠️ موجود بس ناقص أو غير متصل"
        status_code = "PARTIAL"
    else:
        status = "✅ كامل وشغال"
        status_code = "COMPLETE"

    file_audits[norm_path] = {
        'line_count': line_count,
        'status': status,
        'status_code': status_code,
        'is_connected': is_connected,
        'imported_by_count': incoming_count,
        'todos': todos,
        'prints': prints,
        'nav_push': nav_push,
        'empty_catch': empty_catch,
        'listview_unbounded': listview_unbounded,
    }

# Print summaries by section
sections = [
    "lib/core",
    "lib/data/models",
    "lib/data/database/tables",
    "lib/data/database/daos",
    "lib/data/repositories",
    "lib/data/database",
    "lib/features",
    "lib/app",
    "lib/widgets",
    "lib/main.dart"
]

print("\n=== SUMMARY BY SECTION ===")
for sec in sections:
    sec_files = [f for f in file_audits if f.startswith(sec)]
    complete = sum(1 for f in sec_files if file_audits[f]['status_code'] == 'COMPLETE')
    partial = sum(1 for f in sec_files if file_audits[f]['status_code'] == 'PARTIAL')
    empty = sum(1 for f in sec_files if file_audits[f]['status_code'] == 'EMPTY')
    total_lines = sum(file_audits[f]['line_count'] for f in sec_files)
    print(f"\n[{sec}] Files: {len(sec_files)}, Lines: {total_lines}")
    print(f"  Complete: {complete}, Partial/Issues: {partial}, Empty: {empty}")
    for f in sec_files:
        info = file_audits[f]
        print(f"  • {f} ({info['line_count']} lines) -> {info['status']}")

# Global issues dump
print("\n=== GLOBAL CODE ISSUES DETECTED ===")
all_todos = {f: file_audits[f]['todos'] for f in file_audits if file_audits[f]['todos']}
print(f"\nFiles with TODOs: {len(all_todos)}")
for f, td in all_todos.items():
    print(f"- {f}: {td}")

all_prints = {f: file_audits[f]['prints'] for f in file_audits if file_audits[f]['prints']}
print(f"\nFiles with print(): {len(all_prints)}")
for f, pr in all_prints.items():
    print(f"- {f}: {pr}")

all_nav = {f: file_audits[f]['nav_push'] for f in file_audits if file_audits[f]['nav_push']}
print(f"\nFiles with Navigator.push: {len(all_nav)}")
for f, nv in all_nav.items():
    print(f"- {f}: {nv}")

all_disconnected = [f for f in file_audits if not file_audits[f]['is_connected'] and not f.endswith(".g.dart")]
print(f"\nDisconnected files (not imported by anything): {len(all_disconnected)}")
for f in all_disconnected:
    print(f"- {f}")

with open("tools/audit_results.json", "w", encoding="utf-8") as out:
    json.dump(file_audits, out, indent=2, ensure_ascii=False)
print("\nAudit results saved to tools/audit_results.json")
