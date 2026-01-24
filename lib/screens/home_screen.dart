import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD3E1EC), // Light blue-gray background
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section - no background color
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  // Avatar/mascot image
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
                          return const Center(
                            child: Icon(
                              Icons.person,
                              color: Colors.blue,
                              size: 28,
                            ),
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
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF333333), // Dark text
                            ),
                      ),
                      Text(
                        'Ayo kita bermain',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF666666), // Gray text
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Category section title
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

            // Category cards
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
                      color: AppTheme.categoryBlue,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const GameScreen(category: 'Kemandirian Diri'),
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

  Widget _buildCategoryCard(
    BuildContext context, {
    required String imagePath,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFFFD93D), // Yellow background
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFFD93D).withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Brush icon - top left
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                'assets/images/home/Brush.png',
                width: 48,
                height: 48,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox.shrink();
                },
              ),
            ),
            // Teal image container - top right
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: const Color(0xFF5BB5B0), // Teal color
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          _getIconForCategory(title),
                          size: 36,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            // Text at bottom
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title - italic style
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
                  // Subtitle
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

  IconData _getIconForCategory(String title) {
    switch (title) {
      case 'Kemandirian Diri':
        return Icons.person_outline;
      case 'Kenali Sekitarmu':
        return Icons.explore_outlined;
      case 'Emosi & Sosial':
        return Icons.favorite_outline;
      case 'Tanggung Jawab':
        return Icons.star_outline;
      default:
        return Icons.category_outlined;
    }
  }
}
