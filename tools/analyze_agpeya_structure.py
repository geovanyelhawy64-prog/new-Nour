import zipfile, io, sys
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.primitives import padding

sys.stdout.reconfigure(encoding='utf-8')

z = zipfile.ZipFile('كتب دينية/Katamars+++Orsozoxi_13.7.0_APKPure.zip')
az = zipfile.ZipFile(io.BytesIO(z.read('com.app.orsozoxi.apk')))
ciphertext = az.read('assets/agypa.orso')

iv = b"\x00" * 12 + b"orso"
password = b"1j2e3s4u5s6"

kdf = PBKDF2HMAC(
    algorithm=hashes.SHA1(),
    length=32,
    salt=iv,
    iterations=100,
)
key = kdf.derive(password)

cipher = Cipher(algorithms.AES(key), modes.CBC(iv))
decryptor = cipher.decryptor()
decrypted = decryptor.update(ciphertext) + decryptor.finalize()
unpadder = padding.PKCS7(128).unpadder()
data = unpadder.update(decrypted) + unpadder.finalize()

text = data.decode('utf-8', errors='replace')
lines = text.splitlines()
print(f"Total lines in agypa.orso: {len(lines)}")

# Let's inspect headings / separators
separators = set()
for line in lines:
    if line.startswith('+++') or line.startswith('***') or line.startswith('صَلاةُ') or line.startswith('+++') or line.startswith('+++++'):
        pass

# Let's print lines that look like main section dividers
for i, line in enumerate(lines[:100]):
    if line.strip():
        print(f"{i:4d}: {line}")
