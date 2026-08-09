import 'package:flutter/material.dart';

/// Tek bir konuşma satırı (A veya B kişisi)
class DialogueLine {
  final String speaker; // "A" veya "B"
  final String en;
  final String tr;

  const DialogueLine({
    required this.speaker,
    required this.en,
    required this.tr,
  });
}

/// Tek bir diyalog (örn: "1. I Live in Pasadena")
class Dialogue {
  final String title;
  final List<DialogueLine> lines;

  const Dialogue({
    required this.title,
    required this.lines,
  });
}

/// Kategori (örn: "Günlük Yaşam & Tanışma") - içinde birden çok diyalog barındırır
class DialogueCategory {
  final String title;
  final IconData icon;
  final List<Dialogue> dialogues;

  const DialogueCategory({
    required this.title,
    required this.icon,
    required this.dialogues,
  });
}
