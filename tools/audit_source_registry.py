#!/usr/bin/env python3
"""Report incomplete source records without approving or changing them."""
from __future__ import annotations

import argparse
import json
from pathlib import Path

REQUIRED = ("id", "category", "title", "authority_level", "rights_status")


def audit(path: Path) -> list[str]:
    payload = json.loads(path.read_text(encoding="utf-8"))
    issues: list[str] = []
    sources = payload.get("sources")
    if not isinstance(sources, list):
        return ["sources must be a list"]
    ids: set[str] = set()
    for index, source in enumerate(sources):
        prefix = f"sources[{index}]"
        if not isinstance(source, dict):
            issues.append(f"{prefix}: must be an object")
            continue
        for field in REQUIRED:
            if not isinstance(source.get(field), str) or not source[field].strip():
                issues.append(f"{prefix}: missing {field}")
        if source.get("authority_level") in {"primary_church_edition", "claimed_primary"}:
            for field in ("publisher", "edition"):
                if not isinstance(source.get(field), str) or not source[field].strip():
                    issues.append(f"{prefix}: {field} required for primary source")
        if source.get("rights_status") == "unknown":
            issues.append(f"{prefix}: rights_status must be resolved before release")
        source_id = source.get("id")
        if source_id in ids:
            issues.append(f"{prefix}: duplicate id {source_id}")
        ids.add(source_id)
        if source.get("rights_status") in {"written_permission", "claimed_permission_unverified"} and not source.get("permission_reference"):
            issues.append(f"{prefix}: permission_reference required for claimed permission")
    return issues


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("registry", type=Path)
    args = parser.parse_args()
    issues = audit(args.registry)
    if issues:
        print("Source registry needs verification:")
        print("\n".join(f"- {issue}" for issue in issues))
        return 1
    print("Source registry structure is complete; legal/church approval is still required.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
