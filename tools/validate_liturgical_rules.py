#!/usr/bin/env python3
"""Validate the signed liturgical-rule registry. Fails closed for release."""

from __future__ import annotations

import argparse
import json
import sys
from datetime import datetime
from pathlib import Path

VALID_STATES = {"draft", "reviewed", "approved"}
REQUIRED_FIELDS = {"id", "title_ar", "category", "condition", "result", "review_status", "enabled_in_release"}


def validate(path: Path, release: bool = False) -> dict:
    payload = json.loads(path.read_text(encoding="utf-8"))
    if payload.get("schema_version") != 1 or not isinstance(payload.get("rules"), list):
        raise ValueError("Unsupported liturgical rules schema")
    ids: set[str] = set()
    counts = {state: 0 for state in VALID_STATES}
    enabled = 0
    errors: list[str] = []
    for index, rule in enumerate(payload["rules"], 1):
        if not isinstance(rule, dict):
            errors.append(f"rule #{index} is not an object")
            continue
        missing = REQUIRED_FIELDS - set(rule)
        if missing:
            errors.append(f"rule #{index} missing fields: {sorted(missing)}")
            continue
        rule_id = rule["id"]
        if not isinstance(rule_id, str) or not rule_id.strip():
            errors.append(f"rule #{index} has invalid id")
            continue
        if rule_id in ids:
            errors.append(f"duplicate rule id: {rule_id}")
        ids.add(rule_id)
        state = rule["review_status"]
        if state not in VALID_STATES:
            errors.append(f"{rule_id}: invalid review_status {state!r}")
            continue
        counts[state] += 1
        is_enabled = rule["enabled_in_release"] is True
        if is_enabled:
            enabled += 1
            missing_approval = [
                field
                for field in ("source_ref", "verified_by", "verified_at")
                if not isinstance(rule.get(field), str) or not rule[field].strip()
            ]
            if state != "approved" or missing_approval:
                errors.append(
                    f"{rule_id}: enabled without signed approval; missing={missing_approval}"
                )
            else:
                try:
                    datetime.fromisoformat(rule["verified_at"].replace("Z", "+00:00"))
                except ValueError:
                    errors.append(f"{rule_id}: verified_at is not ISO-8601")
    if release:
        unsafe = [
            rule["id"]
            for rule in payload["rules"]
            if rule.get("enabled_in_release") is True
            and rule.get("review_status") != "approved"
        ]
        if unsafe:
            errors.append(f"release contains unapproved enabled rules: {unsafe}")
    if errors:
        raise ValueError("\n".join(errors))
    return {"rules": len(ids), "enabled_in_release": enabled, **counts}


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--registry", type=Path, default=Path("assets/data/liturgical_rules.json"))
    parser.add_argument("--release", action="store_true")
    args = parser.parse_args()
    try:
        result = validate(args.registry, args.release)
    except Exception as error:
        print(f"liturgical rules validation failed:\n{error}", file=sys.stderr)
        return 1
    print(json.dumps(result, ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
