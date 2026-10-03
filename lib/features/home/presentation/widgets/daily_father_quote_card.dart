import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../widgets/common/quote_card_dialog.dart';

class DailyFatherQuoteCard extends StatefulWidget {
  const DailyFatherQuoteCard({super.key});

  @override
  State<DailyFatherQuoteCard> createState() => _DailyFatherQuoteCardState();
}

class _DailyFatherQuoteCardState extends State<DailyFatherQuoteCard> {
  static const _quotes = [
    (
      father: 'القديس مار إسحق السرياني',
      quote: '«الصَّلَاةُ هِيَ طَيَرَانُ الْعَقْلِ نَحْوَ اللهِ، وَهِيَ كَنْزٌ لَا يَفْرُغُ وَمِفْتَاحُ مَلَكُوتِ السَّمَاوَاتِ»',
      book: 'ميامر مار إسحق السرياني',
    ),
    (
      father: 'القديس الأنبا أنطونيوس الكبير',
      quote: '«رَأَيْتُ فِخَاخَ إِبْلِيسَ مَبْسُوطَةً عَلَى الأَرْضِ، فَقُلْتُ: يَا رَبُّ مَنْ يَنْجُو مِنْهَا؟ فَسَمِعْتُ صَوْتاً يَقُولُ: التَّوَاضُعُ»',
      book: 'رسائل القديس أنطونيوس',
    ),
    (
      father: 'القديس يوحنا ذهبي الفم',
      quote: '«لَا تُوجَدُ خَطِيَّةٌ تَقْوَى عَلَى مَرَاحِمِ اللهِ؛ فَإِنْ كَانَ الْحُزْنُ عَظِيماً فَنِعْمَةُ الْفِدَاءِ أَعْظَمُ بِمَا لَا يُقَاسُ»',
      book: 'تفسير رسالة رومية',
    ),
    (
      father: 'القديس الشيخ الروحاني (يوحنا سابا)',
      quote: '«حَلَاوَةُ مُنَاجَاةِ اللهِ فِي الْمَخْدَعِ تُطْفِئُ كُلَّ شَهْوَةٍ أَرْضِيَّةٍ، وَتَمْلأُ الْقَلْبَ بَهْجَةً لَا يُنْطَقُ بِهَا وَمَجِيدَةً»',
      book: 'رسائل الشيخ الروحاني',
    ),
    (
      father: 'القديس مقاريوس الكبير',
      quote: '«لَيْسَ بِالضَّرُورَةِ أَنْ تُطِيلَ فِي كَثْرَةِ الْكَلَامِ؛ قُلْ مِنْ عُمْقِ قَلْبِكَ: يَا رَبِّي يَسُوعُ الْمَسِيحُ ارْحَمْنِي وَأَعِنِّي»',
      book: 'عظات القديس مقاريوس',
    ),
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    final dayOfYear = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
    _currentIndex = dayOfYear % _quotes.length;
  }

  void _copyQuote(String father, String text, String source) {
    Clipboard.setData(ClipboardData(text: '$text\n— $father ($source)'));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم نسخ قول الأب القديس إلى الحافظة'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final current = _quotes[_currentIndex];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.surfaceDark
            : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFD84315).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFD84315).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
                  color: Color(0xFFD84315),
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'من أقوال الآباء',
                style: TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFD84315),
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.refresh_rounded, size: 20),
                tooltip: 'قول آخر',
                color: AppColors.textSecondaryLight,
                onPressed: () {
                  setState(() {
                    _currentIndex = (_currentIndex + 1) % _quotes.length;
                  });
                },
                visualDensity: VisualDensity.compact,
              ),
              IconButton(
                icon: const Icon(Icons.copy_rounded, size: 18),
                tooltip: 'نسخ القول',
                color: AppColors.textSecondaryLight,
                onPressed: () => _copyQuote(current.father, current.quote, current.book),
                visualDensity: VisualDensity.compact,
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined, size: 18),
                tooltip: 'مشاركة كبطاقة مصممة',
                color: AppColors.textSecondaryLight,
                onPressed: () => QuoteCardDialog.show(
                  context,
                  text: current.quote,
                  reference: current.father,
                  subtitle: current.book,
                ),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            current.quote,
            style: const TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.8,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            '${current.father} • ${current.book}',
            style: const TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFFD84315),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Center(
            child: TextButton.icon(
              onPressed: () => context.push('/theology/topic/patristics'),
              icon: const Icon(Icons.arrow_forward_rounded, size: 14),
              label: const Text('تصفح بستان أقوال الآباء', style: TextStyle(fontSize: 12)),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFD84315),
                visualDensity: VisualDensity.compact,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
