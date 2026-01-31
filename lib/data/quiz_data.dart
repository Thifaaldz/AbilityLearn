import '../models/quiz_item.dart';

/// Semua item yang tersedia di dalam game
///
/// CARA MENAMBAHKAN ASSET DARI FIGMA:
/// 1. Ekspor gambar dari Figma dalam format PNG
/// 2. Simpan ke: mobilegame/assets/images/items/
/// 3. Perbarui imagePath di bawah agar sesuai dengan nama file
///
class GameItems {
  // Item perawatan diri - PERBARUI PATH INI SESUAI ASSET FIGMA ANDA
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
    imagePath: 'assets/images/items/shampoo.png',
  );
  static const towel = SelectableItem(
    id: 'towel',
    name: 'Handuk',
    imagePath: 'assets/images/items/towel.png',
  );
  static const pillow = SelectableItem(
    id: 'pillow',
    name: 'Bantal',
    imagePath: 'assets/images/items/pillow.png',
  );
  static const blanket = SelectableItem(
    id: 'blanket',
    name: 'Selimut',
    imagePath: 'assets/images/items/blanket.png',
  );
  static const spoon = SelectableItem(
    id: 'spoon',
    name: 'Sendok',
    imagePath: 'assets/images/items/spoon.png',
  );
  static const plate = SelectableItem(
    id: 'plate',
    name: 'Piring',
    imagePath: 'assets/images/items/plate.png',
  );
  static const shirt = SelectableItem(
    id: 'shirt',
    name: 'Baju',
    imagePath: 'assets/images/items/shirt.png',
  );
  static const socks = SelectableItem(
    id: 'socks',
    name: 'Kaos Kaki',
    imagePath: 'assets/images/items/socks.png',
  );
  static const shoes = SelectableItem(
    id: 'shoes',
    name: 'Sepatu',
    imagePath: 'assets/images/items/shoes.png',
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
  // Sikat Gigi
  const QuizItem(
    id: 'brush_teeth_1',
    instruction: 'Ayo sikat gigi!',
    category: 'sikat gigi',
    correctItems: ['toothbrush'],
    allItems: ['toothbrush', 'guling'],
    imagePath: 'assets/images/questions/SikatGigi.png',
    audioPath: 'assets/audio/Modul1/brush_teeth.mp3',
  ),

  // Cuci Tangan
  const QuizItem(
    id: 'wash_hands_1',
    instruction: 'Ayo cuci tangan!',
    category: 'cuci tangan',
    correctItems: ['soap'],
    allItems: ['soap', 'permen'],
    imagePath: 'assets/images/questions/WashHands.png',
    audioPath: 'assets/audio/Modul1/wash_hands.mp3',
  ),

  // Mandi
  const QuizItem(
    id: 'bath_1',
    instruction: 'Ayo mandi!',
    category: 'mandi',
    correctItems: ['soap'],
    allItems: ['soap', 'permen'],
    imagePath: 'assets/images/questions/Bath.png',
    audioPath: 'assets/audio/Modul1/bath.mp3',
  ),

  // Makan
  const QuizItem(
    id: 'eat_1',
    instruction: 'Ayo makan!',
    category: 'makan',
    correctItems: ['spoon'],
    allItems: ['spoon', 'toothbrush'],
    imagePath: 'assets/images/questions/Eat.png',
    audioPath: 'assets/audio/Modul1/eat.mp3',
  ),

  // Berpakaian
  const QuizItem(
    id: 'dress_1',
    instruction: 'Ayo berpakaian!',
    category: 'berpakaian',
    correctItems: ['shirt'],
    allItems: ['shirt', 'pillow'],
    imagePath: 'assets/images/questions/Dress.png',
    audioPath: 'assets/audio/Modul1/dress.mp3',
  ),
];
  