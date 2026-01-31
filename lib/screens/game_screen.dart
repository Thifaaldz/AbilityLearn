import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../data/quiz_data.dart';
import '../data/game_items.dart';
import '../models/quiz_item.dart';
import '../theme/app_theme.dart';
import '../widgets/item_card.dart';
import '../widgets/feedback_modal.dart';
import 'result_screen.dart';

class GameScreen extends StatefulWidget {
  final String category;

  const GameScreen({
    super.key,
    this.category = 'Kemandirian Diri',
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late List<QuizItem> _questions;

  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioPlayer _backgroundPlayer = AudioPlayer();
  final FlutterTts _flutterTts = FlutterTts();

  int _index = 0;
  int _stars = 0;

  bool _showFeedback = false;
  bool _isCorrect = false;
  bool _audioPlayed = false;
  bool _ttsInitialized = false;

  @override
  void initState() {
    super.initState();
    _questions = List.from(quizData);
    _initTts();
    _playBackgroundMusic();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _backgroundPlayer.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  // =====================
  // TTS INITIALIZATION
  // =====================
  Future<void> _initTts() async {
    try {
      var languages = await _flutterTts.getLanguages;
      if (languages.contains("id-ID")) {
        await _flutterTts.setLanguage("id-ID");
      } else {
        await _flutterTts.setLanguage("en-US");
      }
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);
      _ttsInitialized = true;
    } catch (_) {
      _ttsInitialized = false;
    }
  }

  void _playBackgroundMusic() async {
    try {
      await _backgroundPlayer.setVolume(0.3); // Lower volume for background music
      await _backgroundPlayer.setReleaseMode(ReleaseMode.loop);
      await _backgroundPlayer.play(AssetSource('audio/background music.mp3'));
    } catch (e) {
      print("Error playing background music: $e");
    }
  }

  void _playAudio() async {
    final question = _questions[_index];

    if (_audioPlayed) {
      if (_ttsInitialized) {
        await _flutterTts.speak(question.instruction);
      }
      return;
    }

    if (question.audioPath != null) {
      try {
        await _audioPlayer.play(AssetSource(question.audioPath!));
        setState(() => _audioPlayed = true);
      } catch (_) {
        if (_ttsInitialized) {
          await _flutterTts.speak(question.instruction);
          setState(() => _audioPlayed = true);
        }
      }
    } else if (_ttsInitialized) {
      await _flutterTts.speak(question.instruction);
      setState(() => _audioPlayed = true);
    }
  }

  // =====================
  // GAME LOGIC
  // =====================
  void _selectAnswer(String selectedId) {
    final question = _questions[_index];
    final correct = question.correctItems.contains(selectedId);

    if (correct) _stars++;

    setState(() {
      _isCorrect = correct;
      _showFeedback = true;
    });
  }

  void _nextQuestion() {
    setState(() {
      _showFeedback = false;
      _audioPlayed = false;
    });

    if (_index < _questions.length - 1) {
      setState(() => _index++);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            stars: _stars,
            totalQuestions: _questions.length,
          ),
        ),
      );
    }
  }

  // =====================
  // UI
  // =====================
  @override
  Widget build(BuildContext context) {
    final question = _questions[_index];
    final progress = (_index + 1) / _questions.length;

    return Scaffold(
      backgroundColor: AppTheme.backgroundGray,
      appBar: AppBar(
        title: const Text('Aku Bisa Merawat Diriku'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // =====================
                // INSTRUCTION BUBBLE
                // =====================
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Text(
                    question.instruction,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 20),

                // =====================
                // CHARACTER / IMAGE
                // =====================
                Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                    color: Colors.white, // ✅ PUTIH
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Image.asset(
                    question.imagePath!,
                    fit: BoxFit.contain,
                  ),
                ),


                const SizedBox(height: 20),

                // =====================
                // AUDIO BUTTON (TIDAK DIHILANGKAN)
                // =====================
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _playAudio,
                    icon: const Icon(Icons.volume_up),
                    label: const Text('Dengarkan Instruksi'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryOrange,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // =====================
                // OPTIONS (2 ITEMS)
                // =====================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: question.allItems.map((itemId) {
                    final item = GameItems.getById(itemId);
                    return SizedBox(
                      width: 150,
                      height: 180,
                      child: ItemCard(
                        item: item,
                        isSelected: false,
                        isCorrect: false,
                        showResult: false,
                        onTap: () => _selectAnswer(itemId),
                      ),
                    );
                  }).toList(),
                ),

                const Spacer(),

                // =====================
                // QUESTION + PROGRESS
                // =====================
                Text(
                  'Alat apa yang digunakan untuk ${question.category}?',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 8,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation(
                          AppTheme.primaryOrange,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text('${_index + 1}/${_questions.length}'),
                  ],
                ),
              ],
            ),
          ),

          // =====================
          // FEEDBACK MODAL
          // =====================
          if (_showFeedback)
            FeedbackModal(
              isCorrect: _isCorrect,
              instruction: question.instruction,
              category: widget.category,
              onContinue: _nextQuestion,
            ),
        ],
      ),
    );
  }
}
