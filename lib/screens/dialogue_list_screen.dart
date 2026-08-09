import 'package:flutter/material.dart';
import '../models/dialogue_models.dart';
import 'dialogue_detail_screen.dart';

class DialogueListScreen extends StatelessWidget {
  final DialogueCategory category;
  const DialogueListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.title)),
      body: category.dialogues.isEmpty
          ? const Center(child: Text('Bu kategoride henüz diyalog yok.'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: category.dialogues.length,
              itemBuilder: (context, index) {
                final dialogue = category.dialogues[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: const Icon(Icons.forum_outlined, color: Colors.indigo),
                    title: Text(dialogue.title),
                    subtitle: Text('${dialogue.lines.length} cümle'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DialogueDetailScreen(dialogue: dialogue),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
