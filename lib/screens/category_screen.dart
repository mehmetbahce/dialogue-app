import 'package:flutter/material.dart';
import '../data/dialogue_data.dart';
import 'dialogue_list_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İngilizce Diyalog Kategorileri'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dialogueCategories.length,
        itemBuilder: (context, index) {
          final cat = dialogueCategories[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigo.shade100,
                child: Icon(cat.icon, color: Colors.indigo),
              ),
              title: Text(cat.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${cat.dialogues.length} Bölüm'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DialogueListScreen(category: cat),
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
