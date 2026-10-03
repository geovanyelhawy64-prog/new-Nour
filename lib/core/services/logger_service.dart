import 'dart:collection';
import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warning, error }

/// خدمة التسجيل الخفيفة (Local Dual-Level Production Logger)
/// في بيئة التطوير (Debug): طباعة فورية مفصلة
/// في بيئة الإنتاج (Release): تسجيل الأخطاء والتحذيرات الحرجة فقط في مخزن محلي دائري
class LoggerService {
  LoggerService._();

  static const int _maxInMemoryLogs = 100;
  static final Queue<String> _logBuffer = Queue<String>();

  static void debug(String message, [String tag = 'APP']) {
    _log(LogLevel.debug, message, tag);
  }

  static void info(String message, [String tag = 'APP']) {
    _log(LogLevel.info, message, tag);
  }

  static void warning(String message, [String tag = 'APP']) {
    _log(LogLevel.warning, message, tag);
  }

  static void error(
    String message, [
    dynamic tagOrError = 'APP',
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    String tag = 'APP';
    dynamic err = error;
    StackTrace? stack = stackTrace;

    if (tagOrError is String && (error != null || stackTrace != null)) {
      tag = tagOrError;
    } else if (tagOrError != null && tagOrError != 'APP') {
      err = tagOrError;
      if (error is StackTrace) {
        stack = error;
      }
    }
    _log(LogLevel.error, message, tag, err, stack);
  }

  static void _log(LogLevel level, String message, String tag, [dynamic err, StackTrace? stack]) {
    final timestamp = DateTime.now().toIso8601String();
    final logEntry = '[$timestamp] [${level.name.toUpperCase()}] [$tag] $message'
        '${err != null ? ' | Error: $err' : ''}';

    // في Debug: طباعة مباشرة
    if (kDebugMode) {
      debugPrint(logEntry);
      if (stack != null) {
        debugPrint(stack.toString());
      }
    }

    // في Release: تخزين التحذيرات والأخطاء فقط
    if (!kDebugMode && level != LogLevel.debug) {
      if (_logBuffer.length >= _maxInMemoryLogs) {
        _logBuffer.removeFirst();
      }
      _logBuffer.add(logEntry);
    }
  }

  /// استرجاع السجلات الأخيرة لمشاركتها عند حدوث مشكلة
  static List<String> getRecentLogs() {
    return _logBuffer.toList();
  }

  /// تفريغ السجلات
  static void clearLogs() {
    _logBuffer.clear();
  }
}
