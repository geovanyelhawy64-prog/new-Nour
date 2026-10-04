# Noor App - Task Tracking

## Week 1: Foundation (الأسبوع الأول: التأسيس)

- [x] TASK-1.1: Configure pubspec.yaml with all dependencies and assets (pubspec.yaml)
- [x] TASK-1.2: Build Theme and Design System (lib/app/theme/)
- [x] TASK-1.3: Build Coptic Calendar Engine and date conversion (lib/core/coptic_calendar/coptic_date.dart)
- [x] TASK-1.4: Unit test Coptic Date conversions across multiple years (test/core/coptic_calendar_test.dart)
- [x] TASK-1.5: Build Easter & Movable Feasts Calculator (lib/core/coptic_calendar/easter_calculator.dart)
- [x] TASK-1.6: Unit test Easter calculations 2020-2050 (test/core/easter_calculator_test.dart)
- [x] TASK-1.7: Build Rite & Fasting Determiner (lib/core/coptic_calendar/rite_determiner.dart)
- [x] TASK-1.8: Unit test Rite Determination for full liturgical year (test/core/rite_determiner_test.dart)
- [x] TASK-1.9: Build Core Services and Utilities (lib/core/services/, lib/core/utils/, lib/core/constants/)
- [x] TASK-1.10: Build Drift Database Tables and DAOs (lib/data/database/)
- [x] TASK-1.11: Run build_runner code generation and verify zero errors
- [x] TASK-1.12: Build Database Service and Unit Tests (test/data/)

## Week 2: Core UI & Shared Readers (الأسبوع الثاني: واجهات النظام والقارئ المشترك)

- [x] TASK-2.1: Implement GoRouter routing table and routerProvider (lib/app/router.dart)
- [x] TASK-2.2: Implement AppShell and main tabs navigation (lib/widgets/navigation/app_shell.dart)
- [x] TASK-2.3: Build Shared Reader Widgets (text_reader.dart, parallel_reader.dart, role_colored_text.dart)
- [x] TASK-2.4: Build feature screens with sovereign styling (Agpeya, Liturgy, Hymns, Katameros, Synaxarium, etc.)
- [x] TASK-2.5: Write comprehensive App widget test (test/app_test.dart) and verify 25/25 tests pass

## Week 3: Bible Module & Data Extraction (الأسبوع الثالث: الكتاب المقدس واستخراج البيانات)

- [x] TASK-3.1: Complete Bible Presentation & Riverpod State Management (lib/features/bible/)
- [x] TASK-3.2: Build offline SQLite asset database population tools (tools/db_builder/build_database.py)
- [x] TASK-3.3: Extract and populate Holy Bible (SVD) with full Old/New Testament & Deuterocanonical books (73 books, 35,761 verses)
- [x] TASK-3.4: Verify complete Bible database and unit tests (test/data/database_test.dart - 26/26 tests passing)

## Week 4: Agpeya & Khoulagy Modules (الأسبوع الرابع: الأجبية والخولاجي)

- [x] TASK-4.1: Populate remaining canonical hours & psalm texts in SQLite for Agpeya (323 sections, 8 hours, full tashkeel)
- [x] TASK-4.2: Add audio/play status hooks and font scaling preferences in Agpeya reader (lib/features/agpeya/presentation/hour_reader_screen.dart)
- [x] TASK-4.3: Populate full Liturgies (St. Basil, St. Gregory, St. Cyril, Incense) with clerical role switching (125 sections, 1,062 parts)
- [x] TASK-4.4: Implement secret prayers toggle and dynamic Coptic/Arabized/Arabic synchronized view (lib/features/liturgy/presentation/liturgy_reader_screen.dart)

## Week 5: Hymns & Audio Engine (الأسبوع الخامس: الألحان القبطية وهزات أسامة لطفي)

- [x] TASK-5.1: Integrate musical notations from Deacon Osama Lotfy manuscripts (hymns_importer.py, 14 canonical hymns, detailed syllable notations with vibratos and pitch)
- [x] TASK-5.2: Implement syllable-by-syllable interactive hymn reader (HymnViewer, interactive badges, live golden glow highlighting, hazat waves, pitch badges)
- [x] TASK-5.3: Build audio player integration with background playback (AudioService using audioplayers, tempo control, volume, streams)

## Week 6: Synaxarium & Katameros Modules (الأسبوع السادس: السنكسار والقطمارس)

