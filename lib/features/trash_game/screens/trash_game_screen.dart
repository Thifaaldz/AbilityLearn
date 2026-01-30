import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../utils/app_colors.dart';
import '../widgets/trash_can.dart';
import '../widgets/trash_item.dart';

class TrashGameScreen extends StatefulWidget {
  const TrashGameScreen({super.key});

  @override
  State<TrashGameScreen> createState() => _TrashGameScreenState();
}

class _TrashGameScreenState extends State<TrashGameScreen> {
  final FlutterTts flutterTts = FlutterTts();
  final AudioPlayer audioPlayer = AudioPlayer();

  // State management yang lebih baik
  final List<String> _initialTrashItems = ['sisa-apel', 'botol-plastik', 'kardus'];
  late List<String> _visibleTrashItems;
  final Map<String, Offset> _itemPositions = {};
  final Map<String, Offset> _itemAnimationStartOffsets = {};

  @override
  void initState() {
    super.initState();
    _initializeGame();
    _speakIntro();
  }

  void _initializeGame() {
    _visibleTrashItems = List.from(_initialTrashItems);
    final random = Random();
    final screenHeight = WidgetsBinding.instance.window.physicalSize.height / WidgetsBinding.instance.window.devicePixelRatio;
    final screenWidth = WidgetsBinding.instance.window.physicalSize.width / WidgetsBinding.instance.window.devicePixelRatio;

    for (var item in _visibleTrashItems) {
      final top = random.nextDouble() * (screenHeight * 0.4);
      final left = random.nextDouble() * (screenWidth * 0.7);
      _itemPositions[item] = Offset(left, top);
    }
  }

  Future<void> _speakIntro() async {
    await flutterTts.setLanguage("id-ID");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak("Ayo bantu membuang sampah pada tempatnya!");
  }

  void _onDrop(String item) {
    setState(() {
      _visibleTrashItems.remove(item);
    });

    _playSuccessSound();
    _showCelebration();

    if (_visibleTrashItems.isEmpty) {
      flutterTts.speak("Hore, semua sampah sudah dibuang! Kamu hebat!");
    } else {
      flutterTts.speak("Benar! Lanjut yuk!");
    }
  }

  Future<void> _playSuccessSound() async {
    // Pastikan path aset benar di pubspec.yaml
    // await audioPlayer.play(AssetSource('sounds/success.mp3'));
  }

  void _showCelebration() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: SizedBox(
            width: 200,
            height: 200,
            // Pastikan path aset benar di pubspec.yaml
            // child: Lottie.asset('assets/animations/celebration.json', repeat: false),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Misi Membuang Sampah'),
        backgroundColor: AppColors.pastelBlue,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: TrashCan(onDrop: _onDrop),
          ),
          ..._buildDraggableTrashItems(),
        ],
      ),
    );
  }

  List<Widget> _buildDraggableTrashItems() {
    if (!mounted) return [];
    return _visibleTrashItems.map((item) {
      final position = _itemPositions[item] ?? Offset.zero;

      return Positioned(
        top: position.dy,
        left: position.dx,
        child: Draggable<String>(
          data: item,
          feedback: TrashItem(name: item, size: 70),
          childWhenDragging: Container(),
          onDraggableCanceled: (velocity, offset) {
            final RenderBox renderBox = context.findRenderObject() as RenderBox;
            // Konversi offset global ke offset lokal dari Stack
            final localOffset = renderBox.globalToLocal(offset);
            setState(() {
              // Simpan posisi drop untuk memulai animasi dari sana
              _itemAnimationStartOffsets[item] = localOffset - position;
            });
          },
          child: TweenAnimationBuilder<Offset>(
            key: ValueKey("tween_$item"),
            tween: Tween<Offset>(
              begin: _itemAnimationStartOffsets[item] ?? Offset.zero,
              end: Offset.zero,
            ),
            duration: const Duration(milliseconds: 500),
            onEnd: () {
              // Hapus state animasi setelah selesai agar tidak berjalan lagi
              if (_itemAnimationStartOffsets.containsKey(item)) {
                setState(() {
                  _itemAnimationStartOffsets.remove(item);
                });
              }
            },
            builder: (context, Offset currentOffset, child) {
              return Transform.translate(
                offset: currentOffset,
                child: child,
              );
            },
            child: TrashItem(name: item, size: 60),
          ),
        ),
      );
    }).toList();
  }
}
