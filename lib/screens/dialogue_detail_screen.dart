import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/dialogue_models.dart';

class DialogueDetailScreen extends StatefulWidget {
  final Dialogue dialogue;
  const DialogueDetailScreen({super.key, required this.dialogue});

  @override
  State<DialogueDetailScreen> createState() => _DialogueDetailScreenState();
}

class _DialogueDetailScreenState extends State<DialogueDetailScreen> {
  final FlutterTts flutterTts = FlutterTts();
  bool _isSpeaking = false;

  @override
  void initState() {
    super.initState();
    flutterTts.setPitch(1.0);
    flutterTts.setCompletionHandler(() {
      if (mounted) setState(() => _isSpeaking = false);
    });
  }

  /// lang: "en-US" veya "tr-TR"
  Future<void> _speak(String text, {String lang = "en-US"}) async {
    await flutterTts.setLanguage(lang);
    setState(() => _isSpeaking = true);
    await flutterTts.speak(text);
  }

  Future<void> _speakAllEnglish() async {
    final fullText = widget.dialogue.lines.map((e) => e.en).join(". ");
    await _speak(fullText, lang: "en-US");
  }

  Future<void> _speakAllTurkish() async {
    final fullText = widget.dialogue.lines.map((e) => e.tr).join(". ");
    await _speak(fullText, lang: "tr-TR");
  }

  Future<void> _stop() async {
    await flutterTts.stop();
    setState(() => _isSpeaking = false);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.dialogue.title)),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.indigo.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.dialogue.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo),
                  ),
                ),
                if (_isSpeaking)
                  IconButton(
                    icon: const Icon(Icons.stop_circle, color: Colors.red, size: 28),
                    onPressed: _stop,
                    tooltip: 'Durdur',
                  )
                else ...[
                  IconButton(
                    icon: const Icon(Icons.volume_up, color: Colors.indigo, size: 26),
                    onPressed: _speakAllEnglish,
                    tooltip: 'Tümünü İngilizce oku',
                  ),
                  IconButton(
                    icon: const Icon(Icons.record_voice_over, color: Colors.orange, size: 26),
                    onPressed: _speakAllTurkish,
                    tooltip: 'Tümünü Türkçe oku',
                  ),
                ]
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: widget.dialogue.lines.length,
              itemBuilder: (context, index) {
                final line = widget.dialogue.lines[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: line.speaker == "A" ? Colors.blue : Colors.orange,
                          child: Text(
                            line.speaker,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                line.en,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                line.tr,
                                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.volume_up_outlined, color: Colors.indigo),
                          tooltip: 'İngilizce oku',
                          onPressed: () => _speak(line.en, lang: "en-US"),
                        ),
                        IconButton(
                          icon: const Icon(Icons.record_voice_over_outlined, color: Colors.orange),
                          tooltip: 'Türkçe oku',
                          onPressed: () => _speak(line.tr, lang: "tr-TR"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
