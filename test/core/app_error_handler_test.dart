import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/core/errors/app_error_handler.dart';
import 'package:noor_app/widgets/common/startup_error_app.dart';

void main() {
  test('خطأ المنصة يعد معالجاً بعد تسجيله', () {
    final handled = AppErrorHandler.handlePlatformError(
      StateError('test failure'),
      StackTrace.current,
    );
    expect(handled, isTrue);
  });

  testWidgets('خطأ بناء الواجهة لا يعرض تفاصيل تقنية', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: QuietErrorWidget())),
    );

    expect(find.textContaining('تعذر عرض هذا الجزء'), findsOneWidget);
    expect(find.textContaining('Exception'), findsNothing);
    expect(find.byType(QuietErrorWidget), findsOneWidget);
  });

  testWidgets('شاشة تعذر البدء تعرض إعادة المحاولة', (tester) async {
    var retries = 0;
    await tester.pumpWidget(
      StartupErrorApp(
        onRetry: () async {
          retries++;
        },
      ),
    );

    expect(find.text('تعذر بدء التطبيق في هذه المرة'), findsOneWidget);
    expect(find.textContaining('بياناتك محفوظة'), findsOneWidget);
    await tester.tap(find.text('المحاولة مرة أخرى'));
    await tester.pump();
    expect(retries, 1);
  });
}
