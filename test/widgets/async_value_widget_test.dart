import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:noor_app/widgets/common/async_value_widget.dart';
import 'package:noor_app/widgets/common/empty_view.dart';
import 'package:noor_app/widgets/common/error_view.dart';
import 'package:noor_app/widgets/common/loading_view.dart';

void main() {
  group('AsyncValueWidget Tests', () {
    testWidgets('Renders LoadingView when AsyncValue is loading', (tester) async {
      const AsyncValue<List<String>> asyncVal = AsyncLoading();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AsyncValueWidget<List<String>>(
              value: asyncVal,
              data: (context, data) => Text('Data: ${data.length}'),
            ),
          ),
        ),
      );

      expect(find.byType(LoadingView), findsOneWidget);
    });

    testWidgets('Renders ErrorView when AsyncValue has error', (tester) async {
      final AsyncValue<List<String>> asyncVal = AsyncError('خطأ', StackTrace.empty);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AsyncValueWidget<List<String>>(
              value: asyncVal,
              errorMessage: 'تعذر تحميل الصلوات',
              onRetry: () {},
              data: (context, data) => Text('Data: ${data.length}'),
            ),
          ),
        ),
      );

      expect(find.byType(ErrorView), findsOneWidget);
      expect(find.text('تعذر تحميل الصلوات'), findsOneWidget);
      expect(find.text('إعادة المحاولة'), findsOneWidget);
    });

    testWidgets('Renders EmptyView when data is empty and isEmpty returns true', (tester) async {
      const AsyncValue<List<String>> asyncVal = AsyncData([]);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AsyncValueWidget<List<String>>(
              value: asyncVal,
              isEmpty: (list) => list.isEmpty,
              emptyTitle: 'لا توجد نتائج',
              data: (context, data) => Text('Data: ${data.length}'),
            ),
          ),
        ),
      );

      expect(find.byType(EmptyView), findsOneWidget);
      expect(find.text('لا توجد نتائج'), findsOneWidget);
    });

    testWidgets('Renders data widget when data is present', (tester) async {
      const AsyncValue<List<String>> asyncVal = AsyncData(['مزمور ١', 'مزمور ٢']);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AsyncValueWidget<List<String>>(
              value: asyncVal,
              data: (context, data) => Text('العناصر: ${data.join(', ')}'),
            ),
          ),
        ),
      );

      expect(find.text('العناصر: مزمور ١, مزمور ٢'), findsOneWidget);
    });
  });
}
