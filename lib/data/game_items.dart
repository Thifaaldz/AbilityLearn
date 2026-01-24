class GameItem {
  final String id;
  final String name;
  final String imagePath;

  const GameItem({
    required this.id,
    required this.name,
    required this.imagePath,
  });
}

class KenalSekitarkuItems {

  static const pillow = GameItem(
    id: 'pillow',
    name: 'Pillow',
    imagePath: 'assets/images/items/pillow.png',
  );

  static const blanket = GameItem(
    id: 'blanket',
    name: 'Blanket',
    imagePath: 'assets/images/items/blanket.png',
  );

  static const bed = GameItem(
    id: 'bed',
    name: 'Bed',
    imagePath: 'assets/images/items/bed.png',
  );

  static const wardrobe = GameItem(
    id: 'wardrobe',
    name: 'Wardrobe',
    imagePath: 'assets/images/items/wardrobe.png',
  );

  static const lamp = GameItem(
    id: 'lamp',
    name: 'Lamp',
    imagePath: 'assets/images/items/lamp.png',
  );

  static const spoon = GameItem(
    id: 'spoon',
    name: 'Spoon',
    imagePath: 'assets/images/items/spoon.png',
  );

  static const pan = GameItem(
    id: 'pan',
    name: 'Pan',
    imagePath: 'assets/images/items/pan.png',
  );

  static const plate = GameItem(
    id: 'plate',
    name: 'Plate',
    imagePath: 'assets/images/items/plate.png',
  );

  static const knife = GameItem(
    id: 'knife',
    name: 'Knife',
    imagePath: 'assets/images/items/knife.png',
  );

  static const riceCooker = GameItem(
    id: 'rice_cooker',
    name: 'Rice Cooker',
    imagePath: 'assets/images/items/rice_cooker.png',
  );

  static const shower = GameItem(
    id: 'shower',
    name: 'Shower',
    imagePath: 'assets/images/items/shower.png',
  );

  static const soap = GameItem(
    id: 'soap',
    name: 'Soap',
    imagePath: 'assets/images/items/soap.png',
  );

  static const toothbrush = GameItem(
    id: 'toothbrush',
    name: 'Toothbrush',
    imagePath: 'assets/images/items/toothbrush.png',
  );

  static const towel = GameItem(
    id: 'towel',
    name: 'Towel',
    imagePath: 'assets/images/items/towel.png',
  );

  static const shampoo = GameItem(
    id: 'shampoo',
    name: 'Shampoo',
    imagePath: 'assets/images/items/shampoo.png',
  );

  static const sofa = GameItem(
    id: 'sofa',
    name: 'Sofa',
    imagePath: 'assets/images/items/sofa.png',
  );

  static const table = GameItem(
    id: 'table',
    name: 'Table',
    imagePath: 'assets/images/items/table.png',
  );

  static List<GameItem> all = [
    pillow, blanket, bed, wardrobe, lamp,
    spoon, pan, plate, knife, riceCooker,
    shower, soap, toothbrush, towel, shampoo,
    sofa, table,
  ];

  static GameItem getById(String id) {
    return all.firstWhere(
      (item) => item.id == id,
      orElse: () => throw Exception('Item $id not found'),
    );
  }
}
