import json
import tempfile
import unittest
from pathlib import Path

from tools.validate_liturgical_rules import validate


class LiturgicalRulesTest(unittest.TestCase):
    def test_project_registry_is_valid_and_ships_no_unapproved_rule(self):
        root = Path(__file__).resolve().parents[2]
        result = validate(root / 'assets/data/liturgical_rules.json', release=True)
        self.assertEqual(result['enabled_in_release'], 0)
        self.assertGreater(result['draft'], 0)

    def test_enabled_rule_requires_source_reviewer_and_date(self):
        payload = {
            'schema_version': 1,
            'rules': [{
                'id': 'rite.test',
                'title_ar': 'قاعدة اختبار',
                'category': 'ecclesiastical_rubric',
                'condition': 'شرط',
                'result': 'نتيجة',
                'review_status': 'approved',
                'source_ref': None,
                'verified_by': None,
                'verified_at': None,
                'enabled_in_release': True,
            }],
        }
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'rules.json'
            path.write_text(json.dumps(payload), encoding='utf-8')
            with self.assertRaisesRegex(ValueError, 'enabled without signed approval'):
                validate(path, release=True)


if __name__ == '__main__':
    unittest.main()
