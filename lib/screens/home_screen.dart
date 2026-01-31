import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../providers/audio_provider.dart';
import 'game_screen.dart';
import 'kenal_sekitarku_screen.dart';
import 'emosi_sosial_screen.dart';
import '../modul4/features/home/screens/home_screen.dart' as Modul4HomeScreen;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AudioProvider>().playHomeBackgroundMusic();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD3E1EC),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/home/ProfilePictureHomepage.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.person,
                            color: Colors.blue,
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo, Teman!',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF333333),
                            ),
                      ),
                      Text(
                        'Ayo kita bermain',
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 13,
                                  color: const Color(0xFF666666),
                                ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // TITLE
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Pilih Petualanganmu',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
              ),
            ),

            const SizedBox(height: 16),

            // CATEGORY LIST
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                  children: [
                    _buildCategoryCard(
                      context,
                      imagePath: 'assets/images/home/teethimage.png',
                      title: 'Kemandirian Diri',
                      subtitle: 'Belajar merawat diri sendiri',
                      color: const Color(0xFFFFD93D),
                      iconPath: 'assets/images/home/Brush.png',
                      onTap: () {
                        context.read<AudioProvider>().stopHomeBackgroundMusic();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const GameScreen(category: 'Kemandirian Diri'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    _buildCategoryCard(
                      context,
                      imagePath: 'assets/images/home/home.png',
                      title: 'Kenal Sekitarku',
                      subtitle: 'Eksplorasi lingkungan rumah',
                      color: const Color(0xFF6CCF8E),
                      iconPath: 'assets/images/home/home.png',
                      onTap: () {
                        // Don't stop music here as it continues to KenalSekitarkuScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const KenalSekitarkuScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    _buildCategoryCard(
                      context,
                      imagePath: 'assets/images/home/emosi.png',
                      title: 'Emosi & Sosial',
                      subtitle: 'Kenali perasaan teman-teman',
                      color: const Color(0xFFFF6F6F),
                      iconPath: 'assets/images/home/SmileIcon.png',
                      onTap: () {
                        context.read<AudioProvider>().stopHomeBackgroundMusic();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const EmosiSosialScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    _buildCategoryCard(
                      context,
                      imagePath: 'assets/images/home/star.png',
                      title: 'Tanggung Jawab',
                      subtitle: 'Belajar menyelesaikan tugas',
                      color: const Color(0xFF5A9BFF),
                      iconPath: 'assets/images/home/StarIcon.png',
                      onTap: () {
                        // Don't stop music here as it continues to Modul4HomeScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Modul4HomeScreen.HomeScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // CATEGORY CARD WIDGET
  // =========================
  Widget _buildCategoryCard(
    BuildContext context, {
    required String imagePath,
    required String title,
    required String subtitle,
    required Color color,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                iconPath,
                width: 40,
                height: 40,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.image,
                        color: Colors.white,
                        size: 36,
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
