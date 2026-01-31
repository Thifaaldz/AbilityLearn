import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../data/game_items.dart';
import '../data/quiz_data_kenal_sekitarku.dart';
import '../models/quiz_item_kenal_sekitarku.dart';
import '../theme/app_theme.dart';
import '../widgets/feedback_modal.dart';
import 'result_screen.dart';

class GameKenalSekitarkuScreen extends StatefulWidget {
  final String roomName;

  const GameKenalSekitarkuScreen({
    super.key,
    required this.roomName,
  });

  @override
  State<GameKenalSekitarkuScreen> createState() =>
      _GameKenalSekitarkuScreenState();
}

class _GameKenalSekitarkuScreenState
    extends State<GameKenalSekitarkuScreen> {

  late List<QuizKenalSekitarku> _questions;
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
    _questions = quizKenalSekitarkuByRoom[widget.roomName] ?? [];
    _initTts().then((_) {
      _playBackgroundMusic();
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
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

  void _playBackgroundMusic() async {
    try {
      await _backgroundPlayer.setVolume(0.3); // Lower volume for background music
      await _backgroundPlayer.setReleaseMode(ReleaseMode.loop);
      await _backgroundPlayer.play(AssetSource('audio/background music.mp3'));
    } catch (e) {
      print("Error playing background music: $e");
    }
  }

  void _selectAnswer(String selected) {
    final question = _questions[_index];
    final correct = selected == question.correctItem;

    if (correct) _stars++;

    setState(() {
      _isCorrect = correct;
      _showFeedback = true;
    });
  }

  void _nextQuestion() {
    setState(() {
      _showFeedback = false;
      _audioPlayed = false; // Reset for next question
    });

    if (_index < _questions.length - 1) {
      setState(() {
        _index++;
      });
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


  void _playAudio() async {
    final question = _questions[_index];
    if (_audioPlayed) {
      // Use TTS for replay
      if (_ttsInitialized) {
        await _flutterTts.speak(question.instruction);
      }
    } else {
      // Try to play audio file first
      if (question.audioPath != null) {
        try {
          await _audioPlayer.play(
            AssetSource(question.audioPath!),
          );
          setState(() {
            _audioPlayed = true;
          });
        } catch (_) {
          // If audio fails, use TTS as fallback
          if (_ttsInitialized) {
            await _flutterTts.speak(question.instruction);
            setState(() {
              _audioPlayed = true; // Mark as played to enable TTS replay
            });
          }
        }
      } else {
        // No audio file, use TTS directly
        if (_ttsInitialized) {
          await _flutterTts.speak(question.instruction);
          setState(() {
            _audioPlayed = true;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    if (_questions.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('Soal belum tersedia')),
      );
    }

    final question = _questions[_index];
    final progress = (_index + 1) / _questions.length;

    return Scaffold(
      backgroundColor: AppTheme.backgroundGray,
      appBar: AppBar(
        title: const Text('Kenal Sekitarku'),
        centerTitle: true,
      ),
      body: Stack(
        children: [

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // =====================
                // HEADER
                // =====================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Misi ${widget.roomName}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${_index + 1}/${_questions.length}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 10,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation(
                      AppTheme.primaryOrange,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // =====================
                // QUESTION
                // =====================
                Text(
                  question.instruction,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                // =====================
                // AUDIO BUTTON
                // =====================
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _playAudio,
                    icon: const Icon(Icons.volume_up),
                    label: const Text('Dengarkan Instruksi'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryOrange,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // =====================
                // OPTIONS LEFT - RIGHT
                // =====================
                Expanded(
                  child: GridView.builder(
                    itemCount: question.options.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // <<< KIRI - KANAN
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.8, // proporsi kartu
                    ),
                    itemBuilder: (_, i) {

                      final itemId = question.options[i];
                      final item =
                          KenalSekitarkuItems.getById(itemId);

                      return GestureDetector(
                        onTap: () => _selectAnswer(itemId),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: AppTheme.primaryOrange,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Expanded(
                                child: Image.asset(
                                  item.imagePath,
                                  fit: BoxFit.contain,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                item.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // =====================
                // HELPER TEXT
                // =====================
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.pets, color: Colors.orange),
                      SizedBox(width: 8),
                      Text(
                        'Yuk, pilih jawaban yang benar!',
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
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
              category: widget.roomName,
              onContinue: _nextQuestion,
            ),
        ],
      ),
    );
  }
}
