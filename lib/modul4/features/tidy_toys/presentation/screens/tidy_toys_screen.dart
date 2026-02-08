import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/game_layout.dart';
import '../providers/tidy_toys_provider.dart';
import '../../data/models/toy_item.dart';
import 'package:ability_learn/providers/audio_provider.dart';

import 'package:lottie/lottie.dart';
import '../../../../core/widgets/hint_animator.dart';
import '../../../../core/widgets/ghost_hinter.dart';

class TidyToysScreen extends StatefulWidget {
  const TidyToysScreen({super.key});

  @override
  State<TidyToysScreen> createState() => _TidyToysScreenState();
}

class _TidyToysScreenState extends State<TidyToysScreen> {
  late FlutterTts flutterTts;
  bool _showCelebration = false;
  bool _isHintActive = false;
  int _mistakeCount = 0;
  Timer? _idleTimer;
  bool _isIdle = false;
  final AudioPlayer _backgroundPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    flutterTts.setLanguage("id-ID");
    flutterTts.speak("Ayo masukkan mainan ke kotak!");

    _playBackgroundMusic(); // play background
    _startIdleTimer();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AudioProvider>().stopHomeBackgroundMusic();
    });
  }

  @override
  void dispose() {
    _idleTimer?.cancel();
    _backgroundPlayer.dispose();
    super.dispose();
  }

  void _playBackgroundMusic() async {
    try {
      await _backgroundPlayer.setReleaseMode(ReleaseMode.loop);
      await _backgroundPlayer.play(
        AssetSource('audio/background music.mp3'),
      );
    } catch (e) {
      print("Error playing background music: $e");
    }
  }

  void _startIdleTimer() {
    _idleTimer?.cancel();
    _idleTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) setState(() => _isIdle = true);
    });
  }

  void _resetIdleTimer() {
    if (mounted) setState(() => _isIdle = false);
    _startIdleTimer();
  }

  void _stopIdleTimer() {
    _idleTimer?.cancel();
    if (mounted) setState(() => _isIdle = false);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TidyToysProvider(),
      child: Consumer<TidyToysProvider>(
        builder: (context, provider, _) {

          if (provider.isGameFinished && !_showCelebration) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                _showCelebration = true;
              });
              flutterTts.speak("Hebat! Kamu berhasil merapikan semua mainan.");
            });
          }

          return GameLayout(
            title: "Tanggung Jawab",
            subTitle: "Misi Rapikan Mainan",
            instruction: "Ayo masukkan mainan ke kotak!",
            progress: provider.progress,
            progressLabel:
                "${provider.toys.where((t) => t.isTidied).length}/${provider.toys.length}",
            showHintGlow: _mistakeCount >= 2 || _isIdle,
            headerColor: Colors.white,
            backgroundColor: const Color(0xFFE3F2FD),
            onHint: provider.isGameFinished
                ? null
                : () {
                    setState(() {
                      _mistakeCount = 0;
                      _isIdle = false;
                    });
                    _resetIdleTimer();

                    flutterTts.speak("Geser mainan ke dalam kotak coklat!");
                    setState(() => _isHintActive = true);
                    Future.delayed(const Duration(seconds: 3), () {
                      if (mounted) setState(() => _isHintActive = false);
                    });
                  },
            bottomAction: Center(
              child: AppButton(
                label: "Lanjutkan",
                color: AppColors.pastelBlue,
                onPressed: () {
                  if (provider.isGameFinished) {
                    Navigator.pop(context);
                  } else {
                    flutterTts.speak("Mainannya belum rapi nih!");
                  }
                },
              ),
            ),
            child: Stack(
              children: [

                if (_showCelebration)
                  Align(
                    alignment: Alignment.center,
                    child: LottieBuilder.network(
                      'https://assets10.lottiefiles.com/packages/lf20_u4yrau.json',
                      repeat: false,
                    ),
                  ),

                ...provider.toys.asMap().entries.map((entry) {
                  final index = entry.key;
                  final toy = entry.value;

                  if (toy.isTidied) return const SizedBox.shrink();

                  Alignment alignment;
                  switch (index % 4) {
                    case 0:
                      alignment = const Alignment(-0.7, -0.8);
                      break;
                    case 1:
                      alignment = const Alignment(0.7, -0.8);
                      break;
                    case 2:
                      alignment = const Alignment(-0.5, -0.3);
                      break;
                    case 3:
                      alignment = const Alignment(0.5, -0.3);
                      break;
                    default:
                      alignment = const Alignment(0.0, -0.6);
                  }

                  return Align(
                    alignment: alignment,
                    child: HintAnimator(
                      active: _isHintActive,
                      child: Draggable<ToyItem>(
                        data: toy,
                        onDragStarted: _stopIdleTimer,
                        onDragCompleted: _resetIdleTimer,
                        onDraggableCanceled: (_, __) {
                          _resetIdleTimer();
                          setState(() => _mistakeCount++);
                        },
                        feedback:
                            Transform.scale(scale: 1.2, child: _buildToyIcon(toy)),
                        childWhenDragging:
                            Opacity(opacity: 0.5, child: _buildToyIcon(toy)),
                        child: _buildToyIcon(toy),
                      ),
                    ),
                  );
                }),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: DragTarget<ToyItem>(
                    onAccept: (toy) {
                      provider.handleDrop(toy);
                    },
                    builder: (context, candidates, rejects) {
                      final isHovered = candidates.isNotEmpty;
                      return HintAnimator(
                        active: _isHintActive,
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 300),
                          scale: isHovered ? 1.2 : 1.0,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            width: 280,
                            height: 220,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: isHovered
                                  ? [
                                      BoxShadow(
                                        color: Colors.amber.withOpacity(0.8),
                                        blurRadius: 30,
                                        spreadRadius: 5,
                                      )
                                    ]
                                  : [],
                            ),
                            child: Image.asset(
                              'assets/images/modul4/toy_box_new.jpg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildToyIcon(ToyItem toy) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Image.asset(toy.imageAsset, fit: BoxFit.contain),
    );
  }
}
