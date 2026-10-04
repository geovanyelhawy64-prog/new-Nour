-- Noor content schema v2 — النموذج القانوني للبيانات
-- كل سجل محتوى يحمل: origin, source_id, source_page, review_status,
-- verified_by, verified_at, critical, content_version.
-- لا يُنشر إلا ما review_status = 'approved'.

CREATE TABLE IF NOT EXISTS sources (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  author TEXT,
  edition TEXT,
  publisher TEXT,
  year INTEGER,
  pages INTEGER,
  isbn TEXT,
  license TEXT,
  permission_ref TEXT,
  permission_status TEXT NOT NULL DEFAULT 'unknown'  -- granted|pending|denied|unknown
);

-- الأعمدة المشتركة لكل جدول محتوى (تُضاف لكل جدول):
--   id TEXT PRIMARY KEY,
--   origin TEXT NOT NULL CHECK(origin IN ('printed','reference','authored','unknown')),
--   source_id TEXT REFERENCES sources(id),
--   source_page TEXT,
--   review_status TEXT NOT NULL DEFAULT 'draft'
--     CHECK(review_status IN ('draft','diff_checked','reviewed','approved')),
--   verified_by TEXT,
--   verified_at TEXT,
--   critical INTEGER NOT NULL DEFAULT 0,
--   content_version INTEGER NOT NULL DEFAULT 1

-- القراءات مرجعاً لا نصاً:
CREATE TABLE IF NOT EXISTS readings (
  id TEXT PRIMARY KEY,
  calendar_rule TEXT NOT NULL,   -- fixed:coptic:2-7 | movable:easter:-7 | weekly:sun | season:lent:wk3:sun
  service TEXT NOT NULL,         -- vespers|matins|liturgy
  slot TEXT NOT NULL,            -- pauline|catholic|acts|psalm|gospel|synaxarium
  ref_book TEXT, ref_start TEXT, ref_end TEXT,
  translation_id TEXT,
  origin TEXT NOT NULL,
  source_id TEXT REFERENCES sources(id),
  source_page TEXT,
  review_status TEXT NOT NULL DEFAULT 'draft',
  verified_by TEXT, verified_at TEXT,
  critical INTEGER NOT NULL DEFAULT 0,
  content_version INTEGER NOT NULL DEFAULT 1
);

-- قواعد التقويم كبيانات:
CREATE TABLE IF NOT EXISTS liturgical_rules (
  rule_id TEXT PRIMARY KEY,
  condition_expr TEXT NOT NULL,
  result TEXT NOT NULL,
  source_id TEXT REFERENCES sources(id),
  source_page TEXT,
  reviewer TEXT,
  review_status TEXT NOT NULL DEFAULT 'draft'
);

-- طبقات اللغة في النص الواحد: text_ar, text_cop, text_cop_arabized
-- الأدوار الطقسية: role IN ('كاهن','شماس','شعب','إرشاد طقسي','سري')
