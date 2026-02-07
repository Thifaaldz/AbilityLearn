enum FoodType { food, drink }

class FoodItem {
  final String id;
  final String name;
  final String imageAsset;
  final FoodType type;
  final bool isFed;

  FoodItem({
    required this.id,
    required this.name,
    required this.imageAsset,
    required this.type,
    this.isFed = false,
  });

  FoodItem copyWith({bool? isFed}) {
    return FoodItem(
      id: id,
      name: name,
      imageAsset: imageAsset,
      type: type,
      isFed: isFed ?? this.isFed,
    );
  }
}
