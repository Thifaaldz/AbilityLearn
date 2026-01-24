import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
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
                    ),
                    const SizedBox(height: 20),

                    _buildCategoryCard(
                      context,
                      imagePath: 'assets/images/home/homeimage.png',
                      title: 'Kenal Sekitarku',
                      subtitle: 'Eksplorasi lingkungan rumah',
                      color: const Color(0xFF6CCF8E),
                      iconPath: 'assets/images/home/HomeIcon.png',
                    ),
                    const SizedBox(height: 20),

                    _buildCategoryCard(
                      context,
                      imagePath: 'assets/images/home/heartimage.png',
                      title: 'Emosi & Sosial',
                      subtitle: 'Kenali perasaan teman-teman',
                      color: const Color(0xFFFF6F6F),
                      iconPath: 'assets/images/home/SmileIcon.png',
                    ),
                    const SizedBox(height: 20),

                    _buildCategoryCard(
                      context,
                      imagePath: 'assets/images/home/starimage.png',
                      title: 'Tanggung Jawab',
                      subtitle: 'Belajar menyelesaikan tugas',
                      color: const Color(0xFF5A9BFF),
                      iconPath: 'assets/images/home/StarIcon.png',
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

  Widget _buildCategoryCard(
    BuildContext context, {
    required String imagePath,
    required String title,
    required String subtitle,
    required Color color,
    required String iconPath,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GameScreen(category: title),
          ),
        );
      },
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
            // ICON LEFT
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

            // IMAGE RIGHT
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
                    errorBuilder: (_, __, ___) {
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

            // TEXT
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
