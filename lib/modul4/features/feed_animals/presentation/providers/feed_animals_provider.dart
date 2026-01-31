import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../data/models/food_item.dart';

class FeedAnimalsProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  List<FoodItem> _items = [
    FoodItem(id: '1', name: 'Susu', imageAsset: 'assets/images/milk.png', type: FoodType.drink),
    FoodItem(id: '2', name: 'Makanan', imageAsset: 'assets/images/cat_food.png', type: FoodType.food),
  ];

  List<FoodItem> get items => _items;
  bool get isGameFinished => _items.every((i) => i.isFed);
  double get progress => _items.where((i) => i.isFed).length / _items.length;

  void handleDrop(FoodItem item, FoodType targetType) async {
    if (item.type == targetType) {
      // Success match
      try {
        await _audioPlayer.play(AssetSource('audio/success.mp3'));
      } catch (_) {}
      
      final index = _items.indexWhere((i) => i.id == item.id);
      if (index != -1) {
        _items[index] = _items[index].copyWith(isFed: true);
        notifyListeners();
      }
    } else {
       // Wrong bowl feedback (optional, handled by UI not accepting or just no-op)
    }
  }
  
  void reset() {
    _items = _items.map((i) => i.copyWith(isFed: false)).toList();
    notifyListeners();
  }
}
