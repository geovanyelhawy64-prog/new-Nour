import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/services/preferences_service.dart';
import '../../../../data/database/app_database.dart';

class HymnSyllable {
  final String arabicSyllable;
  final String copticSyllable;
  final int vibratoCount;
  final String pitch;
  final int durationMs;

  const HymnSyllable({
    required this.arabicSyllable,
    required this.copticSyllable,
    required this.vibratoCount,
    required this.pitch,
    required this.durationMs,
  });

  factory HymnSyllable.fromJson(Map<String, dynamic> json) {
    return HymnSyllable(
      arabicSyllable: json['s'] as String? ?? '',
      copticSyllable: json['c'] as String? ?? '',
      vibratoCount: json['v'] as int? ?? 1,
      pitch: json['p'] as String? ?? 'medium',
      durationMs: json['ms'] as int? ?? 800,
    );
  }

  String get pitchLabel {
    switch (pitch) {
      case 'high':
        return 'عالي ⬆';
      case 'low':
        return 'منخفض ⬇';
      case 'ascending':
        return 'صاعد ↗';
      case 'descending':
        return 'هابط ↘';
      case 'medium':
      default:
        return 'متوسط ─';
    }
  }

  Color get pitchColor {
    switch (pitch) {
      case 'high':
        return const Color(0xFFD32F2F);
      case 'low':
        return const Color(0xFF455A64);
      case 'ascending':
        return const Color(0xFF1976D2);
      case 'descending':
        return const Color(0xFFE65100);
      case 'medium':
      default:
        return const Color(0xFF388E3C);
    }
  }

  String get hazatWaves => List.filled(vibratoCount, '〰️').join(' ');
}

enum HymnDisplayLanguage {
  parallel,
  copticOnly,
  phoneticOnly,
  arabicOnly,
}

class HymnViewer extends StatefulWidget {
  final Hymn hymn;
  final List<HymnSegment> segments;

  const HymnViewer({
    super.key,
    required this.hymn,
    required this.segments,
  });

  @override
  State<HymnViewer> createState() => _HymnViewerState();
}

class _HymnViewerState extends State<HymnViewer> {
  late double _fontSize;
  HymnDisplayLanguage _displayLanguage = HymnDisplayLanguage.parallel;
  bool _showHazat = true;
  int _selectedGlobalSyllableIndex = -1;

  final Map<int, List<HymnSyllable>> _segmentSyllables = {};

  @override
  void initState() {
    super.initState();
    _fontSize = PreferencesService.getFontSize();
    _parseAllSyllables();
  }

