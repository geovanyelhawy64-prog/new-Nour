import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/string_extensions.dart';

class CopticRhythmHelperDialog extends StatefulWidget {
  const CopticRhythmHelperDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const CopticRhythmHelperDialog(),
    );
  }

  @override
  State<CopticRhythmHelperDialog> createState() => _CopticRhythmHelperDialogState();
}

class _CopticRhythmHelperDialogState extends State<CopticRhythmHelperDialog>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = false;
  int _bpm = 90; // Default tempo
  int _currentBeat = 0;
  final int _totalBeats = 4; // 4/4 time
  Timer? _tickerTimer;

  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _tickerTimer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  void _togglePlay() {
    if (_isPlaying) {
      _stop();
    } else {
      _start();
    }
  }

  void _start() {
    setState(() {
      _isPlaying = true;
      _currentBeat = 0;
    });
    _scheduleNextTick();
  }

  void _stop() {
    _tickerTimer?.cancel();
    if (mounted) {
      setState(() {
        _isPlaying = false;
        _currentBeat = 0;
      });
    }
  }

  void _scheduleNextTick() {
    _tickerTimer?.cancel();
    if (!_isPlaying) return;

    final intervalMs = (60000 / _bpm).round();
    _tickerTimer = Timer(Duration(milliseconds: intervalMs), () {
      if (!mounted || !_isPlaying) return;

      setState(() {
        _currentBeat = (_currentBeat + 1) % _totalBeats;
      });

      _animController.forward(from: 0.0);

      // نقرة الدف (Downbeat) قوية، ونقرة المثلث خفيفة
      if (_currentBeat == 0) {
        HapticFeedback.heavyImpact();
        SystemSound.play(SystemSoundType.click);
      } else {
        HapticFeedback.lightImpact();
      }

      _scheduleNextTick();
    });
  }

  void _manualTap(bool isCymbals) {
    _animController.forward(from: 0.0);
    if (isCymbals) {
      HapticFeedback.heavyImpact();
      SystemSound.play(SystemSoundType.click);
    } else {
      HapticFeedback.lightImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E26) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // مقبض السحب
              Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),

              // العنوان
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.music_note_rounded, color: AppColors.gold, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    'محاكي الدف والمثلث الكنسي',
                    style: AppTypography.heading3.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'لضبط وزن وهزات الألحان والتسبيح وفق طقس الكنيسة القبطية',
                style: AppTypography.caption.copyWith(color: AppColors.textSecondaryLight),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // مؤشر النبضات الإيقاعية الأربعة (الدم والتك)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_totalBeats, (index) {
                  final isActive = _isPlaying && _currentBeat == index;
                  final isDownbeat = index == 0;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 120),
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: isActive ? 44 : 36,
                    height: isActive ? 44 : 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive
                          ? (isDownbeat ? AppColors.gold : AppColors.primary)
                          : (isDark
                              ? Colors.white.withValues(alpha: 0.1)
                              : Colors.grey.withValues(alpha: 0.2)),
                      border: Border.all(
                        color: isDownbeat ? AppColors.gold : AppColors.primary.withValues(alpha: 0.5),
                        width: isActive ? 2.5 : 1.0,
                      ),
                      boxShadow: isActive
                          ? [
                              BoxShadow(
                                color: (isDownbeat ? AppColors.gold : AppColors.primary)
                                    .withValues(alpha: 0.6),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        isDownbeat ? 'دُم' : 'تَك',
                        style: TextStyle(
                          fontSize: isActive ? 13 : 11,
                          fontWeight: FontWeight.bold,
                          color: isActive
                              ? Colors.white
                              : (isDark ? Colors.white70 : Colors.black87),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // التحكم في السرعة (BPM)
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: 8,
                children: [
                  Text(
                    'السرعة: ${_bpm.arabicDigits} نبضة/دقيقة',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Preset بطيء / حزايني
                      _buildPresetChip('حزايني (٦٠)', 60),
                      const SizedBox(width: 6),
                      // Preset سنوي
                      _buildPresetChip('سنوي (٩٠)', 90),
                      const SizedBox(width: 6),
                      // Preset فرايحي / دمج
                      _buildPresetChip('دمج (١٣٠)', 130),
                    ],
                  ),
                ],
              ),
              Slider(
                value: _bpm.toDouble(),
                min: 40,
                max: 180,
                divisions: 28,
                activeColor: AppColors.gold,
                onChanged: (val) {
                  setState(() => _bpm = val.round());
                  if (_isPlaying) {
                    _scheduleNextTick();
                  }
                },
              ),
              const SizedBox(height: 12),

              // زر تشغيل / إيقاف المترونوم التلقائي
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isPlaying ? Colors.red : AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                icon: Icon(_isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_filled_rounded),
                label: Text(
                  _isPlaying ? 'إيقاف الإيقاع التلقائي' : 'تشغيل الإيقاع التلقائي (المترونوم)',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                onPressed: _togglePlay,
              ),

              const SizedBox(height: 20),
              const Divider(height: 1),
              const SizedBox(height: 16),

              // وسادات النقر اليدوي (Manual Tapping Pads)
              Text(
                'أو انقر يدوياً للمزامنة مع ترتيل اللحن:',
                style: AppTypography.caption.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  // وسادة الدف (Cymbals)
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () => _manualTap(true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFE5A93C), Color(0xFFC78B23)],
                          ),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFC78B23).withValues(alpha: 0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Column(
                          children: [
                            Icon(Icons.album_rounded, color: Colors.white, size: 36),
                            SizedBox(height: 6),
                            Text(
                              'نقر الدف (دُم)',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // وسادة المثلث (Triangle)
                  Expanded(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () => _manualTap(false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF78909C), Color(0xFF546E7A)],
                          ),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF546E7A).withValues(alpha: 0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Column(
                          children: [
                            Icon(Icons.change_history_rounded, color: Colors.white, size: 36),
                            SizedBox(height: 6),
                            Text(
                              'نقر المثلث (تَك)',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPresetChip(String label, int targetBpm) {
    final isSelected = _bpm == targetBpm;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        setState(() => _bpm = targetBpm);
        if (_isPlaying) _scheduleNextTick();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary
              : AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }
}
