import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../services/logger_service.dart';

/// نقطة مركزية للأخطاء غير المعالجة.
///
/// لا ترسل هذه الخدمة أي بيانات إلى الشبكة. السجل محلي ودائري فقط.
class AppErrorHandler {
  AppErrorHandler._();

  static bool _installed = false;

  static void install() {
    if (_installed) return;
    _installed = true;

    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      record(
        details.exception,
        details.stack ?? StackTrace.current,
        context: details.context?.toDescription() ?? 'Flutter framework',
      );
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      record(error, stack, context: 'Platform dispatcher');
      return true;
    };

    ErrorWidget.builder = (details) {
      record(
        details.exception,
        details.stack ?? StackTrace.current,
        context: 'Widget build',
      );
      return const QuietErrorWidget();
    };
  }

  static void record(
    Object error,
    StackTrace stack, {
    String context = 'Uncaught zone',
  }) {
    LoggerService.error('خطأ غير معالج: $context', error, stack);
  }

  @visibleForTesting
  static bool handlePlatformError(Object error, StackTrace stack) {
    record(error, stack, context: 'Platform dispatcher');
    return true;
  }
}

class QuietErrorWidget extends StatelessWidget {
  const QuietErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Semantics(
            liveRegion: true,
            label: 'تعذر عرض هذا الجزء',
            child: Text(
              'تعذر عرض هذا الجزء. يمكنك الرجوع والمحاولة مرة أخرى.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
