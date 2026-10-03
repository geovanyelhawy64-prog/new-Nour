import 'dart:async';
import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';

/// ويدجت التحكم بالتمرير التلقائي أثناء القراءة الطويلة
class AutoScrollControl extends StatefulWidget {
  final ScrollController scrollController;
  final VoidCallback? onClose;

  const AutoScrollControl({
    super.key,
    required this.scrollController,
    this.onClose,
  });

  @override
  State<AutoScrollControl> createState() => _AutoScrollControlState();
}

class _AutoScrollControlState extends State<AutoScrollControl> {
  bool _isPlaying = false;
  double _speed = 30.0; // pixels per second
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
    });

    if (_isPlaying) {
      _startAutoScroll();
    } else {
      _timer?.cancel();
    }
  }

  void _startAutoScroll() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!_isPlaying || !mounted) {
        timer.cancel();
        return;
      }

      if (!widget.scrollController.hasClients) return;

      final position = widget.scrollController.position;
      final max = position.maxScrollExtent;
      final current = widget.scrollController.offset;

      if (current >= max) {
        setState(() {
          _isPlaying = false;
        });
        timer.cancel();
        return;
      }

      // Step calculation for 50ms (20 ticks per second)
      final step = _speed / 20.0;
      final nextOffset = (current + step).clamp(0.0, max);
      widget.scrollController.jumpTo(nextOffset);
    });
  }

  void _setSpeed(double speed) {
    setState(() {
      _speed = speed;
    });
    if (_isPlaying) {
      _startAutoScroll();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E2E) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Play / Pause button
          IconButton(
            icon: Icon(
              _isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded,
              color: AppColors.primary,
              size: 36,
            ),
            onPressed: _togglePlay,
            tooltip: _isPlaying ? 'إيقاف مؤقت' : 'بدء التمرير التلقائي',
          ),
          const SizedBox(width: 8),

          // Speed chips
          _speedChip('بطيء', 18.0),
          const SizedBox(width: 4),
          _speedChip('متوسط', 35.0),
          const SizedBox(width: 4),
          _speedChip('سريع', 60.0),

          const SizedBox(width: 8),

          // Close button
          if (widget.onClose != null)
            IconButton(
              icon: const Icon(Icons.close_rounded, size: 20),
              onPressed: () {
                _timer?.cancel();
                widget.onClose!();
              },
              tooltip: 'إغلاق شريط التمرير',
            ),
        ],
      ),
    );
  }

  Widget _speedChip(String label, double speedVal) {
    final isSelected = (_speed - speedVal).abs() < 5;
    return InkWell(
      onTap: () => _setSpeed(speedVal),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.divider,
            width: 0.8,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.caption.copyWith(
            color: isSelected ? Colors.white : null,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}
