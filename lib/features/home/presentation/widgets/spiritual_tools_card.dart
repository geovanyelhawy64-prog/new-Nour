import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SpiritualToolsCard extends StatelessWidget {
  const SpiritualToolsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const accentGold = Color(0xFFD4AF37);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Column(
        children: [
          // بطاقة وضع الكنيسة البارزة
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [
                        const Color(0xFF2A2000),
                        const Color(0xFF151515),
                      ]
                    : [
                        accentGold.withValues(alpha: 0.18),
                        accentGold.withValues(alpha: 0.04),
                      ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: accentGold.withValues(alpha: 0.4)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: accentGold.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.church_rounded,
                    color: accentGold,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'وضع الكنيسة',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: accentGold,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'لايف',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'متابع طقوس القداس خطوة بخطوة للشعب والشمامسة مع إعتام الشاشة',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.white70 : Colors.grey[700],
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentGold,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => context.push('/church-mode'),
                  child: const Text(
                    'دخول',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // بطاقتان متجاورتان: سجل الصلاة اليومي + خطة قراءة الكتاب
          Row(
            children: [
              // سجل الصلاة
              Expanded(
                child: InkWell(
                  onTap: () => context.push('/prayer-tracker'),
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFF6A1B9A).withValues(alpha: 0.25),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6A1B9A).withValues(alpha: 0.12),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.access_time_filled_rounded,
                                color: Color(0xFF6A1B9A),
                                size: 18,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 12,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'سجل الصلاة',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'متابعة صلوات السواعي والستريك',
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // خطة القراءة
              Expanded(
                child: InkWell(
                  onTap: () => context.push('/reading-plan'),
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFF1565C0).withValues(alpha: 0.25),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1565C0).withValues(alpha: 0.12),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.auto_stories_rounded,
                                color: Color(0xFF1565C0),
                                size: 18,
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 12,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'خطة القراءة',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'ختمة الكتاب والمزامير',
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // بطاقة وضع الأطفال البارزة والمبهجة
          InkWell(
            onTap: () => context.push('/kids'),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFE91E63).withValues(alpha: isDark ? 0.25 : 0.1),
                    const Color(0xFF0288D1).withValues(alpha: isDark ? 0.2 : 0.08),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE91E63).withValues(alpha: 0.35),
                  width: 1.2,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE91E63).withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text('👶', style: TextStyle(fontSize: 22)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'وضع الأطفال والأسرة',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                              ),
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Kids Mode',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE91E63),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Text(
                          'قصص الكتاب المقدس المبسطة، صلواتي، آيات للحفظ، وركن تلوين تفاعلي',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: Color(0xFFE91E63),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
