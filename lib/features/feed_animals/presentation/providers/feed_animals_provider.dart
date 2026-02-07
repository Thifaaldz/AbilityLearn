import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../data/models/food_item.dart';

enum FeedStage {
  thirsty,
  hungry,
  finished,
}

class FeedAnimalsProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  FeedStage _currentStage = FeedStage.thirsty;
  FeedStage get currentStage => _currentStage;

  List<FoodItem> _items = [
    FoodItem(id: '1', name: 'Susu', imageAsset: 'assets/images/cat_milk_new.png', type: FoodType.drink),
    FoodItem(id: '2', name: 'Makanan', imageAsset: 'assets/images/cat_food_new.png', type: FoodType.food),
  ];

  List<FoodItem> get items => _items;
  bool get isGameFinished => _currentStage == FeedStage.finished;
  
  // Progress based on stages: 0.0 (Thirsty), 0.5 (Hungry), 1.0 (Finished)
  double get progress {
    switch (_currentStage) {
      case FeedStage.thirsty: return 0.0;
      case FeedStage.hungry: return 0.5;
      case FeedStage.finished: return 1.0;
    }
  }

  void handleDrop(FoodItem item, FoodType targetType) async {
    // Validate drop against current stage
    if (_currentStage == FeedStage.thirsty && item.type != FoodType.drink) return;
    if (_currentStage == FeedStage.hungry && item.type != FoodType.food) return;

    if (item.type == targetType) {
      // Success match
      try {
        await _audioPlayer.play(AssetSource('audio/success.mp3'));
      } catch (_) {}
      
      final index = _items.indexWhere((i) => i.id == item.id);
      if (index != -1) {
        _items[index] = _items[index].copyWith(isFed: true);
        
        // Advance Stage
        if (_currentStage == FeedStage.thirsty) {
          _currentStage = FeedStage.hungry;
        } else if (_currentStage == FeedStage.hungry) {
          _currentStage = FeedStage.finished;
        }
        
        notifyListeners();
      }
    }
  }
  
  void reset() {
    _items = _items.map((i) => i.copyWith(isFed: false)).toList();
    _currentStage = FeedStage.thirsty;
    notifyListeners();
  }
}
