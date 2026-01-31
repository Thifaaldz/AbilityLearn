import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'result_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../providers/audio_provider.dart';
import '../widgets/feedback_modal.dart';

class EmosiSosialScreen extends StatefulWidget {
  const EmosiSosialScreen({super.key});

  @override
  State<EmosiSosialScreen> createState() => _EmosiSosialScreenState();
}

class _EmosiSosialScreenState extends State<EmosiSosialScreen> {
  int currentStep = 1;
  late int totalStep;
  int stars = 0;
  final AudioPlayer _player = AudioPlayer();
  final AudioPlayer _backgroundPlayer = AudioPlayer();
  final FlutterTts _flutterTts = FlutterTts();
  bool _ttsInitialized = false;

  Future<void> playSound(String path) async {
    await _player.stop(); // biar ga numpuk suaranya
    await _player.play(AssetSource(path));
  }

  @override
  void dispose() {
    _player.dispose();
    _backgroundPlayer.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    totalStep = questions.length;
    _initTts().then((_) {
      // Auto-play TTS for the instruction when screen loads
      _speakInstruction();
      _playBackgroundMusic();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AudioProvider>().stopHomeBackgroundMusic();
    });
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

  void _speakInstruction() async {
    if (_ttsInitialized) {
      await _flutterTts.speak("Coba tebak, dia sedang merasa apa?");
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

  int currentIndex = 0;

  // jawaban yang dipilih user
  String selectedEmotion = '';

  // ==========================
  // 5 SOAL EMOSI & SOSIAL
  // ==========================
  final List<Map<String, dynamic>> questions = [
    {"image": "assets/images/modul3/gambarsedih.png", "correct": "Sedih"},
    {"image": "assets/images/modul3/gambarsenang.png", "correct": "senang"},
    {"image": "assets/images/modul3/gambarmarah.png", "correct": "Marah"},
    {"image": "assets/images/modul3/gambarkaget.png", "correct": "Kaget"},
    {"image": "assets/images/modul3/gambartidur.png", "correct": "Tidur"},
  ];

  // ==========================
  // TAMBAHAN: OPTIONS (biar tidak error)
  // ==========================
  final List<Map<String, String>> options = const [
    {"label": "Marah", "emoji": "😡"},
    {"label": "Sedih", "emoji": "😭"},
    {"label": "senang", "emoji": "😄"},
    {"label": "Kaget", "emoji": "😱"},
    {"label": "Tidur", "emoji": "😴"},
  ];

  // ==========================
  // FEEDBACK STATE
  // ==========================
  bool _showFeedback = false;
  bool _isCorrect = false;

  // ==========================
  // fungsi lanjut (benar)
  // ==========================
  void goNext() {
    setState(() {
      selectedEmotion = '';
      _showFeedback = false;

      if (currentIndex < questions.length - 1) {
        currentIndex++;
        currentStep++;
      } else {
        currentStep = totalStep;

        // selesai -> pindah ke ResultScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ResultScreen(stars: stars, totalQuestions: questions.length),
          ),
        );
      }
    });
  }

  // ==========================
  // fungsi coba lagi (salah)
  // ==========================
  void tryAgain() {
    setState(() {
      selectedEmotion = '';
      _showFeedback = false;
    });
  }





  // ==========================
  // fungsi cek jawaban
  // ==========================
  void checkAnswer(String userAnswer) {
    setState(() {
      selectedEmotion = userAnswer;
    });

    bool correct = userAnswer == questions[currentIndex]["correct"];

    if (correct) {
      stars++; // ⭐ tambah bintang kalau benar
    }

    setState(() {
      _isCorrect = correct;
      _showFeedback = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double progress = currentStep / totalStep;

    return Scaffold(
      backgroundColor: const Color(0xFFD3E1EC),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== TOP HEADER =====
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Emosi & Sosial",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF8A8A8A),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Aku Mengerti Perasaan",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF222222),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.home, color: Color(0xFFF28C28)),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // ===== PROGRESS =====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Kemajuan Belajar",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8A8A8A),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "$currentStep/$totalStep",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8A8A8A),
                          fontWeight: FontWeight.w600,
                        ),
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
                        Color(0xFFFF9F1C),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ===== QUESTION TEXT =====
                  const Text(
                    "Coba tebak, dia sedang merasa apa?",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ===== LISTEN BUTTON =====
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        if (_ttsInitialized) {
                          await _flutterTts.speak("Coba tebak, dia sedang merasa apa?");
                        }
                      },
                      icon: const Icon(Icons.volume_up),
                      label: const Text('Dengarkan Instruksi'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9F1C),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ===== IMAGE CARD =====
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.55),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Image.asset(
                            questions[currentIndex]["image"],
                            height: 220,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(
                                    Icons.image_not_supported,
                                    size: 60,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Gambar belum ada",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ===== OPTIONS BUTTONS =====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: options.map((item) {
                      final bool isSelected = selectedEmotion == item["label"];

                      return _EmotionOptionButton(
                        label: item["label"]!,
                        emoji: item["emoji"]!,
                        selected: isSelected,
                        onTap: () {
                          checkAnswer(item["label"]!);
                        },
                      );
                    }).toList(),
                  ),

                  // ===== HELPER TEXT =====
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

            // ===== FEEDBACK MODAL =====
            if (_showFeedback)
              FeedbackModal(
                isCorrect: _isCorrect,
                instruction: "Coba tebak, dia sedang merasa apa?",
                category: "Emosi & Sosial",
                onContinue: goNext,
              ),
          ],
        ),
      ),
    );
  }
}

class _EmotionOptionButton extends StatelessWidget {
  final String label;
  final String emoji;
  final bool selected;
  final VoidCallback onTap;

  const _EmotionOptionButton({
    required this.label,
    required this.emoji,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? const Color(0xFFFF9F1C) : Colors.transparent,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: selected
                    ? const Color(0xFFFF9F1C).withOpacity(0.18)
                    : const Color(0xFFF3F3F3),
                child: Text(emoji, style: const TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: selected ? const Color(0xFFFF9F1C) : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
