audit:
	python tools/audit_database.py
ingest:
	python tools/ingest_all.py
reconcile:
	python tools/reconcile.py --all
coverage:
	python tools/coverage_matrix.py
validate:
	python tools/validate_content.py
review:
	python tools/export_review_sheets.py
build-dev:
	python tools/build_content_db.py --dev
build-rel:
	python tools/build_content_db.py --release
verify: validate build-dev
	flutter analyze && flutter test