  @override
  void didUpdateWidget(covariant HymnViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.hymn.id != widget.hymn.id || oldWidget.segments != widget.segments) {
      _parseAllSyllables();
    }
  }

  void _parseAllSyllables() {
    _segmentSyllables.clear();
    _selectedGlobalSyllableIndex = -1;

    for (var segIdx = 0; segIdx < widget.segments.length; segIdx++) {
      final seg = widget.segments[segIdx];
      final List<HymnSyllable> list = [];
      if (seg.syllablesJson != null && seg.syllablesJson!.isNotEmpty) {
        try {
          final decoded = json.decode(seg.syllablesJson!) as List<dynamic>;
          for (var item in decoded) {
            list.add(HymnSyllable.fromJson(item as Map<String, dynamic>));
          }
        } catch (e) {
          debugPrint('Error parsing syllables JSON for segment ${seg.id}: $e');
        }
      }
      _segmentSyllables[segIdx] = list;
    }
  }

  void _increaseFont() {
    if (_fontSize < 36.0) {
      setState(() => _fontSize += 2.0);
      PreferencesService.setFontSize(_fontSize);
    }
  }

  void _decreaseFont() {
    if (_fontSize > 14.0) {
      setState(() => _fontSize -= 2.0);
      PreferencesService.setFontSize(_fontSize);
    }
  }

  void _copySegmentText(HymnSegment segment) {
    final buffer = StringBuffer();
    buffer.writeln('${widget.hymn.nameAr} - الربع ${segment.segmentOrder}');
    if (segment.coptic.isNotEmpty) {
      buffer.writeln('القبطي: ${segment.coptic}');
    }
    if (segment.phonetic.isNotEmpty) {
      buffer.writeln('المعرب: ${segment.phonetic}');
    }
    if (segment.arabic.isNotEmpty) {
      buffer.writeln('المعنى: ${segment.arabic}');
    }

    Clipboard.setData(ClipboardData(text: buffer.toString()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم نسخ الربع إلى الحافظة'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _copyEntireHymn() {
    final buffer = StringBuffer();
    buffer.writeln(widget.hymn.nameAr);
    if (widget.hymn.nameCoptic != null) {
      buffer.writeln(widget.hymn.nameCoptic);
    }
    buffer.writeln('--------------------');
    for (final seg in widget.segments) {
      buffer.writeln('[الربع ${seg.segmentOrder}]');
      if (seg.coptic.isNotEmpty) buffer.writeln(seg.coptic);
      if (seg.phonetic.isNotEmpty) buffer.writeln(seg.phonetic);
      if (seg.arabic.isNotEmpty) buffer.writeln(seg.arabic);
      buffer.writeln();
    }

    Clipboard.setData(ClipboardData(text: buffer.toString()));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم نسخ نص اللحن كاملاً إلى الحافظة'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        // 1. Controls Top Bar (Display modes, Hazat toggle, Font adjustment, Copy all)
        _buildControlsBar(isDark),

        // 2. Pure, Structured Liturgical Reader
        Expanded(
          child: widget.segments.isEmpty
              ? const Center(child: Text('لا توجد مقاطع لهذا اللحن'))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: widget.segments.length,
                  itemBuilder: (context, segIndex) {
                    final segment = widget.segments[segIndex];
                    final syllables = _segmentSyllables[segIndex] ?? [];
                    return _buildSegmentCard(segment, segIndex, syllables, isDark);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildControlsBar(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Display modes chips
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildModeChip('🔀 الكل متوازي', HymnDisplayLanguage.parallel),
                      const SizedBox(width: 6),
                      _buildModeChip('☦️ قبطي أصيل', HymnDisplayLanguage.copticOnly),
                      const SizedBox(width: 6),
                      _buildModeChip('🔤 قبطي معرب', HymnDisplayLanguage.phoneticOnly),
                      const SizedBox(width: 6),
                      _buildModeChip('📖 عربي', HymnDisplayLanguage.arabicOnly),
                    ],
                  ),
                ),
              ),

              // Copy entire hymn
              IconButton(
                icon: const Icon(Icons.copy_all_rounded, size: 20),
                tooltip: 'نسخ نص اللحن كاملاً',
                onPressed: _copyEntireHymn,
              ),

              // Font Zoom Controls
              IconButton(
                icon: const Icon(Icons.text_increase_rounded, size: 20),
                tooltip: 'تكبير الخط',
                onPressed: _increaseFont,
              ),
              IconButton(
                icon: const Icon(Icons.text_decrease_rounded, size: 20),
                tooltip: 'تصغير الخط',
                onPressed: _decreaseFont,
              ),
            ],
          ),
          // Hazat toggle row if any syllables exist
          if (_segmentSyllables.values.any((list) => list.isNotEmpty))
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  FilterChip(
                    avatar: Icon(
                      _showHazat ? Icons.music_note_rounded : Icons.music_off_rounded,
                      size: 16,
                      color: _showHazat ? AppColors.goldDark : null,
                    ),
                    label: Text(
                      _showHazat ? 'إظهار الهزات الموسيقية' : 'إخفاء الهزات الموسيقية',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: _showHazat ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    selected: _showHazat,
                    onSelected: (val) {
                      setState(() => _showHazat = val);
                    },
                    selectedColor: AppColors.goldLight.withValues(alpha: 0.2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  const Spacer(),
                  Text(
                    'الخط: ${_fontSize.toInt()}',
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildModeChip(String label, HymnDisplayLanguage mode) {
    final selected = _displayLanguage == mode;
    return ChoiceChip(
      visualDensity: VisualDensity.compact,
      label: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: selected,
      onSelected: (val) {
        if (val) setState(() => _displayLanguage = mode);
      },
      selectedColor: AppColors.primary.withValues(alpha: 0.15),
      labelStyle: TextStyle(
        color: selected ? AppColors.primary : AppColors.textSecondaryLight,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget _buildSegmentCard(
    HymnSegment segment,
    int segIndex,
    List<HymnSyllable> syllables,
    bool isDark,
  ) {
    final hasHazat = syllables.isNotEmpty;

    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Segment Top Header (Stanza number + copy button + Hazat indicator)
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'الربع ${segment.segmentOrder}',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (hasHazat) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.goldLight.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.library_music_rounded, size: 12, color: AppColors.goldDark),
                        const SizedBox(width: 4),
                        Text(
                          'نوتة هزات',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.copy_rounded, size: 16),
                  tooltip: 'نسخ هذا الربع',
                  visualDensity: VisualDensity.compact,
                  onPressed: () => _copySegmentText(segment),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 1. Coptic Text Section
            if (_displayLanguage == HymnDisplayLanguage.parallel ||
                _displayLanguage == HymnDisplayLanguage.copticOnly) ...[
              if (_displayLanguage == HymnDisplayLanguage.parallel)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    '☦️ النص القبطي الأصيل:',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.goldLight : AppColors.goldDark,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              SelectableText(
                segment.coptic,
                style: AppTypography.coptic.copyWith(
                  fontSize: _fontSize,
                  height: 1.6,
                  color: isDark ? AppColors.copticDark : AppColors.copticLight,
                ),
                textDirection: TextDirection.ltr,
              ),
              const SizedBox(height: 10),
            ],

            // 2. Phonetic (Arabized) Text Section
            if (_displayLanguage == HymnDisplayLanguage.parallel ||
                _displayLanguage == HymnDisplayLanguage.phoneticOnly) ...[
              if (_displayLanguage == HymnDisplayLanguage.parallel)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    '🔤 القبطي المعرب (النطق بحروف عربية):',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: isDark ? const Color(0xFFDFBF7A) : const Color(0xFF8A6B29),
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              SelectableText(
                segment.phonetic,
                style: AppTypography.scripture.copyWith(
                  fontSize: _fontSize - 1,
                  height: 1.6,
                  fontWeight: FontWeight.w600,
                  color: isDark ? const Color(0xFFDFBF7A) : const Color(0xFF8A6B29),
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 10),
            ],

            // 3. Arabic Meaning / Translation Section
            if (_displayLanguage == HymnDisplayLanguage.parallel ||
                _displayLanguage == HymnDisplayLanguage.arabicOnly) ...[
              if (_displayLanguage == HymnDisplayLanguage.parallel)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    '📖 الترجمة والمعنى العربي:',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white60 : Colors.black54,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              SelectableText(
                segment.arabic,
                style: AppTypography.scripture.copyWith(
                  fontSize: _fontSize - 2,
                  height: 1.6,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 12),
            ],

            // 4. Structured Hazat Musical Breakdown Section (Without audio, pure educational notation)
            if (hasHazat && _showHazat) ...[
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.cardDark.withValues(alpha: 0.6)
                      : AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.goldLight.withValues(alpha: 0.4),
                    width: 0.8,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.graphic_eq_rounded, size: 16, color: AppColors.goldDark),
                        const SizedBox(width: 6),
                        Text(
                          'تفريغ وتوزيع الهزات الموسيقية:',
                          style: AppTypography.caption.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.goldDark,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 10,
                      children: List.generate(syllables.length, (sylIdx) {
                        final syl = syllables[sylIdx];
                        final isFocused = _selectedGlobalSyllableIndex == (segIndex * 1000 + sylIdx);
                        return _buildSyllableCard(syl, segIndex, sylIdx, isFocused, isDark);
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSyllableCard(
    HymnSyllable syl,
    int segIndex,
    int sylIdx,
    bool isFocused,
    bool isDark,
  ) {
    final itemKey = segIndex * 1000 + sylIdx;

    return InkWell(
      onTap: () {
        if (PreferencesService.getHapticHazat()) {
          if (syl.vibratoCount >= 4) {
            HapticFeedback.mediumImpact();
          } else {
            HapticFeedback.lightImpact();
          }
        }
        setState(() {
          _selectedGlobalSyllableIndex = isFocused ? -1 : itemKey;
        });
      },
      borderRadius: BorderRadius.circular(10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isFocused
              ? AppColors.goldLight.withValues(alpha: 0.25)
              : (isDark ? AppColors.surfaceDark : Colors.white),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isFocused ? AppColors.goldDark : (isDark ? AppColors.dividerDark : AppColors.dividerLight),
            width: isFocused ? 1.8 : 0.8,
          ),
          boxShadow: isFocused
              ? [
                  BoxShadow(
                    color: AppColors.goldLight.withValues(alpha: 0.3),
                    blurRadius: 6,
                  )
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Syllable text
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  syl.copticSyllable,
                  style: AppTypography.coptic.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isFocused ? AppColors.goldDark : (isDark ? AppColors.copticDark : AppColors.copticLight),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  syl.arabicSyllable,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isFocused ? FontWeight.bold : FontWeight.w500,
                    color: isFocused ? AppColors.primary : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            // Hazat Waves graphic
            Text(
              syl.hazatWaves,
              style: const TextStyle(fontSize: 9),
            ),
            const SizedBox(height: 4),

            // Pitch & vibrato count
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                  decoration: BoxDecoration(
                    color: syl.pitchColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    syl.pitchLabel,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: syl.pitchColor,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${syl.vibratoCount} هزة',
                    style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
