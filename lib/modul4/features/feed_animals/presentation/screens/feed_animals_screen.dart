import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/game_layout.dart';
import '../providers/feed_animals_provider.dart';
import '../../data/models/food_item.dart';
import 'package:ability_learn/providers/audio_provider.dart';

import 'package:lottie/lottie.dart';
import '../../../../core/widgets/hint_animator.dart';
import '../../../../core/widgets/ghost_hinter.dart';

class FeedAnimalsScreen extends StatefulWidget {
  const FeedAnimalsScreen({super.key});

  @override
  State<FeedAnimalsScreen> createState() => _FeedAnimalsScreenState();
}

class _FeedAnimalsScreenState extends State<FeedAnimalsScreen> {
  late FlutterTts flutterTts;
  final AudioPlayer _backgroundPlayer = AudioPlayer();

  bool _showCelebration = false;
  bool _isHintActive = false;
  int _mistakeCount = 0;
  Timer? _idleTimer;
  bool _isIdle = false;
  FeedStage? _lastStage;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    flutterTts.setLanguage("id-ID");
    flutterTts.speak("Geser makanan atau minuman ke mangkuk yang benar!");

    _playBackgroundMusic();
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
    await _backgroundPlayer.setVolume(0.3);
    await _backgroundPlayer.setReleaseMode(ReleaseMode.loop);
    await _backgroundPlayer.play(AssetSource('audio/background music.mp3'));
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
      create: (_) => FeedAnimalsProvider(),
      child: Consumer<FeedAnimalsProvider>(
        builder: (context, provider, _) {

          /// STAGE VOICE
          if (!provider.isGameFinished && _lastStage != provider.currentStage) {
            final current = provider.currentStage;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_lastStage != current) {
                _lastStage = current;
                String text = current == FeedStage.thirsty
                    ? "Kucing sedang haus, beri minum susu!"
                    : "Kucing sedang lapar, beri makan!";
                flutterTts.speak(text);
              }
            });
          }

          if (provider.isGameFinished && !_showCelebration) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() => _showCelebration = true);
              flutterTts.speak("Hebat! Kucingmu sudah kenyang dan senang.");
            });
          }

          return GameLayout(
            title: "Tanggung Jawab",
            subTitle: "Misi Memberi Makan Hewan",
            instruction: provider.currentStage == FeedStage.thirsty
                ? "Kucing sedang haus, beri minum susu!"
                : "Kucing sedang lapar, beri makan!",
            progress: provider.progress,
            progressLabel: provider.currentStage == FeedStage.thirsty ? "1/2" : "2/2",
            showHintGlow: _mistakeCount >= 2 || _isIdle,
            headerColor: Colors.white,
            backgroundColor: const Color(0xFFE3F2FD),

            onHint: provider.isGameFinished ? null : () {
              setState(() {
                _mistakeCount = 0;
                _isIdle = false;
              });
              _resetIdleTimer();

              String hintText = provider.currentStage == FeedStage.thirsty
                  ? "Geser susu ke mangkuk!"
                  : "Geser makanan ke mangkuk!";

              flutterTts.speak(hintText);
              setState(() => _isHintActive = true);
              Future.delayed(const Duration(seconds: 3),
                  () => mounted ? setState(() => _isHintActive = false) : null);
            },

            bottomAction: Center(
              child: AppButton(
                label: "Lanjutkan",
                color: AppColors.pastelBlue,
                onPressed: () {
                  if (provider.isGameFinished) {
                    Navigator.pop(context);
                  } else {
                    flutterTts.speak("Kucingnya masih butuh perhatianmu!");
                  }
                },
              ),
            ),

            child: Stack(
              children: [

                Align(
                  alignment: const Alignment(0, -0.6),
                  child: Image.asset('assets/images/modul4/cat_new.png', height: 230),
                ),

                Align(
                  alignment: const Alignment(-0.6, 0.1),
                  child: _buildBowlTarget(context, provider, FoodType.drink,
                      'assets/images/modul4/bowl_milk_new.png'),
                ),
                Align(
                  alignment: const Alignment(0.6, 0.1),
                  child: _buildBowlTarget(context, provider, FoodType.food,
                      'assets/images/modul4/bowl_food_new.png'),
                ),

                if (!provider.isGameFinished)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: provider.items.map((item) {
                          if (item.isFed) {
                            return const SizedBox(width: 120, height: 140);
                          }
                          return HintAnimator(
                            active: _isHintActive,
                            child: Draggable<FoodItem>(
                              data: item,
                              onDragStarted: _stopIdleTimer,
                              onDragCompleted: _resetIdleTimer,
                              onDraggableCanceled: (_, __) {
                                _resetIdleTimer();
                                setState(() => _mistakeCount++);
                              },
                              feedback: Transform.scale(
                                  scale: 1.2, child: _buildFoodIcon(item)),
                              childWhenDragging:
                                  Opacity(opacity: 0.5, child: _buildFoodIcon(item)),
                              child: _buildFoodIcon(item),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                if (_showCelebration)
                  Align(
                    alignment: Alignment.center,
                    child: LottieBuilder.network(
                      'https://assets10.lottiefiles.com/packages/lf20_u4yrau.json',
                      repeat: false,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBowlTarget(BuildContext context, FeedAnimalsProvider provider,
      FoodType type, String imageAsset) {

    bool isTargetActive = false;
    if (provider.currentStage == FeedStage.thirsty && type == FoodType.drink)
      isTargetActive = true;
    if (provider.currentStage == FeedStage.hungry && type == FoodType.food)
      isTargetActive = true;

    return DragTarget<FoodItem>(
      onWillAccept: (data) => data?.type == type && isTargetActive,
      onAccept: (data) => provider.handleDrop(data, type),
      builder: (context, candidates, rejects) {
        final isHovered = candidates.isNotEmpty && isTargetActive;

        return HintAnimator(
          active: _isHintActive && isTargetActive,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 300),
            scale: isHovered ? 1.2 : 1.0,
            child: SizedBox(
              width: 170,
              height: 130,
              child: Image.asset(imageAsset, fit: BoxFit.contain),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFoodIcon(FoodItem item) {
    return SizedBox(
      width: 120,
      height: 140,
      child: Image.asset(item.imageAsset, fit: BoxFit.contain),
    );
  }
}
