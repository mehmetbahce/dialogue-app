# 100 İngilizce Diyalog — Flutter Uygulaması

## Kurulum
```bash
flutter pub get
flutter run
```

## Yapı
```
lib/
  models/dialogue_models.dart   -> DialogueLine, Dialogue, DialogueCategory sınıfları
  data/dialogue_data.dart       -> TÜM VERİ BURADA (şu an demo veri var)
  screens/category_screen.dart  -> Kategori listesi
  screens/dialogue_list_screen.dart -> Kategori içindeki bölümler (diyaloglar)
  screens/dialogue_detail_screen.dart -> Sesli diyalog ekranı (tek satır / tümünü oku)
  main.dart
```

## 100 diyaloğu eklemek için
PDF/metin verini yükle, ben `lib/data/dialogue_data.dart` içindeki demo verinin yerine
gerçek 100 diyaloğu, kategorilere ayrılmış şekilde otomatik dolduracağım.
Kod tarafında başka hiçbir değişiklik gerekmiyor — ekranlar veriyi otomatik listeliyor.

Elle eklemek istersen format şu şekilde (`dialogue_data.dart` içinde):
```dart
Dialogue(
  title: "3. What's Your Job?",
  lines: const [
    DialogueLine(speaker: "A", en: "What do you do?", tr: "Ne iş yapıyorsun?"),
    DialogueLine(speaker: "B", en: "I'm a teacher.", tr: "Öğretmenim."),
  ],
),
```
Bunu ilgili kategorinin `dialogues: [ ... ]` listesine ekle.

## Notlar
- Sesli okuma için `flutter_tts` paketi kullanılıyor (İngilizce, en-US).
- Orijinal koddaki `Colors.black80` hatası (geçersiz renk) `Colors.black87` olarak düzeltildi.
- Artık her kategori birden fazla diyalog (bölüm) içerebiliyor; kategoriye tıklayınca
  önce bölüm listesi, sonra diyalog detayı açılıyor.
