import os
import sys
import zipfile

if sys.platform == 'win32':
    sys.stdout.reconfigure(encoding='utf-8')

# Remove any old temp zips
for old in ['noor_project_essential.zip', 'Noor_App_Source.zip']:
    if os.path.exists(old):
        os.remove(old)

zip_filename = 'Noor_App_Source.zip'

include_dirs = ['lib', 'assets', 'android', 'test', 'tools', 'windows', 'web', 'linux', 'macos']
include_files = [
    'pubspec.yaml',
    'pubspec.lock',
    'analysis_options.yaml',
    'README.md',
    'EXECUTION_PLAN.md',
    '.gitignore',
    '.gitattributes',
    'sqlite3.dll',
    'update_phone.bat'
]

total_files = 0
total_uncompressed = 0

print(f"Creating optimized archive '{zip_filename}'...")

with zipfile.ZipFile(zip_filename, 'w', compression=zipfile.ZIP_DEFLATED, compresslevel=9) as zf:
    for f in include_files:
        if os.path.exists(f):
            zf.write(f)
            total_files += 1
            total_uncompressed += os.path.getsize(f)
    
    for d in include_dirs:
        for root, dirs, files in os.walk(d):
            # Exclude build and gradle cache directories
            norm_root = root.replace('\\', '/')
            if any(skip in norm_root for skip in ['/build', '/.gradle', '/.dart_tool', '/obj', '/bin', 'tools/__pycache__']):
                continue
            for file in files:
                file_path = os.path.join(root, file)
                zf.write(file_path)
                total_files += 1
                total_uncompressed += os.path.getsize(file_path)

final_size_bytes = os.path.getsize(zip_filename)
final_size_mb = final_size_bytes / (1024 * 1024)

print('=============================================')
print(f'Archive Name: {zip_filename}')
print(f'Total Files: {total_files}')
print(f'Uncompressed Size: {total_uncompressed / (1024*1024):.2f} MB')
print(f'Final ZIP Size: {final_size_mb:.2f} MB')
print(f'Space Saved: {(1 - final_size_bytes / total_uncompressed) * 100:.1f}%')
if final_size_mb <= 15.0:
    print('Result: SUCCESS (Under 15 MB limit)')
else:
    print('Result: WARNING (Exceeds 15 MB limit)')
print('=============================================')