- [x] TASK-6.1: Extract and populate complete Synaxarium (السنكسار القبطي) across all Coptic months (388 days, 881 canonical saint biographies and feast commemorations)
- [x] TASK-6.2: Build Synaxarium Presentation screen with calendar day picker and search (SynaxariumHomeScreen & SynaxariumStoryScreen, type badges, full hagiographies, font zoom)
- [x] TASK-6.3: Extract and populate Katameros (القطمارس) daily readings (366 days, 3,294 canonical readings across Vespers, Matins, Liturgy, Epistles, Gospel)
- [x] TASK-6.4: Build Katameros Reader screen linked dynamically to the current Coptic calendar date (KatamerosReaderScreen with service filters, reference badges, font zoom)

## Week 7: Holy Pascha & Passion Week (الأسبوع السابع: البصخة المقدسة وأسبوع الآلام)

- [x] TASK-7.1: Extract and populate complete Pascha readings and prayers across all hours (Day & Night) for Holy Week (615 readings in assets/databases/noor.db)
- [x] TASK-7.2: Build Pascha presentation screens with hour switcher (Morning/Evening, 1st, 3rd, 6th, 9th, 11th hour) (lib/features/pascha/presentation/)
- [x] TASK-7.3: Implement Pascha liturgical ritual transitions and hymn integration (Thok Te Ti Gom interactive counter, Haptics, test/features/pascha/pascha_test.dart)
## Week 8: Hardening, Architectural Upgrades & Release Packaging (الأسبوع الثامن: التدقيق المعماري وتأمين الإصدار)

- [x] TASK-8.1: Implement Result Pattern with sealed Failure hierarchy (`lib/core/errors/failures.dart`, `lib/core/errors/result.dart`, and unit tests in `test/core/result_test.dart`)
- [x] TASK-8.2: Implement unified `AsyncValueWidget` for resilient Riverpod 3-state UI (`lib/widgets/common/async_value_widget.dart` and 4 widget tests)
- [x] TASK-8.3: Add UI Extensions on Domain Models for sovereign liturgical rendering (`lib/presentation/extensions/model_ui_extensions.dart`)
- [x] TASK-8.4: Implement production dual-level logger (`lib/core/services/logger_service.dart`)
- [x] TASK-8.5: Implement ecclesiastical text verification badge (`lib/widgets/common/verification_badge.dart`)
- [x] TASK-8.6: Centralize ecclesiastical and system strings (`lib/core/constants/app_strings.dart`)
- [x] TASK-8.7: Harden SQLite database asset seeding against corrupt partial copies and configure non-destructive migration (`lib/data/database/app_database.dart`)
- [x] TASK-8.8: Add reading persistence card to Bible Home Screen (`lib/features/bible/presentation/bible_home_screen.dart`)
- [x] TASK-8.9: Implement liturgical text sharing helper with canonical attribution (`lib/core/utils/share_helper.dart`)
- [x] TASK-8.10: 100-Year Easter & Movable Feasts calculation verification (2000-2100) with UTC day comparisons (`test/core/easter_100_years_test.dart`)
## Week 9: Comprehensive Today Hub, Seasonal Katameros & Sovereign UX (الأسبوع التاسع: شاشة اليوم والقراءات الموسمية والبحث المباشر)

- [x] TASK-9.1: Comprehensive Data Audit against official liturgical sources and extraction of complete Seasonal Katameros (Great Lent: 514 readings, Pentecost: 448 readings, Jonah: 33 readings, Sundays: 459 readings -> 4,748 total readings in `noor.db`)
- [x] TASK-9.2: Implement dynamic liturgical reading determination in Katameros DAO (`KatamerosDao.getLiturgicalReadingsForDate`)
- [x] TASK-9.3: Build Smart Context Banner Card with automatic time-of-day contextual greeting and prayer quick-launch (`SmartContextBannerCard`, `SmartTimeContext`)
- [x] TASK-9.4: Build Today Synaxarium Card displaying daily saint commemorations (`TodaySynaxariumCard`)
- [x] TASK-9.5: Build Today Readings Card with real database queries for Gospels and Epistles (`TodayReadingsCard`)
- [x] TASK-9.6: Build Canonical Hours Quick Bar on Today screen (`AgpeyaQuickBarWidget`)
- [x] TASK-9.7: Implement Direct Scripture Reference Resolver parsing abbreviations and numbers (`ScriptureReferenceResolver` + 7 unit tests)
- [x] TASK-9.8: Implement direct jump card and quick navigation in Search (`SearchScreen`)
- [x] TASK-9.9: Implement Comfortable Reader features (Full-Screen Focus mode on text tap, auto-scroll with speed control, inline font zoom) (`ChapterReaderScreen`)
- [x] TASK-9.10: Implement universal 3-dots Quick Menu on all screens with instant Dark/Light mode toggle and developer credit (`AppQuickMenu`)
- [x] TASK-9.11: Redesign bottom navigation to 4 canonical tabs: اليوم | المحتوى | المفضلة | أكثر (`AppShell`, `ContentLibraryScreen`, `MoreHubScreen`)
