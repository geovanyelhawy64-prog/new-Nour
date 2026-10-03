import re
import unittest
from pathlib import Path


EMOJI = re.compile('[\U0001F300-\U0001FAFF\u2600-\u27BF]')


class RepositoryPolicyTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.root = Path(__file__).resolve().parents[2]

    def test_flutter_interface_contains_no_emoji(self):
        violations = []
        for path in (self.root / 'lib').rglob('*.dart'):
            for line_number, line in enumerate(path.read_text().splitlines(), 1):
                if EMOJI.search(line):
                    violations.append(f'{path.relative_to(self.root)}:{line_number}')
        self.assertEqual(violations, [], '\n'.join(violations))

    def test_deferred_kids_feature_is_not_shipped(self):
        self.assertFalse((self.root / 'lib/features/kids').exists())
        router = (self.root / 'lib/app/router.dart').read_text()
        self.assertNotIn("'/kids'", router)

    def test_navigation_and_library_have_the_fixed_information_architecture(self):
        shell = (self.root / 'lib/widgets/navigation/app_shell.dart').read_text()
        for label in ('الرئيسية', 'المكتبة', 'البحث', 'المحفوظات'):
            self.assertIn(f"label: '{label}'", shell)
        for old_label in ("label: 'الكتاب'", "label: 'الألحان'", "label: 'المزيد'"):
            self.assertNotIn(old_label, shell)

        library = (self.root / 'lib/features/content_library/presentation/library_portals_screen.dart').read_text()
        portal_blocks = re.findall(
            r'LibraryPortal\((.*?)(?=\n    LibraryPortal\(|\n  \];)',
            library,
            re.S,
        )
        self.assertEqual(len(portal_blocks), 4)
        item_counts = [len(re.findall(r'LibraryItem\(', block)) for block in portal_blocks]
        self.assertTrue(all(4 <= count <= 6 for count in item_counts), item_counts)

    def test_local_update_binaries_are_not_versioned(self):
        self.assertFalse((self.root / 'sqlite3.dll').exists())
        self.assertFalse((self.root / 'update_phone.bat').exists())

    def test_signing_secrets_are_absent(self):
        secret_names = {'key.properties'}
        secret_suffixes = {'.jks', '.keystore', '.p12', '.pem'}
        found = [
            str(path.relative_to(self.root))
            for path in self.root.rglob('*')
            if path.is_file()
            and (path.name in secret_names or path.suffix.lower() in secret_suffixes)
            and '.git' not in path.parts
        ]
        self.assertEqual(found, [])


if __name__ == '__main__':
    unittest.main()
