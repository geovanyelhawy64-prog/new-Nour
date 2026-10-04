import 'package:flutter/material.dart';

enum KidsTestament { oldTestament, newTestament }

class KidsStory {
  final String id;
  final String title;
  final String subtitle;
  final String icon;
  final Color themeColor;
  final KidsTestament testament;
  final String reference;
  final List<String> paragraphs;
  final String memoryVerse;
  final String memoryVerseRef;
  final String moralLesson;

  const KidsStory({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.themeColor,
    required this.testament,
    required this.reference,
    required this.paragraphs,
    required this.memoryVerse,
    required this.memoryVerseRef,
    required this.moralLesson,
  });
}
