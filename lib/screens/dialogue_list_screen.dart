import 'package:flutter/material.dart';
import '../models/dialogue_models.dart';
import '../utils/category_colors.dart';
import 'dialogue_detail_screen.dart';

class DialogueListScreen extends StatelessWidget {
  final DialogueCategory category;
  const DialogueListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final color = getCategoryColor(category.title);
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FB),
      appBar: AppBar(
        title: Text(category.title),
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
      body: category.dialogues.isEmpty
          ? const Center(child: Text('Bu kategoride henüz diyalog yok.'))
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              itemCount: category.dialogues.length,
              itemBuilder: (context, index) {
                final dialogue = category.dialogues[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.10),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DialogueDetailScreen(
                              dialogue: dialogue,
                              accentColor: color,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(Icons.forum_rounded, color: color, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dialogue.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: Color(0xFF2A2A3B),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${dialogue.lines.length} cümle',
                                    style: TextStyle(fontSize: 12.5, color: Colors.grey.shade500),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 13, color: color),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
