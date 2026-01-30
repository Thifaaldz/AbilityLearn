import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/home_menu_card.dart';
import '../../tidy_toys/presentation/screens/tidy_toys_screen.dart';
import '../../trash_game/presentation/screens/trash_game_screen.dart';
import '../../feed_animals/presentation/screens/feed_animals_screen.dart';

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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFF9C4), Color(0xFFFFECB3)], // Soft Yellow Gradient
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header / Banner
                  Container(
                    margin: const EdgeInsets.only(bottom: 30, top: 20),
                    height: 120, // Adjust height as needed
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                         BoxShadow(
                           color: Colors.black.withOpacity(0.1),
                           blurRadius: 10,
                           offset: const Offset(0, 5),
                         )
                      ],
                      image: const DecorationImage(
                        image: AssetImage('assets/images/banner_aku_anak_hebat.png'),
                        fit: BoxFit.contain, // Or cover, depending on asset
                      ),
                    ),
                  ),

                  // Menu Grid
                  const SizedBox(height: 10),
                  
                  // Tidy Toys Button
                  HomeMenuCard(
                    imagePath: 'assets/images/btn_rapikan_mainan.png',
                    onTap: () {
                      flutterTts.stop(); 
                      Navigator.push(
                        context,
                        _createRoute(const TidyToysScreen()),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // Throw Trash Button
                  HomeMenuCard(
                    imagePath: 'assets/images/btn_buang_sampah.png',
                    onTap: () {
                      flutterTts.stop();
                      Navigator.push(
                        context,
                        _createRoute(const TrashGameScreen()),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // Feed Animals Button
                  HomeMenuCard(
                    imagePath: 'assets/images/btn_memberi_makan.png',
                    onTap: () {
                      flutterTts.stop();
                      Navigator.push(
                        context,
                        _createRoute(const FeedAnimalsScreen()),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 30),
                  const Center(
                    child: Text(
                      "Ayo Pilih Kegiatan Yang Kamu Suka",
                      style: TextStyle(
                        fontFamily: 'Nunito', // Assuming font
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ],
              ),
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
