import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/category_screen.dart';

void main() {
  runApp(const DialogueApp());
}

class DialogueApp extends StatelessWidget {
  const DialogueApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTextTheme = GoogleFonts.nunitoTextTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '100 İngilizce Diyalog',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7C4DFF),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F7FB),
        textTheme: baseTextTheme,
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          titleTextStyle: GoogleFonts.nunito(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
      home: const CategoryScreen(),
    );
  }
}
