import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class HomeMenuCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
  final String? imagePath; // Optional illustration
  final VoidCallback onTap;

  const HomeMenuCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
    this.imagePath,
    required this.onTap,
  });

  @override
  State<HomeMenuCard> createState() => _HomeMenuCardState();
}

class _HomeMenuCardState extends State<HomeMenuCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
       vsync: this,
       duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
           return Transform.scale(
             scale: _scaleAnimation.value,
             child: child,
           );
        },
        child: Container(
          height: 160,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
               BoxShadow(
                 color: widget.color.withOpacity(0.4),
                 blurRadius: 10,
                 offset: const Offset(0, 6),
               )
            ]
          ),
          child: Stack(
            children: [
              // Icon top left
              Align(
                alignment: Alignment.topLeft,
                child: Icon(widget.icon, color: Colors.white, size: 32),
              ),

              // Texts bottom left
              Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.subtitle,
                      style: const TextStyle(
                         fontFamily: 'Nunito',
                         fontSize: 14,
                         color: Colors.white70,
                         fontStyle: FontStyle.italic
                      ),
                    ),
                  ],
                ),
              ),

              // Illustration right
              if (widget.imagePath != null)
                Positioned(
                  right: -10,
                  bottom: -10,
                  top: 10,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(
                       widget.imagePath!,
                       fit: BoxFit.contain,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
