#!/usr/bin/env python3
"""Compare two Noor content manifests and report provenance changes."""
from __future__ import annotations

import argparse
import json
from pathlib import Path


def load(path: Path) -> dict:
    with path.open(encoding="utf-8") as stream:
        value = json.load(stream)
    if not isinstance(value, dict) or "content_db" not in value:
        raise ValueError(f"Invalid content manifest: {path}")
    return value


def compare(old: dict, new: dict) -> list[str]:
    old_db = old["content_db"]
    new_db = new["content_db"]
    changes: list[str] = []
    if old_db.get("sha256") != new_db.get("sha256"):
        changes.append("content database checksum changed")
    if old_db.get("source_registry_sha256") != new_db.get("source_registry_sha256"):
        changes.append("source registry checksum changed")
    old_counts = old_db.get("table_counts", {})
    new_counts = new_db.get("table_counts", {})
    for table in sorted(set(old_counts) | set(new_counts)):
        if old_counts.get(table) != new_counts.get(table):
            changes.append(
                f"{table}: {old_counts.get(table, 0)} -> {new_counts.get(table, 0)}"
            )
    if old_db.get("provenance") != new_db.get("provenance"):
        changes.append("content provenance changed")
    return changes


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("old", type=Path)
    parser.add_argument("new", type=Path)
    args = parser.parse_args()
    for change in compare(load(args.old), load(args.new)):
        print(change)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
