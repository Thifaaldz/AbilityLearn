import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../data/models/trash_item.dart';

class TrashGameProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  List<TrashItem> _items = [
    const TrashItem(
      id: '1',
      name: 'Apel',
      imageAsset: 'assets/images/trash_item_apple_new.png', 
      type: TrashType.organic,
    ),
    const TrashItem(
      id: '2',
      name: 'Kaleng',
      imageAsset: 'assets/images/trash_item_can_new.png',
      type: TrashType.inorganic,
    ),
    const TrashItem(
      id: '3',
      name: 'Botol',
      imageAsset: 'assets/images/trash_item_bottle_new.png',
      type: TrashType.inorganic,
    ),
  ];

  List<TrashItem> get items => _items;
  bool get isGameFinished => _items.every((i) => i.isDropped);

  Future<void> handleDrop(TrashItem item) async {
    // Play success sound
    // Note: Assuming assets/audio/pop.mp3 exists or similar. using default for now.
    // In real app, ensure assets are registered in pubspec.yaml
    try {
       await _audioPlayer.play(AssetSource('audio/success.mp3'));
    } catch (e) {
      debugPrint("Audio play failed: $e");
    }

    final index = _items.indexWhere((element) => element.id == item.id);
    if (index != -1) {
      _items[index] = _items[index].copyWith(isDropped: true);
      notifyListeners();
    }
  }

  void resetGame() {
    _items = _items.map((e) => e.copyWith(isDropped: false)).toList();
    notifyListeners();
  }
}
