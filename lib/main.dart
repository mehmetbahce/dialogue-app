import 'package:flutter/material.dart';
import 'screens/category_screen.dart';

void main() {
  runApp(const DialogueApp());
}

class DialogueApp extends StatelessWidget {
  const DialogueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '100 İngilizce Diyalog',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
      ),
      home: const CategoryScreen(),
    );
  }
}
