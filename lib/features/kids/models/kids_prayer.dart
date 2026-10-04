import 'package:flutter/material.dart';

class KidsPrayer {
  final String id;
  final String title;
  final String timing;
  final String icon;
  final Color color;
  final String text;
  final String psalmLine;

  const KidsPrayer({
    required this.id,
    required this.title,
    required this.timing,
    required this.icon,
    required this.color,
    required this.text,
    required this.psalmLine,
  });
}

class KidsMemoryVerse {
  final String id;
  final String verse;
  final String reference;
  final String explanation;
  final String icon;
  final Color color;

  const KidsMemoryVerse({
    required this.id,
    required this.verse,
    required this.reference,
    required this.explanation,
    required this.icon,
    required this.color,
  });
}
