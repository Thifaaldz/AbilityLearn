import 'package:flutter/material.dart';
import 'result_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';

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
  // TAMBAHAN: biar popup ga ke-trigger berkali-kali
  // ==========================
  bool isDialogOpen = false;

  // ==========================
  // fungsi lanjut (benar)
  // ==========================
  void goNext() {
    setState(() {
      selectedEmotion = '';

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
    });
  }

  // ==========================
  // POPUP BENAR
  // ==========================
  void showCorrectPopup() {
    if (isDialogOpen) return;
    isDialogOpen = true;
    playSound("assets/audio/jawabansalah.mp3");
    playSound("assets/audio/benar.mp3");
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFE9FFF2),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFF6CCF8E).withOpacity(0.6),
                width: 1.2,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6CCF8E).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    size: 38,
                    color: Color(0xFF2EAD63),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Jawaban Benar!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF2EAD63),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Kamu hebat! Ini adalah emosi\n${questions[currentIndex]["correct"]}.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.3,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context); // tutup popup
                      isDialogOpen = false;
                      goNext(); // lanjut
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text(
                      "Lanjut",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6CCF8E),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      isDialogOpen = false;
    });
  }

  // ==========================
  // POPUP SALAH
  // ==========================
  void showWrongPopup() {
    if (isDialogOpen) return;
    isDialogOpen = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3C7),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFFFF9F1C).withOpacity(0.6),
                width: 1.2,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF9F1C).withOpacity(0.25),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.cancel,
                    size: 38,
                    color: Color(0xFFE53935),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Jawaban Salah!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFE53935),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Yuk coba lagi ya!\nPerhatikan ekspresinya 😊",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.3,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context); // tutup popup
                      isDialogOpen = false;
                      tryAgain(); // reset pilihan
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text(
                      "Coba Lagi",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF9F1C),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      isDialogOpen = false;
    });
  }

  // ==========================
  // TAMBAHAN: POPUP SELESAI
  // ==========================
  void showFinishPopup() {
    if (isDialogOpen) return;
    isDialogOpen = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2FF),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFF4A90E2).withOpacity(0.6),
                width: 1.2,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A90E2).withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.emoji_events,
                    size: 38,
                    color: Color(0xFF2D6CDF),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Selesai 🎉",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF2D6CDF),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Kamu sudah menyelesaikan semua soal\nEmosi & Sosial!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.3,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      isDialogOpen = false;

                      // setelah selesai, balik halaman sebelumnya
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.home),
                    label: const Text(
                      "Kembali",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A90E2),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).then((_) {
      isDialogOpen = false;
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
      showCorrectPopup();
    } else {
      showWrongPopup();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double progress = currentStep / totalStep;

    return Scaffold(
      backgroundColor: const Color(0xFFD3E1EC),
      body: SafeArea(
        child: Column(
          children: [
            // ===== TOP HEADER =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
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
            ),

            // ===== PROGRESS =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
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
            ),
            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 10,
                  backgroundColor: Colors.white,
                  valueColor: const AlwaysStoppedAnimation(Color(0xFFFF9F1C)),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // ===== QUESTION TEXT =====
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Coba tebak, dia sedang merasa apa?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // ===== LISTEN BUTTON =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (_ttsInitialized) {
                      await _flutterTts.speak("Coba tebak, dia sedang merasa apa?");
                    }
                  },

                  icon: const Icon(Icons.volume_up_rounded),
                  label: const Text(
                    "Dengarkan Instruksi",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9F1C),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // ===== IMAGE CARD =====
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
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
            ),

            const SizedBox(height: 16),

            // ===== OPTIONS BUTTONS =====
            Padding(
              padding: const EdgeInsets.only(left: 22, right: 22, bottom: 18),
              child: Row(
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
