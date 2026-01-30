import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/game_layout.dart';
import '../providers/trash_game_provider.dart';
import '../widgets/trash_bin_target.dart';
import '../widgets/trash_draggable.dart';

import '../../../../core/widgets/hint_animator.dart';
import '../../../../core/widgets/ghost_hinter.dart';

class TrashGameScreen extends StatefulWidget {
  const TrashGameScreen({super.key});

  @override
  State<TrashGameScreen> createState() => _TrashGameScreenState();
}

class _TrashGameScreenState extends State<TrashGameScreen> {
  late FlutterTts flutterTts;
  bool _showCelebration = false;
  bool _isHintActive = false;
  int _mistakeCount = 0;
  Timer? _idleTimer;
  bool _isIdle = false;

  @override
  void initState() {
    super.initState();
    super.initState();
    _initTts();
    _startIdleTimer();
  }

  @override
  void dispose() {
    _idleTimer?.cancel();
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

  void _initTts() async {
    flutterTts = FlutterTts();
    await flutterTts.setLanguage("id-ID");
    await flutterTts.speak("Ayo buang sampah ke tempatnya!");
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TrashGameProvider(),
      child: Consumer<TrashGameProvider>(
        builder: (context, provider, child) {
        
        // Check win condition to show celebration
        if (provider.isGameFinished && !_showCelebration) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _showCelebration = true;
            });
            flutterTts.speak("Hebat! Kamu berhasil membuang semua sampah.");
          });
        }

          return GameLayout(
            title: "Tanggung Jawab",
            subTitle: "Misi Buang Sampah",
            instruction: "Ayo masukkan semua sampah ke dalam kotak sampah!",
            progress: provider.isGameFinished ? 1.0 : (provider.items.where((i) => i.isDropped).length / provider.items.length),
            progressLabel: "${provider.items.where((i) => i.isDropped).length}/${provider.items.length}",
            showHintGlow: _mistakeCount >= 2 || _isIdle,
            headerColor: Colors.lightBlue[50]!,
            backgroundColor: const Color(0xFF87CEEB), // Sky Blue
            onHint: provider.isGameFinished ? null : () {
               setState(() {
                  _mistakeCount = 0;
                  _isIdle = false;
               });
               _resetIdleTimer();
               
               flutterTts.speak("Geser sampah ke dalam tong sampah!");
               setState(() => _isHintActive = true);
               Future.delayed(const Duration(seconds: 3), () {
                 if (mounted) setState(() => _isHintActive = false);
               });
            },
            bottomAction: Center(
            child: AppButton(
              label: "Lanjut",
              color: AppColors.pastelGreen,
              onPressed: () {
                if (provider.isGameFinished) {
                  Navigator.of(context).pop();
                } else {
                  flutterTts.speak("Selesaikan dulu ya!");
                }
              },
            ),
          ),
          child: Stack(
            children: [
               // Ground (Green)
               Positioned(
                 bottom: 0,
                 left: 0,
                 right: 0,
                 height: 150,
                 child: Container(color: Colors.lightGreen),
               ),
               
               // Background Elements
               Positioned(
                 top: 20,
                 left: 20,
                 child: Image.asset('assets/images/cloud.png', width: 100),
               ),
               Positioned(
                 top: 40,
                 right: 40,
                 child: Image.asset('assets/images/cloud.png', width: 80),
               ),
                
               // Tree (shifted to left or right bottom)
               Positioned(
                 bottom: 100,
                 left: -20,
                 child: Image.asset('assets/images/tree.png', height: 200),
               ),
               
              // Trash Items
              if (!provider.isGameFinished)
                Align(
                  alignment: const Alignment(0, -0.4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: provider.items.map((item) {
                      if (item.isDropped) {
                        return const SizedBox(width: 80, height: 80); // Maintain space
                      }
                      return HintAnimator(
                        active: _isHintActive,
                        child: TrashDraggable(
                          item: item,
                          onDragStarted: _stopIdleTimer,
                          onDragCompleted: _resetIdleTimer,
                          onDragCanceled: () {
                             _resetIdleTimer();
                             setState(() {
                               _mistakeCount++;
                             });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),

              // Bin Target
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: HintAnimator(
                    active: _isHintActive,
                    child: const TrashBinTarget(),
                  ),
                ),
              ),

               // Ghost Hint (Moved to top)
               if (provider.items.any((i) => !i.isDropped))
                 Builder(
                   builder: (context) {
                     final activeItem = provider.items.firstWhere((i) => !i.isDropped);
                     return GhostHinter(
                       active: _isHintActive,
                       startAlignment: const Alignment(0, -0.4), 
                       endAlignment: Alignment.bottomCenter, 
                       child: IgnorePointer(
                         child: Transform.scale(
                           scale: 0.8, 
                           child: TrashDraggable(item: activeItem)
                         ),
                       ),
                     );
                   }
                 ),

                // Success Message
                if (provider.isGameFinished)
                   Center(
                     child: Container(
                       padding: const EdgeInsets.all(20),
                       color: Colors.white.withOpacity(0.9),
                       child: const Text("Yey! Bersih sekali!", style: TextStyle(fontSize: 30, color: Colors.green, fontWeight: FontWeight.bold)),
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
}
