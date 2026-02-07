import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/home_menu_card.dart';
import '../../tidy_toys/presentation/screens/tidy_toys_screen.dart';
import '../../trash_game/presentation/screens/trash_game_screen.dart';
import '../../feed_animals/presentation/screens/feed_animals_screen.dart';
import '../../../../core/theme/app_colors.dart';

import 'package:flutter_tts/flutter_tts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FlutterTts flutterTts;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    flutterTts.setLanguage("id-ID");
    _playWelcomeMessage();
  }

  Future<void> _playWelcomeMessage() async {
    await Future.delayed(const Duration(milliseconds: 500)); // Short delay
    await flutterTts.speak("halo anak hebat, ayo pilih permainan yang kamu suka");
  }

  @override
  Widget build(BuildContext context) {
    // Set status bar color
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD), // Light Blue Background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Column(
                  children: const [
                    Text(
                      "Tanggung Jawabku",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Aku bisa melakukannya!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Section Title
                const Text(
                  "Pilih Petualanganmu",
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 16),
                
                // Kemandirian Diri (Yellow) -> Tidy Toys
                HomeMenuCard(
                  title: "Rapikan Mainan",
                  subtitle: "Belajar merawat diri sendiri",
                  color: AppColors.pastelYellow,
                  icon: Icons.toys,
                  imagePath: 'assets/images/home_icon_tidy.jpg',
                  onTap: () {
                    flutterTts.stop(); 
                    Navigator.push(
                      context,
                      _createRoute(const TidyToysScreen()),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Kenal Sekitarku (Green) -> Trash Game
                HomeMenuCard(
                  title: "Buang Sampah",
                  subtitle: "Eksplorasi lingkungan rumah",
                  color: AppColors.pastelGreen,
                  icon: Icons.delete,
                  imagePath: 'assets/images/home_icon_trash.jpg',
                  onTap: () {
                    flutterTts.stop();
                    Navigator.push(
                      context,
                      _createRoute(const TrashGameScreen()),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Emosi & Sosial (Red) -> Feed Animals
                HomeMenuCard(
                  title: "Beri Makan Hewan",
                  subtitle: "Kenali perasaan teman-teman",
                  color: AppColors.pastelRed,
                  icon: Icons.pets,
                  imagePath: 'assets/images/home_icon_feed.jpg',
                  onTap: () {
                    flutterTts.stop();
                    Navigator.push(
                      context,
                      _createRoute(const FeedAnimalsScreen()),
                    );
                  },
                ),
                
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 0.1);
        var end = Offset.zero;
        var curve = Curves.easeOutQuart;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var fadeTween = Tween(begin: 0.0, end: 1.0);

        return FadeTransition(
          opacity: animation.drive(fadeTween),
          child: SlideTransition(
            position: animation.drive(tween),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
    );
  }
}
