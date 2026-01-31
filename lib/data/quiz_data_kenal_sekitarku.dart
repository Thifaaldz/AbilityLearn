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
      correctItem: 'tempat_tidur',
      options: ['sofa', 'tempat_tidur'], // benar kanan
    ),

    QuizKenalSekitarku(
      id: 'kt2',
      instruction: 'Pilih benda untuk menyelimuti tubuh!',
      room: 'Kamar Tidur',
      correctItem: 'selimut',
      options: ['selimut', 'piring'], // benar kiri
    ),

    QuizKenalSekitarku(
      id: 'kt3',
      instruction: 'Pilih benda untuk alas kepala saat tidur!',
      room: 'Kamar Tidur',
      correctItem: 'bantal',
      options: ['sendok', 'bantal'], // benar kanan
    ),

    QuizKenalSekitarku(
      id: 'kt4',
      instruction: 'Pilih tempat untuk menyimpan pakaian!',
      room: 'Kamar Tidur',
      correctItem: 'lemari_pakaian',
      options: ['lemari_pakaian', 'kompor_nasi'], // benar kiri
    ),

    QuizKenalSekitarku(
      id: 'kt5',
      instruction: 'Pilih benda untuk menerangi kamar!',
      room: 'Kamar Tidur',
      correctItem: 'lampu',
      options: ['handuk', 'lampu'], // benar kanan
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
      correctItem: 'kompor_nasi',
      options: ['kompor_nasi', 'lampu'], // benar kiri
    ),

    QuizKenalSekitarku(
      id: 'dp2',
      instruction: 'Pilih alat untuk makan!',
      room: 'Dapur',
      correctItem: 'sendok',
      options: ['bantal', 'sendok'], // benar kanan
    ),

    QuizKenalSekitarku(
      id: 'dp3',
      instruction: 'Pilih alat untuk menggoreng!',
      room: 'Dapur',
      correctItem: 'wajan',
      options: ['wajan', 'sofa'], // benar kiri
    ),

    QuizKenalSekitarku(
      id: 'dp4',
      instruction: 'Pilih tempat untuk menaruh makanan!',
      room: 'Dapur',
      correctItem: 'piring',
      options: ['sabun', 'piring'], // benar kanan
    ),

    QuizKenalSekitarku(
      id: 'dp5',
      instruction: 'Pilih alat untuk memotong!',
      room: 'Dapur',
      correctItem: 'pisau',
      options: ['pisau', 'sampo'], // benar kiri
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
      correctItem: 'pancuran',
      options: ['sofa', 'pancuran'], // benar kanan
      audioPath: 'audio/Modul2/km1.mp3',
    ),

    QuizKenalSekitarku(
      id: 'km2',
      instruction: 'Pilih alat untuk menggosok gigi!',
      room: 'Kamar Mandi',
      correctItem: 'sikat_gigi',
      options: ['sikat_gigi', 'pisau'], // benar kiri
      audioPath: 'audio/Modul2/km2.mp3',
    ),

    QuizKenalSekitarku(
      id: 'km3',
      instruction: 'Pilih benda untuk membersihkan badan!',
      room: 'Kamar Mandi',
      correctItem: 'sabun',
      options: ['piring', 'sabun'], // benar kanan
      audioPath: 'audio/Modul2/km3.mp3',
    ),

    QuizKenalSekitarku(
      id: 'km4',
      instruction: 'Pilih benda untuk mengeringkan badan!',
      room: 'Kamar Mandi',
      correctItem: 'handuk',
      options: ['handuk', 'lampu'], // benar kiri
      audioPath: 'audio/Modul2/km4.mp3',
    ),

    QuizKenalSekitarku(
      id: 'km5',
      instruction: 'Pilih cairan untuk mencuci rambut!',
      room: 'Kamar Mandi',
      correctItem: 'sampo',
      options: ['kompor_nasi', 'sampo'], // benar kanan
      audioPath: 'audio/Modul2/km5.mp3',
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
      options: ['sofa', 'tempat_tidur'], // benar kiri
    ),

    QuizKenalSekitarku(
      id: 'rt2',
      instruction: 'Pilih meja untuk menaruh minuman!',
      room: 'Ruang Tamu',
      correctItem: 'meja',
      options: ['handuk', 'meja'], // benar kanan
    ),

    QuizKenalSekitarku(
      id: 'rt3',
      instruction: 'Pilih benda empuk untuk duduk santai!',
      room: 'Ruang Tamu',
      correctItem: 'sofa',
      options: ['wajan', 'sofa'], // benar kanan
    ),

    QuizKenalSekitarku(
      id: 'rt4',
      instruction: 'Pilih tempat untuk menaruh barang!',
      room: 'Ruang Tamu',
      correctItem: 'meja',
      options: ['meja', 'sampo'], // benar kiri
    ),

    QuizKenalSekitarku(
      id: 'rt5',
      instruction: 'Pilih tempat duduk yang nyaman!',
      room: 'Ruang Tamu',
      correctItem: 'sofa',
      options: ['lemari_pakaian', 'sofa'], // benar kanan
    ),
  ],
};
