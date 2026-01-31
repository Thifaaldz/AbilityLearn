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
    id: 'bantal',
    name: 'Bantal',
    imagePath: 'assets/images/items/pillow.png',
  );

  static const blanket = GameItem(
    id: 'selimut',
    name: 'Selimut',
    imagePath: 'assets/images/items/blanket.png',
  );

  static const bed = GameItem(
    id: 'tempat_tidur',
    name: 'Tempat Tidur',
    imagePath: 'assets/images/items/bed.png',
  );

  static const wardrobe = GameItem(
    id: 'lemari_pakaian',
    name: 'Lemari Pakaian',
    imagePath: 'assets/images/items/wardrobe.png',
  );

  static const lamp = GameItem(
    id: 'lampu',
    name: 'Lampu',
    imagePath: 'assets/images/items/lamp.png',
  );

  static const spoon = GameItem(
    id: 'sendok',
    name: 'Sendok',
    imagePath: 'assets/images/items/spoon.png',
  );

  static const pan = GameItem(
    id: 'wajan',
    name: 'Wajan',
    imagePath: 'assets/images/items/pan.png',
  );

  static const plate = GameItem(
    id: 'piring',
    name: 'Piring',
    imagePath: 'assets/images/items/plate.png',
  );

  static const knife = GameItem(
    id: 'pisau',
    name: 'Pisau',
    imagePath: 'assets/images/items/knife.png',
  );

  static const riceCooker = GameItem(
    id: 'kompor_nasi',
    name: 'Kompor Nasi',
    imagePath: 'assets/images/items/rice_cooker.png',
  );

  static const shower = GameItem(
    id: 'pancuran',
    name: 'Pancuran',
    imagePath: 'assets/images/items/shower.png',
  );

  static const soap = GameItem(
    id: 'sabun',
    name: 'Sabun',
    imagePath: 'assets/images/items/soap.png',
  );

  static const toothbrush = GameItem(
    id: 'sikat_gigi',
    name: 'Sikat Gigi',
    imagePath: 'assets/images/items/toothbrush.png',
  );

  static const towel = GameItem(
    id: 'handuk',
    name: 'Handuk',
    imagePath: 'assets/images/items/towel.png',
  );

  static const shampoo = GameItem(
    id: 'sampo',
    name: 'Sampo',
    imagePath: 'assets/images/items/shampoo.png',
  );

  static const sofa = GameItem(
    id: 'sofa',
    name: 'Sofa',
    imagePath: 'assets/images/items/sofa.png',
  );

  static const table = GameItem(
    id: 'meja',
    name: 'Meja',
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
