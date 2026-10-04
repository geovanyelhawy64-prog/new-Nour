import os
import re
import sys
import io

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')

# 1. Routes in router.dart
with open('lib/app/router.dart', encoding='utf-8') as f:
    router_text = f.read()

route_matches = re.findall(r"path:\s*['\"]([^'\"]+)['\"]", router_text)
print(f"Total registered route paths in router.dart: {len(route_matches)}")
for r in route_matches:
    print(f"  • {r}")

# 2. Screens in lib/
screen_files = []
for root, dirs, files in os.walk('lib'):
    for f in files:
        if f.endswith('_screen.dart'):
            screen_files.append(os.path.join(root, f).replace('\\', '/'))

print(f"\nTotal Screen files in lib: {len(screen_files)}")
for s in sorted(screen_files):
    print(f"  • {s}")

# 3. DAOs in lib/data/database/daos/
dao_files = [os.path.join('lib/data/database/daos', f).replace('\\', '/') 
             for f in os.listdir('lib/data/database/daos') if f.endswith('.dart') and not f.endswith('.g.dart')]
print(f"\nTotal DAOs in lib: {len(dao_files)}")
for d in sorted(dao_files):
    print(f"  • {d}")

# 4. Repositories in lib/data/repositories/
repo_files = [os.path.join('lib/data/repositories', f).replace('\\', '/') 
              for f in os.listdir('lib/data/repositories') if f.endswith('.dart')]
print(f"\nTotal Repositories in lib: {len(repo_files)}")
for r in sorted(repo_files):
    print(f"  • {r}")

# 5. Providers in lib/
provider_files = []
for root, dirs, files in os.walk('lib'):
    for f in files:
        if 'provider' in f.lower() and f.endswith('.dart') and not f.endswith('.g.dart'):
            provider_files.append(os.path.join(root, f).replace('\\', '/'))
print(f"\nTotal Provider files in lib: {len(provider_files)}")
for p in sorted(provider_files):
    print(f"  • {p}")

