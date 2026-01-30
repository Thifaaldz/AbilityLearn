import '../models/quiz_item.dart';

/// All available items in the game
///
/// TO ADD YOUR FIGMA ASSETS:
/// 1. Export images from Figma as PNG
/// 2. Place them in: mobilegame/assets/images/items/
/// 3. Update the imagePath below to match your file names
///
class GameItems {
  // Self-care items - UPDATE THESE PATHS TO MATCH YOUR FIGMA ASSETS
  static const toothbrush = SelectableItem(
    id: 'toothbrush',
    name: 'Sikat Gigi',
    imagePath: 'assets/images/items/Toothbrush.png',
  );
  static const toothpaste = SelectableItem(
    id: 'toothpaste',
    name: 'Pasta Gigi',
    imagePath: 'assets/images/items/pasta_gigi.png',
  );
  static const soap = SelectableItem(
    id: 'soap',
    name: 'Sabun',
    imagePath: 'assets/images/items/Soap.png',
  );
  static const shampoo = SelectableItem(
    id: 'shampoo',
    name: 'Sampo',
    imagePath: 'assets/images/items/sampo.png',
  );
  static const towel = SelectableItem(
    id: 'towel',
    name: 'Handuk',
    imagePath: 'assets/images/items/handuk.png',
  );
  static const pillow = SelectableItem(
    id: 'pillow',
    name: 'Bantal',
    imagePath: 'assets/images/items/bantal.png',
  );
  static const blanket = SelectableItem(
    id: 'blanket',
    name: 'Selimut',
    imagePath: 'assets/images/items/selimut.png',
  );
  static const spoon = SelectableItem(
    id: 'spoon',
    name: 'Sendok',
    imagePath: 'assets/images/items/sendok.png',
  );
  static const plate = SelectableItem(
    id: 'plate',
    name: 'Piring',
    imagePath: 'assets/images/items/piring.png',
  );
  static const shirt = SelectableItem(
    id: 'shirt',
    name: 'Baju',
    imagePath: 'assets/images/items/baju.png',
  );
  static const socks = SelectableItem(
    id: 'socks',
    name: 'Kaos Kaki',
    imagePath: 'assets/images/items/kaos_kaki.png',
  );
  static const shoes = SelectableItem(
    id: 'shoes',
    name: 'Sepatu',
    imagePath: 'assets/images/items/sepatu.png',
  );
  static const water = SelectableItem(
    id: 'water',
    name: 'Air',
    imagePath: 'assets/images/items/air.png',
  );
  static const guling = SelectableItem(
    id: 'guling',
    name: 'Guling',
    imagePath: 'assets/images/items/Guling.png',
  );
  static const permen = SelectableItem(
    id: 'permen',
    name: 'Permen',
    imagePath: 'assets/images/items/Candy.png',
  );
  static const comb = SelectableItem(
    id: 'comb',
    name: 'Sisir',
    imagePath: 'assets/images/items/sisir.png',
  );

  static List<SelectableItem> all = [
    toothbrush,
    toothpaste,
    soap,
    shampoo,
    towel,
    pillow,
    blanket,
    spoon,
    plate,
    shirt,
    socks,
    shoes,
    water,
    guling,
    permen,
    comb,
  ];

  static SelectableItem getById(String id) {
    return all.firstWhere((item) => item.id == id);
  }
}

final List<QuizItem> quizData = [
  // Sikat Gigi - Brushing Teeth
  const QuizItem(
    id: 'brush_teeth_1',
    instruction: 'Ayo sikat gigi!',
    category: 'sikat gigi',
    correctItems: ['toothbrush'],
    allItems: ['toothbrush', 'guling'],
    imagePath: 'assets/images/questions/SikatGigi.png',
  ),

  // Cuci Tangan - Washing Hands
  const QuizItem(
    id: 'wash_hands_1',
    instruction: 'Ayo cuci tangan!',
    category: 'cuci tangan',
    correctItems: ['soap'],
    allItems: ['soap', 'permen'],
    imagePath: 'assets/images/questions/WashHands.png',
  ),
];
