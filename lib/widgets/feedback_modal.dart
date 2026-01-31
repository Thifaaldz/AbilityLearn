import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../theme/app_theme.dart';

class FeedbackModal extends StatefulWidget {
  final bool isCorrect;
  final String instruction;
  final String category;
  final VoidCallback onContinue;

  const FeedbackModal({
    super.key,
    required this.isCorrect,
    required this.instruction,
    required this.category,
    required this.onContinue,
  });

  String _getCorrectMessage(String category) {
    switch (category.toLowerCase()) {
      case 'sikat gigi':
        return 'Ayo sikat gigi agar gigi menjadi lebih sehat!';
      case 'mandi':
        return 'Mandi membuat badan bersih dan segar!';
      case 'cuci tangan':
        return 'Ayo cuci tangan pakai sabun agar kuman hilang!';
      case 'makan':
        return 'Makan yang sehat agar tubuh kuat!';
      case 'tidur':
        return 'Tidur yang cukup agar tubuh sehat!';
      case 'berpakaian':
        return 'Berpakaian rapi membuat kita terlihat bagus!';
      default:
        return 'Bagus sekali! Kamu hebat!';
    }
  }

  @override
  State<FeedbackModal> createState() => _FeedbackModalState();
}

class _FeedbackModalState extends State<FeedbackModal> {
  final FlutterTts _flutterTts = FlutterTts();
  bool _ttsInitialized = false;

  @override
  void initState() {
    super.initState();
    _initTts().then((_) {
      // Auto-play TTS for feedback message
      _speakFeedback();
    });
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  Future<void> _initTts() async {
    try {
      // Try Indonesian first
      var languages = await _flutterTts.getLanguages;
      if (languages.contains("id-ID")) {
        await _flutterTts.setLanguage("id-ID");
      } else if (languages.contains("en-US")) {
        await _flutterTts.setLanguage("en-US"); // Fallback to English
      }
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);
      _ttsInitialized = true;
    } catch (e) {
      print("TTS initialization error: $e");
      _ttsInitialized = false;
    }
  }

  void _speakFeedback() async {
    if (_ttsInitialized) {
      String message;
      if (widget.isCorrect) {
        message = widget.category.isNotEmpty ? widget._getCorrectMessage(widget.category) : 'Bagus sekali! Kamu hebat!';
      } else {
        message = 'coba lagi yaa';
      }
      await _flutterTts.speak(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.3),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(32),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: widget.isCorrect ? AppTheme.correctGreen : AppTheme.wrongPink,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                widget.isCorrect ? 'Jawaban Benar,' : 'Belum tepat,',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              // Message
              Text(
                widget.isCorrect ? widget._getCorrectMessage(widget.category) : 'coba lagi yaa',
                style: const TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: widget.onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: widget.isCorrect
                        ? AppTheme.correctGreen
                        : AppTheme.wrongRed,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.isCorrect) const Icon(Icons.check, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        widget.isCorrect ? 'Lanjutkan' : 'Yuk, coba lagi',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
