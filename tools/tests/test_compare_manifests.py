import unittest

from tools.compare_manifests import compare


class CompareManifestsTest(unittest.TestCase):
    def manifest(self, checksum='a', source_checksum='s', count=1, provenance=None):
        return {
            'content_db': {
                'sha256': checksum,
                'source_registry_sha256': source_checksum,
                'table_counts': {'bible_verses': count},
                'provenance': provenance or {},
            }
        }

    def test_identical_manifests_have_no_changes(self):
        value = self.manifest()
        self.assertEqual(compare(value, value), [])

    def test_reports_all_release_relevant_changes(self):
        changes = compare(
            self.manifest(),
            self.manifest(checksum='b', source_checksum='t', count=2,
                          provenance={'bible_verses': {'source:approved': 2}}),
        )
        self.assertIn('content database checksum changed', changes)
        self.assertIn('source registry checksum changed', changes)
        self.assertIn('bible_verses: 1 -> 2', changes)
        self.assertIn('content provenance changed', changes)


if __name__ == '__main__':
    unittest.main()
