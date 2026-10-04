import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/church_mode_data.dart';
import '../models/liturgy_step.dart';
import '../../../../widgets/navigation/app_quick_menu.dart';

class ChurchModeScreen extends StatefulWidget {
  const ChurchModeScreen({super.key});

  @override
  State<ChurchModeScreen> createState() => _ChurchModeScreenState();
}

class _ChurchModeScreenState extends State<ChurchModeScreen> {
  int _currentIndex = 0;
  bool _dimmerMode = false;
  final ScrollController _scrollController = ScrollController();

  List<LiturgyStep> get _steps => ChurchModeData.steps;
  LiturgyStep get _currentStep => _steps[_currentIndex];

  void _nextStep() {
    if (_currentIndex < _steps.length - 1) {
      setState(() => _currentIndex++);
      _scrollToTop();
    }
  }

  void _prevStep() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
      _scrollToTop();
    }
  }

  void _goToStep(int index) {
    setState(() => _currentIndex = index);
    _scrollToTop();
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _showStepsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: _dimmerMode ? const Color(0xFF121212) : null,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (context, scrollCtrl) {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 48,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.church_rounded, color: Color(0xFFD4AF37)),
                      const SizedBox(width: 8),
                      Text(
                        'خطوات القداس الإلهي (22 خطوة)',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _dimmerMode ? Colors.white : null,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    controller: scrollCtrl,
                    itemCount: _steps.length,
                    itemBuilder: (context, idx) {
                      final s = _steps[idx];
                      final isSelected = idx == _currentIndex;
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 16,
                          backgroundColor: isSelected
                              ? const Color(0xFFD4AF37)
                              : Colors.grey.withValues(alpha: 0.2),
                          child: Text(
                            '${s.stepNumber}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.black : (_dimmerMode ? Colors.white : Colors.black87),
                            ),
                          ),
                        ),
                        title: Text(
                          s.title,
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected
                                ? const Color(0xFFD4AF37)
                                : (_dimmerMode ? Colors.white70 : Colors.black87),
                          ),
                        ),
                        subtitle: Text(
                          s.stage.titleAr,
                          style: TextStyle(
                            fontSize: 11,
                            color: _dimmerMode ? Colors.white38 : Colors.grey[600],
                          ),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle, color: Color(0xFFD4AF37))
                            : null,
                        onTap: () {
                          Navigator.pop(context);
                          _goToStep(idx);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = _dimmerMode ? const Color(0xFF000000) : theme.scaffoldBackgroundColor;
    final cardColor = _dimmerMode ? const Color(0xFF141414) : theme.cardColor;
    final primaryTextColor = _dimmerMode ? const Color(0xFFE0D8C3) : theme.textTheme.bodyLarge?.color;
    final accentGold = const Color(0xFFD4AF37);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: _dimmerMode ? const Color(0xFF080808) : null,
        elevation: _dimmerMode ? 0 : null,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'وضع الكنيسة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'المتابع الطقسي الحي للقداس الإلهي',
              style: TextStyle(
                fontSize: 11,
                color: _dimmerMode ? Colors.white54 : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: _dimmerMode ? 'إلغاء وضع إعتام الشاشة' : 'تفعيل إعتام الكنيسة (شاشة مظلمة)',
            icon: Icon(
              _dimmerMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              color: _dimmerMode ? accentGold : null,
            ),
            onPressed: () => setState(() => _dimmerMode = !_dimmerMode),
          ),
          IconButton(
            tooltip: 'فهرس الخطوات',
            icon: const Icon(Icons.list_alt_rounded),
            onPressed: _showStepsSheet,
          ),
          const AppQuickMenu(),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // شريط التقدم والمرحلة
            _buildProgressBar(accentGold),

            // محتوى الخطوة الحالي
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // عنوان الخطوة ورقمها
                    _buildStepHeader(accentGold, primaryTextColor),
                    const SizedBox(height: 12),

                    // شارة وضعية الوقوف/السجود
                    _buildPostureBadge(),
                    const SizedBox(height: 16),

                    // الكاهن
                    _buildRoleCard(
                      roleTitle: 'الكاهن خديم المذبح',
                      roleIcon: Icons.account_circle_outlined,
                      roleColor: const Color(0xFFB71C1C),
                      content: _currentStep.priestAction,
                      cardColor: cardColor,
                      textColor: primaryTextColor,
                    ),
                    const SizedBox(height: 12),

                    // الشماس
                    _buildRoleCard(
                      roleTitle: 'الشماس الخادم',
                      roleIcon: Icons.notifications_active_outlined,
                      roleColor: const Color(0xFF1976D2),
                      content: _currentStep.deaconChant,
                      cardColor: cardColor,
                      textColor: primaryTextColor,
                    ),
                    const SizedBox(height: 12),

                    // الشعب
                    _buildRoleCard(
                      roleTitle: 'جماعة الشعب المؤمن',
                      roleIcon: Icons.groups_outlined,
                      roleColor: const Color(0xFF388E3C),
                      content: _currentStep.congregationResponse,
                      cardColor: cardColor,
                      textColor: primaryTextColor,
                    ),
                    const SizedBox(height: 12),

                    // العبارة القبطية إن وجدت
                    if (_currentStep.copticPhrase != null) ...[
                      _buildCopticCard(cardColor, accentGold),
                      const SizedBox(height: 12),
                    ],

                    // المعنى الروحي والطقسي
                    _buildSpiritualCard(cardColor, accentGold, primaryTextColor),
                    const SizedBox(height: 16),

                    // رابط سريع للخولاجي
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: accentGold,
                        side: BorderSide(color: accentGold.withValues(alpha: 0.5)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(Icons.menu_book_rounded),
                      label: const Text('فتح نصوص الخولاجي المقدس الكاملة'),
                      onPressed: () => context.push('/liturgy'),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // شريط التنقل السفلي (السابق / التالي)
            _buildBottomNav(accentGold),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(Color accentGold) {
    final progress = (_currentIndex + 1) / _steps.length;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: _dimmerMode ? const Color(0xFF0A0A0A) : Colors.grey.withValues(alpha: 0.06),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _currentStep.stage.titleAr,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: accentGold,
                ),
              ),
              Text(
                'الخطوة ${_currentIndex + 1} من ${_steps.length}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _dimmerMode ? Colors.white60 : Colors.grey[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: _dimmerMode ? Colors.white12 : Colors.grey.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(accentGold),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepHeader(Color accentGold, Color? textColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: accentGold.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(color: accentGold.withValues(alpha: 0.4)),
          ),
          child: Text(
            '${_currentStep.stepNumber}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: accentGold,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            _currentStep.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPostureBadge() {
    IconData postureIcon;
    Color postureColor;
    switch (_currentStep.posture) {
      case CongregationPosture.standing:
        postureIcon = Icons.accessibility_new_rounded;
        postureColor = const Color(0xFF2E7D32);
        break;
      case CongregationPosture.prostrating:
        postureIcon = Icons.airline_seat_recline_extra_rounded;
        postureColor = const Color(0xFFC62828);
        break;
      case CongregationPosture.sitting:
        postureIcon = Icons.chair_rounded;
        postureColor = const Color(0xFFEF6C00);
        break;
      case CongregationPosture.communion:
        postureIcon = Icons.auto_awesome_rounded;
        postureColor = const Color(0xFF6A1B9A);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: postureColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: postureColor.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(postureIcon, size: 16, color: postureColor),
          const SizedBox(width: 6),
          Text(
            'حركة الجسد: ${_currentStep.posture.label}',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: postureColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleCard({
    required String roleTitle,
    required IconData roleIcon,
    required Color roleColor,
    required String content,
    required Color cardColor,
    required Color? textColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _dimmerMode ? Colors.white10 : Colors.grey.withValues(alpha: 0.2),
        ),
        boxShadow: _dimmerMode
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(roleIcon, size: 18, color: roleColor),
              const SizedBox(width: 8),
              Text(
                roleTitle,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: roleColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCopticCard(Color cardColor, Color accentGold) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentGold.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.translate_rounded, size: 18, color: accentGold),
              const SizedBox(width: 8),
              Text(
                'العبارة القبطية الطقسية',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: accentGold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _currentStep.copticPhrase ?? '',
            textDirection: TextDirection.ltr,
            style: const TextStyle(
              fontFamily: 'Coptic',
              fontSize: 17,
              height: 1.4,
              color: Color(0xFFD4AF37),
            ),
          ),
          if (_currentStep.copticArabized != null) ...[
            const SizedBox(height: 4),
            Text(
              'النطق: ${_currentStep.copticArabized}',
              style: TextStyle(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: _dimmerMode ? Colors.white60 : Colors.grey[700],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSpiritualCard(Color cardColor, Color accentGold, Color? textColor) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _dimmerMode ? Colors.white10 : Colors.grey.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.wb_sunny_outlined, size: 18, color: Color(0xFFE65100)),
              const SizedBox(width: 8),
              const Text(
                'المعنى والرمز الروحي',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE65100),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _currentStep.spiritualMeaning,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(Color accentGold) {
    final canPrev = _currentIndex > 0;
    final canNext = _currentIndex < _steps.length - 1;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: _dimmerMode ? const Color(0xFF080808) : Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(
            color: _dimmerMode ? Colors.white12 : Colors.grey.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          // الزر السابق
          Expanded(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: _dimmerMode ? const Color(0xFF222222) : Colors.grey.withValues(alpha: 0.15),
                foregroundColor: _dimmerMode ? Colors.white70 : Colors.black87,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: canPrev ? _prevStep : null,
              icon: const Icon(Icons.arrow_forward_rounded, size: 18),
              label: const Text('الخطوة السابقة'),
            ),
          ),
          const SizedBox(width: 12),
          // الزر التالي
          Expanded(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: accentGold,
                foregroundColor: Colors.black,
                elevation: 1,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: canNext ? _nextStep : null,
              icon: const Icon(Icons.arrow_back_rounded, size: 18),
              label: Text(canNext ? 'الخطوة التالية' : 'نهاية القداس الإلهي'),
            ),
          ),
        ],
      ),
    );
  }
}
