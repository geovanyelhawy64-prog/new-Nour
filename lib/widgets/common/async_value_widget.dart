import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'empty_view.dart';
import 'error_view.dart';
import 'loading_view.dart';

/// ويدجت موحدة لمعالجة الحالات الثلاث (Loading / Error + Retry / Empty / Data)
/// لأي مزود حالة Riverpod AsyncValue، مانعةً لتكرار الكود عبر شاشات التطبيق
class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(BuildContext context, T data) data;
  final bool Function(T data)? isEmpty;
  final String? emptyTitle;
  final String? emptySubtitle;
  final IconData? emptyIcon;
  final Widget? emptyWidget;
  final String? loadingMessage;
  final String? errorMessage;
  final VoidCallback? onRetry;

  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.isEmpty,
    this.emptyTitle,
    this.emptySubtitle,
    this.emptyIcon,
    this.emptyWidget,
    this.loadingMessage,
    this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: (d) {
        if (isEmpty != null && isEmpty!(d)) {
          if (emptyWidget != null) return emptyWidget!;
          return EmptyView(
            message: emptyTitle ?? 'لا توجد بيانات متاحة',
            subtitle: emptySubtitle,
            icon: emptyIcon ?? Icons.auto_stories_outlined,
            action: onRetry != null
                ? ElevatedButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    label: const Text('تحديث'),
                  )
                : null,
          );
        }
        return data(context, d);
      },
      loading: () => LoadingView(
        message: loadingMessage,
      ),
      error: (error, stackTrace) => ErrorView(
        message: errorMessage ?? 'حدث خطأ غير متوقع أثناء استرجاع البيانات',
        onRetry: onRetry,
      ),
    );
  }
}
