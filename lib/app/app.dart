import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/errors/app_error_handler.dart';
import '../core/services/preferences_service.dart';
import 'router.dart';
import 'theme/app_theme.dart';

enum AppThemeType {
  system,
  light,
  dark,
  sepia,
  amoled,
}

class NoorApp extends ConsumerWidget {
  const NoorApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeType = ref.watch(appThemeProvider);
    final platformBrightness = MediaQuery.platformBrightnessOf(context);
    final isPlatformDark = platformBrightness == Brightness.dark;

    ThemeData activeTheme;
    switch (themeType) {
      case AppThemeType.light:
        activeTheme = AppTheme.light();
        break;
      case AppThemeType.dark:
        activeTheme = AppTheme.dark();
        break;
      case AppThemeType.sepia:
        activeTheme = AppTheme.sepia();
        break;
      case AppThemeType.amoled:
        activeTheme = AppTheme.amoled();
        break;
      case AppThemeType.system:
        activeTheme = isPlatformDark ? AppTheme.dark() : AppTheme.light();
        break;
    }

    return MaterialApp.router(
      title: 'Noor',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: activeTheme,
      locale: const Locale('ar', 'EG'),
      builder: (context, child) {
        final media = MediaQuery.of(context);
        final content = Directionality(
          textDirection: TextDirection.rtl,
          child: Semantics(
            container: true,
            child: child ?? const QuietErrorWidget(),
          ),
        );
        return MediaQuery(
          data: media.copyWith(
            textScaler: media.textScaler.clamp(
              minScaleFactor: 1,
              maxScaleFactor: 1.6,
            ),
          ),
          child: content,
        );
      },
    );
  }
}

// بروفايدر نمط الثيم المتقدم (فاتح / داكن / سيبيا / أموليد / تلقائي)
final appThemeProvider = StateProvider<AppThemeType>((ref) {
  final saved = PreferencesService.getThemeMode();
  switch (saved) {
    case 'light':
      return AppThemeType.light;
    case 'dark':
      return AppThemeType.dark;
    case 'sepia': // ترحيل اسم الوضع القديم إلى الوضع النهاري.
      return AppThemeType.light;
    case 'amoled':
      return AppThemeType.amoled;
    default:
      return AppThemeType.system;
  }
});

// بروفايدر وضع الثيم للتوافقية الكاملة
final themeModeProvider = StateProvider<ThemeMode>((ref) {
  final appTheme = ref.watch(appThemeProvider);
  switch (appTheme) {
    case AppThemeType.light:
    case AppThemeType.sepia:
      return ThemeMode.light;
    case AppThemeType.dark:
    case AppThemeType.amoled:
      return ThemeMode.dark;
    case AppThemeType.system:
      return ThemeMode.system;
  }
});
