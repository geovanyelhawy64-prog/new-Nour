import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../widgets/navigation/app_quick_menu.dart';
import '../data/kids_data.dart';

class DrawnLine {
  final List<Offset> path;
  final Color color;
  final double width;

  const DrawnLine({
    required this.path,
    required this.color,
    required this.width,
  });
}

class KidsColoringScreen extends StatefulWidget {
  final String? templateId;

  const KidsColoringScreen({super.key, this.templateId});

  @override
  State<KidsColoringScreen> createState() => _KidsColoringScreenState();
}

class _KidsColoringScreenState extends State<KidsColoringScreen> {
  final List<DrawnLine> _lines = [];
  DrawnLine? _currentLine;
  Color _selectedColor = const Color(0xFFE91E63);
  double _selectedWidth = 8.0;
  bool _isEraser = false;

  static const List<Color> _palette = [
    Color(0xFFE91E63), // وردي
    Color(0xFFF44336), // أحمر
    Color(0xFFFF9800), // برتقالي
    Color(0xFFFFEB3B), // أصفر
    Color(0xFF4CAF50), // أخضر
    Color(0xFF009688), // تركواز
    Color(0xFF2196F3), // أزرق سماوي
    Color(0xFF3F51B5), // نيلي
    Color(0xFF9C27B0), // بنفسجي
    Color(0xFF795548), // بني
    Color(0xFF000000), // أسود
  ];

  Map<String, dynamic> get _currentTemplate {
    final id = widget.templateId ?? 'ark';
    return KidsData.coloringOutlines.firstWhere(
      (t) => t['id'] == id,
      orElse: () => KidsData.coloringOutlines.first,
    );
  }

  void _undo() {
    if (_lines.isNotEmpty) {
      HapticFeedback.lightImpact();
      setState(() {
        _lines.removeLast();
      });
    }
  }

  void _clearAll() {
    HapticFeedback.mediumImpact();
    setState(() {
      _lines.clear();
      _currentLine = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final template = _currentTemplate;

    return  Scaffold(
        appBar: AppBar(
          title: Text(
            '🎨 ${template['title']}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: 'Cairo'),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.undo_rounded),
              tooltip: 'تراجع خطوة',
              onPressed: _lines.isNotEmpty ? _undo : null,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded),
              tooltip: 'مسح اللوحة',
              onPressed: _lines.isNotEmpty ? _clearAll : null,
            ),
            const AppQuickMenu(),
          ],
        ),
        body: Column(
          children: [
            // مساحة التلوين والرسم
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.withValues(alpha: 0.3), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // علامة القالب بالخلفية
                    Center(
                      child: Opacity(
                        opacity: 0.22,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              template['icon'] as String,
                              style: const TextStyle(fontSize: 120),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              template['title'] as String,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // لوحة التلوين التفاعلية
                    GestureDetector(
                      onPanStart: (details) {
                        final point = details.localPosition;
                        setState(() {
                          _currentLine = DrawnLine(
                            path: [point],
                            color: _isEraser ? Colors.white : _selectedColor,
                            width: _selectedWidth,
                          );
                        });
                      },
                      onPanUpdate: (details) {
                        final point = details.localPosition;
                        if (_currentLine != null) {
                          setState(() {
                            final newPath = List<Offset>.from(_currentLine!.path)..add(point);
                            _currentLine = DrawnLine(
                              path: newPath,
                              color: _currentLine!.color,
                              width: _currentLine!.width,
                            );
                          });
                        }
                      },
                      onPanEnd: (_) {
                        if (_currentLine != null) {
                          setState(() {
                            _lines.add(_currentLine!);
                            _currentLine = null;
                          });
                        }
                      },
                      child: CustomPaint(
                        painter: _ColoringPainter(
                          lines: _lines,
                          currentLine: _currentLine,
                        ),
                        size: Size.infinite,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // لوحة الأدوات والألوان في الأسفل
            Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.06),
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // شريط اختيار حجم الفرشاة والممحاة
                  Row(
                    children: [
                      // زر الممحاة
                      InkWell(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          setState(() => _isEraser = !_isEraser);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: _isEraser ? const Color(0xFFD4AF37) : Colors.grey.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _isEraser ? const Color(0xFFD4AF37) : Colors.transparent,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.auto_fix_normal_rounded,
                                size: 16,
                                color: _isEraser ? Colors.black : (isDark ? Colors.white70 : Colors.black87),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'ممحاة',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _isEraser ? Colors.black : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // أحجام الفرشاة الثلاثة
                      const Text('الفرشاة:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 6),
                      _buildBrushSizeButton(4.0, 'صغير'),
                      const SizedBox(width: 4),
                      _buildBrushSizeButton(8.0, 'وسط'),
                      const SizedBox(width: 4),
                      _buildBrushSizeButton(16.0, 'عريض'),
                      const Spacer(),

                      // زر الإتمام والحفظ
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        icon: const Icon(Icons.check_rounded, size: 16),
                        label: const Text('أحسنت!', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          HapticFeedback.heavyImpact();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(
                                'رسمتك رائعة وفنان حقيقي يا بطل! 🎨✨',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // شريط لوحة الألوان المبهجة
                  SizedBox(
                    height: 42,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _palette.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final color = _palette[index];
                        final isSelected = !_isEraser && _selectedColor == color;

                        return GestureDetector(
                          onTap: () {
                            HapticFeedback.selectionClick();
                            setState(() {
                              _selectedColor = color;
                              _isEraser = false;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? Colors.white : Colors.black.withValues(alpha: 0.15),
                                width: isSelected ? 3.5 : 1,
                              ),
                              boxShadow: [
                                if (isSelected)
                                  BoxShadow(
                                    color: color.withValues(alpha: 0.5),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  ),
                              ],
                            ),
                            child: isSelected
                                ? const Center(
                                    child: Icon(Icons.check_rounded, size: 18, color: Colors.white),
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }

  Widget _buildBrushSizeButton(double width, String label) {
    final isSelected = _selectedWidth == width;
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() => _selectedWidth = width);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.withValues(alpha: 0.25) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _ColoringPainter extends CustomPainter {
  final List<DrawnLine> lines;
  final DrawnLine? currentLine;

  const _ColoringPainter({
    required this.lines,
    required this.currentLine,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final line in lines) {
      _paintLine(canvas, line);
    }
    if (currentLine != null) {
      _paintLine(canvas, currentLine!);
    }
  }

  void _paintLine(Canvas canvas, DrawnLine line) {
    if (line.path.isEmpty) return;

    final paint = Paint()
      ..color = line.color
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = line.width
      ..style = PaintingStyle.stroke;

    if (line.path.length == 1) {
      canvas.drawCircle(line.path.first, line.width / 2, paint..style = PaintingStyle.fill);
      return;
    }

    final path = Path();
    path.moveTo(line.path.first.dx, line.path.first.dy);
    for (var i = 1; i < line.path.length; i++) {
      path.lineTo(line.path[i].dx, line.path[i].dy);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ColoringPainter oldDelegate) => true;
}
