import json
import tempfile
import unittest
from pathlib import Path

from tools.audit_source_registry import audit


class SourceRegistryAuditTest(unittest.TestCase):
    def test_reports_missing_permission_reference(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'sources.json'
            path.write_text(json.dumps({
                'sources': [{
                    'id': 'bible.test',
                    'category': 'bible',
                    'title': 'Bible',
                    'authority_level': 'primary_church_edition',
                    'rights_status': 'claimed_permission_unverified',
                }],
            }), encoding='utf-8')
            issues = audit(path)
        self.assertIn('permission_reference required for claimed permission', issues[0])

    def test_accepts_structurally_complete_source(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'sources.json'
            path.write_text(json.dumps({
                'sources': [{
                    'id': 'bible.test',
                    'category': 'bible',
                    'title': 'Bible',
                    'authority_level': 'primary_church_edition',
                    'rights_status': 'written_permission',
                    'permission_reference': 'letter-1',
                }],
            }), encoding='utf-8')
            self.assertEqual(audit(path), [])


if __name__ == '__main__':
    unittest.main()
