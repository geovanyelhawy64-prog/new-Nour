#!/usr/bin/env python3
"""Generate one human-verification form per candidate source."""
from __future__ import annotations

import argparse
import json
import re
from pathlib import Path


def safe_name(value: str) -> str:
    return re.sub(r"[^a-zA-Z0-9._-]+", "_", value).strip("_")


def generate(registry: Path, output: Path) -> list[Path]:
    payload = json.loads(registry.read_text(encoding="utf-8"))
    output.mkdir(parents=True, exist_ok=True)
    created: list[Path] = []
    for source in payload.get("sources", []):
        source_id = source["id"]
        path = output / f"{safe_name(source_id)}.md"
        lines = [
            f"# نموذج تحقق المصدر: {source.get('title', source_id)}",
            "",
            "الحالة: مفتوح – لا يُعد هذا النموذج اعتمادًا للنشر.",
            "",
            "## البيانات المرشحة",
            "",
        ]
        for key, value in source.items():
            if key != "notes":
                lines.append(f"- **{key}:** {value if value is not None else 'غير محدد'}")
        lines += [
            "",
            "## مستندات التحقق",
            "",
            "- [ ] صورة صفحة العنوان مرفقة.",
            "- [ ] صورة صفحة بيانات النشر مرفقة.",
            "- [ ] الطبعة والسنة والصفحات مؤكدة.",
            "- [ ] صاحب الحق محدد.",
            "- [ ] خطاب الإذن مرفق أو سبب الإعفاء موثق.",
            "- [ ] الإذن يشمل التخزين والتوزيع داخل تطبيق Offline.",
            "",
            "## قرار المراجع",
            "",
            "- القرار: `pending / approved / rejected`",
            "- اسم المراجع: ____________________",
            "- الجهة: ___________________________",
            "- التاريخ: __________________________",
            "- المرجع/رقم الخطاب: ________________",
            "- ملاحظات: _________________________",
            "",
            "لا يتحول هذا المصدر إلى `approved` في pipeline قبل إرفاق المستندات وتسجيل بيانات المراجع.",
            "",
        ]
        path.write_text("\n".join(lines), encoding="utf-8")
        created.append(path)
    return created


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("registry", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    for path in generate(args.registry, args.output):
        print(path)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
