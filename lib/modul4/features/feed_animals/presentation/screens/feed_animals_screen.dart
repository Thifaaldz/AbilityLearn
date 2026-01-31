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

  void _playBackgroundMusic() async {
    try {
      await _backgroundPlayer.setVolume(0.3); // Lower volume for background music
      await _backgroundPlayer.setReleaseMode(ReleaseMode.loop);
      await _backgroundPlayer.play(AssetSource('audio/background music.mp3'));
    } catch (e) {
      print("Error playing background music: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FeedAnimalsProvider(),
      child: Consumer<FeedAnimalsProvider>(
        builder: (context, provider, _) {
            
           if (provider.isGameFinished && !_showCelebration) {
             WidgetsBinding.instance.addPostFrameCallback((_) {
               setState(() {
                 _showCelebration = true;
               });
               flutterTts.speak("Hebat! Hewan peliharaanmu sudah kenyang.");
             });
           }

          return GameLayout(
            title: "Tanggung Jawab",
            subTitle: "Misi Memberi Makan Hewan",
            instruction: "Geser Makanan Ke dalam Mangkuk!",
            progress: provider.progress,
            progressLabel: "${provider.items.where((i) => i.isFed).length}/${provider.items.length}",
            showHintGlow: _mistakeCount >= 2 || _isIdle,
            headerColor: Colors.white,
            backgroundColor: const Color(0xFFC9F3FF), // Light Sky
            onHint: provider.isGameFinished ? null : () {
               setState(() {
                  _mistakeCount = 0;
                  _isIdle = false;
               });
               _resetIdleTimer();

               flutterTts.speak("Geser makanan ke mangkuk merah, dan susu ke mangkuk biru!");
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
                       flutterTts.speak("Kucingnya masih lapar nih!");
                   }
                },
              ),
            ),
            child: Stack(
              children: [
                // Ground
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 200,
                  child: Container(color: const Color(0xFF8D6E63)), // Brownish ground/floor
                ),

                // Cat Character (Center)
                Align(
                  alignment: const Alignment(0, -0.2),
                  child: Image.asset('assets/images/cat.png', height: 250),
                ),

                // Bowls (Targets)
                Align(
                   alignment: const Alignment(-0.6, 0.4),
                   child: _buildBowlTarget(
                     context, 
                     provider, 
                     FoodType.drink, 
                     'assets/images/bowl_blue.png'
                   ),
                ),
                Align(
                   alignment: const Alignment(0.6, 0.4),
                   child: _buildBowlTarget(
                     context, 
                     provider, 
                     FoodType.food, 
                     'assets/images/bowl_red.png'
                   ),
                ),

                // Food Items (Sources)
                // In a real row below the cat or free floating
                if (!provider.isGameFinished)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: provider.items.map((item) {
                          if (item.isFed) {
                            return const SizedBox(width: 100, height: 120); // Maintain space
                          }
                          return HintAnimator( // Added HintAnimator
                            active: _isHintActive,
                            child: Draggable<FoodItem>(
                              data: item,
                              onDragStarted: _stopIdleTimer,
                              onDragCompleted: _resetIdleTimer,
                              onDraggableCanceled: (_, __) {
                                _resetIdleTimer(); 
                                setState(() => _mistakeCount++);
                              },
                              feedback: Transform.scale(scale: 1.2, child: _buildFoodIcon(item)),
                              childWhenDragging: Opacity(opacity: 0.5, child: _buildFoodIcon(item)),
                              child: _buildFoodIcon(item),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                // Ghost Hints
                if (provider.items.any((i) => !i.isFed)) ...[
                   Builder(builder: (context) {
                     // We want to show hints for EACH type if available
                     final hints = <Widget>[];
                     
                     // Find first available drink
                     try {
                        final drink = provider.items.firstWhere((i) => i.type == FoodType.drink && !i.isFed);
                        hints.add(
                          GhostHinter(
                             active: _isHintActive,
                             startAlignment: Alignment.bottomCenter,
                             endAlignment: const Alignment(-0.6, 0.4), // Blue Bowl
                             child: IgnorePointer(
                               child: Hero(tag: 'ghost_${drink.id}', child: _buildFoodIcon(drink)),
                             ),
                          )
                        );
                     } catch (_) {}

                     // Find first available food
                     try {
                        final food = provider.items.firstWhere((i) => i.type == FoodType.food && !i.isFed);
                        hints.add(
                          GhostHinter(
                             active: _isHintActive,
                             startAlignment: Alignment.bottomCenter,
                             endAlignment: const Alignment(0.6, 0.4), // Red Bowl
                             child: IgnorePointer(
                               child: Hero(tag: 'ghost_${food.id}', child: _buildFoodIcon(food)),
                             ),
                          )
                        );
                     } catch (_) {}

                     return Stack(children: hints);
                   }),
                ],
                  
                if (provider.isGameFinished)
                   Center(
                     child: Container(
                       padding: const EdgeInsets.all(20),
                       color: Colors.white.withOpacity(0.9),
                       child: const Text("Yey! Hewan kenyang!", style: TextStyle(fontSize: 30, color: Colors.green, fontWeight: FontWeight.bold)),
                     ),
                   ),

                if (_showCelebration)
                   Align(
                     alignment: Alignment.center,
                     child: LottieBuilder.network(
                       'https://assets10.lottiefiles.com/packages/lf20_u4yrau.json',
                       repeat: false,
                     ),
                   )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBowlTarget(BuildContext context, FeedAnimalsProvider provider, FoodType type, String imageAsset) {
    return DragTarget<FoodItem>(
      onWillAccept: (data) => data?.type == type,
      onAccept: (data) {
        provider.handleDrop(data, type);
      },
      builder: (context, candidates, rejects) {
        final isHovered = candidates.isNotEmpty;
        return HintAnimator(
           active: _isHintActive,
           child: AnimatedScale(
             duration: const Duration(milliseconds: 300),
             scale: isHovered ? 1.2 : 1.0,
             child: Container(
               width: 140,
               height: 100,
               decoration: BoxDecoration(
                 shape: BoxShape.circle,
                 boxShadow: isHovered
                     ? [
                         BoxShadow(
                           color: Colors.yellowAccent.withOpacity(0.8),
                           blurRadius: 20,
                           spreadRadius: 5,
                         )
                       ]
                     : [],
               ),
               child: Image.asset(imageAsset, fit: BoxFit.contain),
             ),
           ),
        );
      },
    );
  }

  Widget _buildFoodIcon(FoodItem item) {
     return SizedBox(
         width: 100, 
         height: 120,
         child: Image.asset(item.imageAsset, fit: BoxFit.contain),
     );
  }
}
