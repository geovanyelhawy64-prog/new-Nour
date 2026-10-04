import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/theme/app_colors.dart';

/// صيدلية المشاعر والحالة الروحية (Pray by Spiritual Need & Emotion)
/// قسم تفاعلي يُمكّن المستخدم من الصلاة حسب حالته النفسية فوراً
class HomeEmotionPrayersSection extends StatelessWidget {
  const HomeEmotionPrayersSection({super.key});

  static const List<Map<String, dynamic>> _emotions = [
    {
      'title': 'حزن وضيقة',
      'subtitle': 'عند الألم والشدائد',
      'icon': '💔',
      'category': 'comfort',
      'color': Color(0xFFBA3838),
    },
    {
      'title': 'قلق وخوف',
      'subtitle': 'طلب السلام الداخلي',
      'icon': '🕊️',
      'category': 'anxiety',
      'color': Color(0xFF2069B4),
    },
    {
      'title': 'سلام وسكينة',
      'subtitle': 'طمأنينة وهدوء الروح',
      'icon': '🌿',
      'category': 'peace',
      'color': Color(0xFF2E8278),
    },
    {
      'title': 'توبة ورجوع',
      'subtitle': 'طلب المغفرة والندم',
      'icon': '🤍',
      'category': 'repentance',
      'color': Color(0xFF8E24AA),
    },
    {
      'title': 'شكر وفرح',
      'subtitle': 'حمد الله على نعمه',
      'icon': '☀️',
      'category': 'gratitude',
      'color': Color(0xFFD4AF37),
    },
    {
      'title': 'حيرة وإرشاد',
      'subtitle': 'طلب الحكمة والتوفيق',
      'icon': '🧭',
      'category': 'guidance',
      'color': Color(0xFF0288D1),
    },
    {
      'title': 'مرض وألم',
      'subtitle': 'طلب الشفاء والعافية',
      'icon': '✝️',
      'category': 'sickness',
      'color': Color(0xFF00897B),
    },
    {
      'title': 'تجارب وحروب',
      'subtitle': 'طلب النصرة والقوة',
      'icon': '🛡️',
      'category': 'temptation',
      'color': Color(0xFFD84315),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // رأس القسم
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const Icon(
                  Icons.favorite_rounded,
                  color: Color(0xFFBA3838),
                  size: 19,
                ),
                const SizedBox(width: 8),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'صيدلية المشاعر والصلوات',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'بماذا يشعر قلبك الآن؟',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    context.push('/prayers/emotions');
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'عرض الكل',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12,
                          color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 11,
                        color: isDark ? AppColors.primaryLight : AppColors.primaryDark,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // شريط الكبسولات العاطفية الأفقية
          SizedBox(
            height: 108,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: _emotions.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final item = _emotions[index];
                final color = item['color'] as Color;

                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      HapticFeedback.lightImpact();
                      context.push('/prayers/emotions?category=${item['category']}');
                    },
                    child: Container(
                      width: 140,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E2433) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: color.withValues(alpha: isDark ? 0.35 : 0.25),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                item['icon'] as String,
                                style: const TextStyle(fontSize: 18),
                              ),
                              const Spacer(),
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            item['title'] as String,
                            style: const TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            item['subtitle'] as String,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 10,
                              color: isDark ? Colors.white54 : Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
