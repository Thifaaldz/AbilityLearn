import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../data/models/toy_item.dart';

class TidyToysProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  List<ToyItem> _toys = [
    ToyItem(id: '1', name: 'Robot', imageAsset: 'assets/images/modul4/toy_gamepad.png'), // Using gamepad as robot/tech toy
    ToyItem(id: '2', name: 'Bebek', imageAsset: 'assets/images/modul4/toy_duck.png'),
    ToyItem(id: '3', name: 'Mobil', imageAsset: 'assets/images/modul4/toy_car.png'),
    ToyItem(id: '4', name: 'Bola', imageAsset: 'assets/images/modul4/toy_ball.png'),
  ];

  List<ToyItem> get toys => _toys;
  bool get isGameFinished => _toys.every((t) => t.isTidied);
  double get progress => _toys.where((t) => t.isTidied).length / _toys.length;

  void handleDrop(ToyItem toy) async {
    // Play sound
    try {
      await _audioPlayer.play(AssetSource('audio/success.mp3'));
    } catch (_) {}

    final index = _toys.indexWhere((t) => t.id == toy.id);
    if (index != -1) {
      _toys[index] = _toys[index].copyWith(isTidied: true);
      notifyListeners();
    }
  }

  void reset() {
    _toys = _toys.map((t) => t.copyWith(isTidied: false)).toList();
    notifyListeners();
  }
}
