import 'dart:async';
import 'package:flutter/widgets.dart';
import '../../../core/services/preferences_service.dart';

/// متحكم موحد لتكبير/تصغير النص في شاشات القراءة
class ReaderZoomController {
  final VoidCallback onChanged;
  final double minFontSize;
  final double maxFontSize;

  late double fontSize;
  late double baseFontSize;
  bool showIndicator = false;
  Timer? _indicatorTimer;

  ReaderZoomController({
    required this.onChanged,
    this.minFontSize = 14,
    this.maxFontSize = 36,
  }) {
    fontSize = PreferencesService.getFontSize();
    baseFontSize = fontSize;
  }

  void onScaleStart() {
    baseFontSize = fontSize;
  }

  void onScaleUpdate(ScaleUpdateDetails details) {
    if (details.pointerCount < 2) return;
    final newSize = (baseFontSize * details.scale).clamp(minFontSize, maxFontSize);
    if ((newSize - fontSize).abs() >= 0.5) {
      fontSize = newSize;
      showIndicator = true;
      onChanged();
      _indicatorTimer?.cancel();
      _indicatorTimer = Timer(const Duration(milliseconds: 1000), () {
        showIndicator = false;
        onChanged();
      });
      PreferencesService.setFontSize(fontSize);
    }
  }

  void zoomIn() => _bump(2);
  void zoomOut() => _bump(-2);

  void _bump(double delta) {
    fontSize = (fontSize + delta).clamp(minFontSize, maxFontSize);
    onChanged();
    PreferencesService.setFontSize(fontSize);
  }

  void dispose() {
    _indicatorTimer?.cancel();
  }
}
