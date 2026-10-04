import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';
import '../../core/services/logger_service.dart';

class VerseImageShareDialog extends StatefulWidget {
  final String text;
  final String reference;
  final String? subtitle;

  const VerseImageShareDialog({
    super.key,
    required this.text,
    required this.reference,
    this.subtitle,
  });

  static Future<void> show(
    BuildContext context, {
    required String text,
    required String reference,
    String? subtitle,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => VerseImageShareDialog(
        text: text,
        reference: reference,
        subtitle: subtitle,
      ),
    );
  }

  @override
  State<VerseImageShareDialog> createState() => _VerseImageShareDialogState();
}

class _VerseImageShareDialogState extends State<VerseImageShareDialog> {
  final GlobalKey _repaintBoundaryKey = GlobalKey();
  bool _isSharing = false;
  bool _isDarkStyle = true;

  Future<void> _shareAsImage() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    HapticFeedback.lightImpact();

    try {
      // الانتظار لدورة رسم لضمان جاهزية الـ RenderObject
      await Future<void>.delayed(const Duration(milliseconds: 100));

      final boundary = _repaintBoundaryKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;

      if (boundary == null) {
        throw Exception('RenderRepaintBoundary is not available');
      }

      final width = boundary.size.width;
      // ضبط الـ pixelRatio لإنتاج دقة 1080x1080 بالتمام
      final pixelRatio = width > 0 ? (1080.0 / width) : 3.0;

      final ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
      final ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) {
        throw Exception('Failed to convert image to bytes');
      }

      final Uint8List pngBytes = byteData.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final filePath =
          '${tempDir.path}/noor_verse_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File(filePath);
      await file.writeAsBytes(pngBytes);

      if (mounted) {
        await SharePlus.instance.share(
          ShareParams(
            files: [XFile(file.path, mimeType: 'image/png')],
            text: '« ${widget.text} »\n— ${widget.reference}\n\n✝ تطبيق نـور الأرثوذكسي ✝',
          ),
        );
      }
    } catch (e, st) {
      LoggerService.error('فشل توليد ومشاركة صورة الآية', e, st);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تعذر تصدير الصورة، جاري نسخ النص بدلاً منها'),
            backgroundColor: Colors.red,
          ),
        );
        Clipboard.setData(ClipboardData(
          text: '« ${widget.text} »\n— ${widget.reference}',
        ));
      }
    } finally {
      if (mounted) {
        setState(() => _isSharing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardSize = (screenWidth - 48).clamp(300.0, 420.0);

    return  Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 1. بطاقة الآية القبطية المربعة (1080x1080 Target)
              RepaintBoundary(
                key: _repaintBoundaryKey,
                child: SizedBox(
                  width: cardSize,
                  height: cardSize,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: _isDarkStyle
                            ? [
                                const Color(0xFF14131A),
                                const Color(0xFF1B1926),
                                const Color(0xFF0F0E14),
                              ]
                            : [
                                const Color(0xFFFFFDF8),
                                const Color(0xFFFAF5E9),
                                const Color(0xFFF3EBDA),
                              ],
                      ),
                      border: Border.all(
                        color: const Color(0xFFD4AF37), // ذهبي ملكي
                        width: 2.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.35),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // علامة صليب خلفية نصف شفافة
                        Positioned.fill(
                          child: Center(
                            child: Opacity(
                              opacity: _isDarkStyle ? 0.05 : 0.04,
                              child: const Icon(
                                Icons.church_rounded,
                                size: 240,
                                color: Color(0xFFD4AF37),
                              ),
                            ),
                          ),
                        ),

                        // إطار داخلي زخرفي إضافي
                        Positioned.fill(
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFFD4AF37).withValues(alpha: 0.4),
                                width: 1,
                              ),
                            ),
                          ),
                        ),

                        // الصلبان الأربعة في الأركان
                        _buildCornerCross(top: 14, right: 14),
                        _buildCornerCross(top: 14, left: 14),
                        _buildCornerCross(bottom: 14, right: 14),
                        _buildCornerCross(bottom: 14, left: 14),

                        // المحتوى الداخلي
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // ترويسة التطبيق
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 1,
                                        width: 28,
                                        color: const Color(0xFFD4AF37),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 8),
                                        child: Text(
                                          '☦',
                                          style: TextStyle(
                                            color: Color(0xFFD4AF37),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 1,
                                        width: 28,
                                        color: const Color(0xFFD4AF37),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  const Text(
                                    'تطبيق نـور • NOOR',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                      color: Color(0xFFD4AF37),
                                    ),
                                  ),
                                ],
                              ),

                              // نص الآية المقدس
                              Expanded(
                                child: Center(
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Text(
                                        widget.text,
                                        style: AppTypography.scripture.copyWith(
                                          fontSize: cardSize > 350 ? 21 : 18,
                                          fontWeight: FontWeight.w700,
                                          height: 1.85,
                                          color: _isDarkStyle
                                              ? const Color(0xFFF9F7F1)
                                              : const Color(0xFF231F20),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // الشاهد والذيل
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFD4AF37).withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: const Color(0xFFD4AF37).withValues(alpha: 0.4),
                                      ),
                                    ),
                                    child: Text(
                                      widget.reference,
                                      style: const TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFD4AF37),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '«أَنَا هُوَ نُورُ الْعَالَمِ» • تطبيق مسيحي أرثوذكسي',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 9.5,
                                      color: _isDarkStyle
                                          ? Colors.white54
                                          : Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // 2. شريط التحكم والتبديل (ستايل داكن / فاتح)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: const Text('ستايل ملكي ليلي 🌙'),
                    selected: _isDarkStyle,
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: _isDarkStyle ? Colors.white : Colors.grey,
                      fontSize: 12,
                    ),
                    onSelected: (val) => setState(() => _isDarkStyle = true),
                  ),
                  const SizedBox(width: 10),
                  ChoiceChip(
                    label: const Text('ستايل بردي مضيء ☀️'),
                    selected: !_isDarkStyle,
                    selectedColor: const Color(0xFFD4AF37),
                    labelStyle: TextStyle(
                      color: !_isDarkStyle ? Colors.black : Colors.grey,
                      fontSize: 12,
                    ),
                    onSelected: (val) => setState(() => _isDarkStyle = false),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // 3. أزرار المشاركة والإغلاق
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: cardSize,
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white30),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('إغلاق'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4AF37),
                          foregroundColor: Colors.black,
                          elevation: 4,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        icon: _isSharing
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.black,
                                ),
                              )
                            : const Icon(Icons.share_rounded, size: 20),
                        label: Text(
                          _isSharing ? 'جاري التوليد...' : 'مشاركة كصورة (1080p)',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: _isSharing ? null : _shareAsImage,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }

  Widget _buildCornerCross({
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: const Text(
        '✝',
        style: TextStyle(
          color: Color(0xFFD4AF37),
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
