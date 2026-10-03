import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/errors/app_error_handler.dart';
import 'core/services/database_service.dart';
import 'core/services/logger_service.dart';
import 'core/services/notification_service.dart';
import 'core/services/preferences_service.dart';
import 'core/services/widget_service.dart';
import 'widgets/common/startup_error_app.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      AppErrorHandler.install();
      await _bootstrap();
    },
    (error, stack) {
      AppErrorHandler.record(error, stack);
    },
  );
}

Future<void> _bootstrap() async {
  try {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    await PreferencesService.init();
    await DatabaseService.init();

    // الخدمات المساعدة لا يجوز أن تمنع فتح التطبيق عند تعثرها.
    try {
      await NotificationService.init();
      await NotificationService.scheduleDailyVerse();
    } catch (error, stack) {
      LoggerService.error('تعذر تهيئة التنبيهات', error, stack);
    }
    try {
      await WidgetService.updateHomeScreenWidget();
    } catch (error, stack) {
      LoggerService.error('تعذر تحديث ويدجت الشاشة الرئيسية', error, stack);
    }

    runApp(
      const ProviderScope(
        child: NoorApp(),
      ),
    );
  } catch (error, stack) {
    AppErrorHandler.record(error, stack, context: 'Application startup');
    runApp(StartupErrorApp(onRetry: _bootstrap));
  }
}
