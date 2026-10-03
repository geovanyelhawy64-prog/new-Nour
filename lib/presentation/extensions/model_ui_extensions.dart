import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../data/database/app_database.dart';

/// إضافات واجهة المستخدم لنماذج الأجبية (UI Extensions on AgpeyaSection)
extension AgpeyaSectionUI on AgpeyaSection {
  Color get roleColor {
    return switch (role) {
      'priest' => AppColors.rolePriest,
      'deacon' => AppColors.roleDeacon,
      'people' => AppColors.rolePeople,
      'reader' => AppColors.accent,
      _ => AppColors.primary,
    };
  }

  IconData get roleIcon {
    return switch (role) {
      'priest' => Icons.person_rounded,
      'deacon' => Icons.record_voice_over_rounded,
      'people' => Icons.groups_rounded,
      'reader' => Icons.menu_book_rounded,
      _ => Icons.church_rounded,
    };
  }

  String get roleLabel {
    return switch (role) {
      'priest' => 'الكاهن',
      'deacon' => 'الشماس',
      'people' => 'الشعب',
      'reader' => 'القارئ',
      _ => 'الكل',
    };
  }
}

/// إضافات واجهة المستخدم لنماذج الخولاجي (UI Extensions on LiturgyPart)
extension LiturgyPartUI on LiturgyPart {
  Color get roleColor {
    if (isPriest) return AppColors.rolePriest;
    if (isDeacon) return AppColors.roleDeacon;
    return AppColors.rolePeople;
  }

  IconData get roleIcon {
    if (isPriest) return Icons.person_rounded;
    if (isDeacon) return Icons.record_voice_over_rounded;
    return Icons.groups_rounded;
  }

  String get roleTitle {
    if (isPriest) return 'الكاهن';
    if (isDeacon) return 'الشماس';
    return 'الشعب';
  }
}

/// إضافات واجهة المستخدم لنماذج القديسين (UI Extensions on Saint)
extension SaintUI on Saint {
  Color get categoryColor {
    return switch (type) {
      'martyr' => AppColors.error,
      'monk' => const Color(0xFF5D4037),
      'patriarch' => AppColors.primary,
      'bishop' => AppColors.accent,
      'confessor' => const Color(0xFF2E7D32),
      _ => AppColors.primary,
    };
  }

  IconData get categoryIcon {
    return switch (type) {
      'martyr' => Icons.workspace_premium_rounded,
      'monk' => Icons.terrain_rounded,
      'patriarch' => Icons.shield_rounded,
      'bishop' => Icons.auto_awesome_rounded,
      'confessor' => Icons.military_tech_rounded,
      _ => Icons.person_rounded,
    };
  }
}

/// إضافات واجهة المستخدم لآيات الكتاب المقدس (UI Extensions on BibleVerse)
extension BibleVerseUI on BibleVerse {
  String formattedRef(String bookName) => '$bookName $chapter : $verseNumber';
}
