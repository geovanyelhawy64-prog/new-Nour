import '../../core/coptic_calendar/coptic_date.dart';
import '../../core/coptic_calendar/rite_determiner.dart';

class CopticDayInfo {
  final CopticDate copticDate;
  final DateTime gregorianDate;
  final DayRiteInfo riteInfo;
  final List<String> synaxariumTitles;
  final String? dailyVerseReference;
  final String? dailyVerseText;

  const CopticDayInfo({
    required this.copticDate,
    required this.gregorianDate,
    required this.riteInfo,
    this.synaxariumTitles = const [],
    this.dailyVerseReference,
    this.dailyVerseText,
  });
}
