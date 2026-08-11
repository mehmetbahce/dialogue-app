import 'package:flutter/material.dart';

/// Her kategoriye özel canlı bir renk — kartlarda, ikonlarda ve
/// sohbet balonlarında kullanılıyor.
final Map<String, Color> categoryColors = {
  "Günlük Yaşam & İlişkiler": const Color(0xFF7C4DFF), // mor
  "Ev & Aile": const Color(0xFF00BFA5), // turkuaz
  "Alışveriş & Para": const Color(0xFF43A047), // yeşil
  "Araç & Ulaşım": const Color(0xFF1E88E5), // mavi
  "Sağlık & Yaşam": const Color(0xFFE53935), // kırmızı
  "Teknoloji": const Color(0xFF3949AB), // indigo
  "Okul & Eğitim": const Color(0xFFFB8C00), // turuncu
  "Din & İnanç": const Color(0xFF6D4C41), // kahve
  "Hava Durumu & Doğa": const Color(0xFF039BE5), // açık mavi
  "Eğlence & Medya": const Color(0xFFD81B60), // pembe
};

Color getCategoryColor(String title) {
  return categoryColors[title] ?? const Color(0xFF3F51B5);
}

/// Rengin çok açık (arka plan) tonu
Color getCategoryLightColor(String title) {
  final c = getCategoryColor(title);
  return Color.alphaBlend(c.withOpacity(0.12), Colors.white);
}
