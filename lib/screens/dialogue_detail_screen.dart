import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/dialogue_models.dart';

class DialogueDetailScreen extends StatefulWidget {
  final Dialogue dialogue;
  final Color accentColor;
  const DialogueDetailScreen({
    super.key,
    required this.dialogue,
    this.accentColor = const Color(0xFF7C4DFF),
  });

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
    // İngilizce motor doğal olarak daha hızlı konuşuyor, o yüzden ayrı ayrı ayarlıyoruz
    final rate = lang.startsWith("en") ? 0.25 : 0.35;
    await flutterTts.setSpeechRate(rate);
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
    final accent = widget.accentColor;
    return Scaffold(
      backgroundColor: const Color(0xFFF1F0F6),
      appBar: AppBar(
        backgroundColor: accent,
        foregroundColor: Colors.white,
        title: Text(
          widget.dialogue.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          if (_isSpeaking)
            IconButton(
              icon: const Icon(Icons.stop_circle_rounded),
              onPressed: _stop,
              tooltip: 'Durdur',
            )
          else ...[
            IconButton(
              icon: const Icon(Icons.volume_up_rounded),
              onPressed: _speakAllEnglish,
              tooltip: 'Tümünü İngilizce oku',
            ),
            IconButton(
              icon: const Icon(Icons.translate_rounded),
              onPressed: _speakAllTurkish,
              tooltip: 'Tümünü Türkçe oku',
            ),
          ],
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [accent.withOpacity(0.06), const Color(0xFFF1F0F6)],
            stops: const [0.0, 0.25],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.fromLTRB(12, 16, 12, 20),
          itemCount: widget.dialogue.lines.length,
          itemBuilder: (context, index) {
            final line = widget.dialogue.lines[index];
            final isA = line.speaker == "A";
            return _ChatBubble(
              isLeft: isA,
              speaker: line.speaker,
              en: line.en,
              tr: line.tr,
              accent: accent,
              onSpeakEn: () => _speak(line.en, lang: "en-US"),
              onSpeakTr: () => _speak(line.tr, lang: "tr-TR"),
            );
          },
        ),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final bool isLeft;
  final String speaker;
  final String en;
  final String tr;
  final Color accent;
  final VoidCallback onSpeakEn;
  final VoidCallback onSpeakTr;

  const _ChatBubble({
    required this.isLeft,
    required this.speaker,
    required this.en,
    required this.tr,
    required this.accent,
    required this.onSpeakEn,
    required this.onSpeakTr,
  });

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isLeft ? Colors.white : accent;
    final textColor = isLeft ? const Color(0xFF2A2A3B) : Colors.white;
    final subTextColor = isLeft ? Colors.grey.shade600 : Colors.white.withOpacity(0.85);
    final avatarColor = isLeft ? accent : const Color(0xFF2A2A3B);

    final avatar = Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: avatarColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: avatarColor.withOpacity(0.35), blurRadius: 6, offset: const Offset(0, 2)),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        speaker,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13),
      ),
    );

    final bubble = Container(
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
      padding: const EdgeInsets.fromLTRB(14, 10, 10, 8),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: Radius.circular(isLeft ? 4 : 16),
          bottomRight: Radius.circular(isLeft ? 16 : 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            en,
            style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w600, color: textColor, height: 1.3),
          ),
          const SizedBox(height: 4),
          Text(
            tr,
            style: TextStyle(fontSize: 13, color: subTextColor, height: 1.3),
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _MiniSpeakButton(
                icon: Icons.volume_up_rounded,
                color: isLeft ? accent : Colors.white,
                onTap: onSpeakEn,
              ),
              const SizedBox(width: 6),
              _MiniSpeakButton(
                icon: Icons.translate_rounded,
                color: isLeft ? accent : Colors.white,
                onTap: onSpeakTr,
              ),
            ],
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: isLeft
            ? [avatar, const SizedBox(width: 8), Flexible(child: bubble)]
            : [Flexible(child: bubble), const SizedBox(width: 8), avatar],
      ),
    );
  }
}

class _MiniSpeakButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _MiniSpeakButton({required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(icon, size: 16, color: color.withOpacity(0.85)),
      ),
    );
  }
}
