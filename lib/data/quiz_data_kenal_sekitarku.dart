import '../models/quiz_item_kenal_sekitarku.dart';

final Map<String, List<QuizKenalSekitarku>> quizKenalSekitarkuByRoom = {

  // =========================
  // KAMAR TIDUR
  // =========================
  'Kamar Tidur': [

    QuizKenalSekitarku(
      id: 'kt1',
      instruction: 'Pilih tempat untuk tidur!',
      room: 'Kamar Tidur',
      correctItem: 'bed',
      options: ['sofa', 'bed'], // benar kanan
    ),

    QuizKenalSekitarku(
      id: 'kt2',
      instruction: 'Pilih benda untuk menyelimuti tubuh!',
      room: 'Kamar Tidur',
      correctItem: 'blanket',
      options: ['blanket', 'plate'], // benar kiri
    ),

    QuizKenalSekitarku(
      id: 'kt3',
      instruction: 'Pilih benda untuk alas kepala saat tidur!',
      room: 'Kamar Tidur',
      correctItem: 'pillow',
      options: ['spoon', 'pillow'], // benar kanan
    ),

    QuizKenalSekitarku(
      id: 'kt4',
      instruction: 'Pilih tempat untuk menyimpan pakaian!',
      room: 'Kamar Tidur',
      correctItem: 'wardrobe',
      options: ['wardrobe', 'rice_cooker'], // benar kiri
    ),

    QuizKenalSekitarku(
      id: 'kt5',
      instruction: 'Pilih benda untuk menerangi kamar!',
      room: 'Kamar Tidur',
      correctItem: 'lamp',
      options: ['towel', 'lamp'], // benar kanan
    ),
  ],

  // =========================
  // DAPUR
  // =========================
  'Dapur': [

    QuizKenalSekitarku(
      id: 'dp1',
      instruction: 'Pilih alat untuk memasak nasi!',
      room: 'Dapur',
      correctItem: 'rice_cooker',
      options: ['rice_cooker', 'lamp'], // benar kiri
    ),

    QuizKenalSekitarku(
      id: 'dp2',
      instruction: 'Pilih alat untuk makan!',
      room: 'Dapur',
      correctItem: 'spoon',
      options: ['pillow', 'spoon'], // benar kanan
    ),

    QuizKenalSekitarku(
      id: 'dp3',
      instruction: 'Pilih alat untuk menggoreng!',
      room: 'Dapur',
      correctItem: 'pan',
      options: ['pan', 'sofa'], // benar kiri
    ),

    QuizKenalSekitarku(
      id: 'dp4',
      instruction: 'Pilih tempat untuk menaruh makanan!',
      room: 'Dapur',
      correctItem: 'plate',
      options: ['soap', 'plate'], // benar kanan
    ),

    QuizKenalSekitarku(
      id: 'dp5',
      instruction: 'Pilih alat untuk memotong!',
      room: 'Dapur',
      correctItem: 'knife',
      options: ['knife', 'shampoo'], // benar kiri
    ),
  ],

  // =========================
  // KAMAR MANDI
  // =========================
  'Kamar Mandi': [

    QuizKenalSekitarku(
      id: 'km1',
      instruction: 'Pilih alat untuk mandi!',
      room: 'Kamar Mandi',
      correctItem: 'shower',
      options: ['sofa', 'shower'], // benar kanan
    ),

    QuizKenalSekitarku(
      id: 'km2',
      instruction: 'Pilih alat untuk menggosok gigi!',
      room: 'Kamar Mandi',
      correctItem: 'toothbrush',
      options: ['toothbrush', 'knife'], // benar kiri
    ),

    QuizKenalSekitarku(
      id: 'km3',
      instruction: 'Pilih benda untuk membersihkan badan!',
      room: 'Kamar Mandi',
      correctItem: 'soap',
      options: ['plate', 'soap'], // benar kanan
    ),

    QuizKenalSekitarku(
      id: 'km4',
      instruction: 'Pilih benda untuk mengeringkan badan!',
      room: 'Kamar Mandi',
      correctItem: 'towel',
      options: ['towel', 'lamp'], // benar kiri
    ),

    QuizKenalSekitarku(
      id: 'km5',
      instruction: 'Pilih cairan untuk mencuci rambut!',
      room: 'Kamar Mandi',
      correctItem: 'shampoo',
      options: ['rice_cooker', 'shampoo'], // benar kanan
    ),
  ],

  // =========================
  // RUANG TAMU
  // =========================
  'Ruang Tamu': [

    QuizKenalSekitarku(
      id: 'rt1',
      instruction: 'Pilih tempat duduk untuk tamu!',
      room: 'Ruang Tamu',
      correctItem: 'sofa',
      options: ['sofa', 'bed'], // benar kiri
    ),

    QuizKenalSekitarku(
      id: 'rt2',
      instruction: 'Pilih meja untuk menaruh minuman!',
      room: 'Ruang Tamu',
      correctItem: 'table',
      options: ['towel', 'table'], // benar kanan
    ),

    QuizKenalSekitarku(
      id: 'rt3',
      instruction: 'Pilih benda empuk untuk duduk santai!',
      room: 'Ruang Tamu',
      correctItem: 'sofa',
      options: ['pan', 'sofa'], // benar kanan
    ),

    QuizKenalSekitarku(
      id: 'rt4',
      instruction: 'Pilih tempat untuk menaruh barang!',
      room: 'Ruang Tamu',
      correctItem: 'table',
      options: ['table', 'shampoo'], // benar kiri
    ),

    QuizKenalSekitarku(
      id: 'rt5',
      instruction: 'Pilih tempat duduk yang nyaman!',
      room: 'Ruang Tamu',
      correctItem: 'sofa',
      options: ['wardrobe', 'sofa'], // benar kanan
    ),
  ],
};
