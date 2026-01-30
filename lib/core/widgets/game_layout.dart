import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../features/home/screens/home_screen.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class GameLayout extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Widget child;
  final Widget? bottomAction;
  final double progress; // 0.0 to 1.0
  final String instruction;
  final Color headerColor;
  final Color backgroundColor;
  final VoidCallback? onHint;
  final String progressLabel;
  final bool showHintGlow;

  const GameLayout({
    super.key,
    required this.title,
    required this.child,
    this.subTitle,
    this.bottomAction,
    this.progress = 0.0,
    required this.instruction,
    this.headerColor = AppColors.background,
    this.backgroundColor = AppColors.background,
    this.onHint,
    this.progressLabel = "",
    this.showHintGlow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 600),
        tween: Tween(begin: 0.0, end: 1.0),
        curve: Curves.easeOutQuart,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 30 * (1 - value)),
              child: child,
            ),
          );
        },
        child: SafeArea(
          child: Column(
            children: [
              // ... existing column content ...
              // Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: headerColor,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 32),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(title, style: AppTextStyles.titleMedium),
                          if (subTitle != null)
                            Text(subTitle!,
                                style: AppTextStyles.bodyLarge
                                    .copyWith(fontSize: 16)),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.home, size: 36, color: Colors.orange),
                      onPressed: () {
                         Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),
              
              // Progress Bar & Instruction
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 12,
                              backgroundColor: Colors.grey[300],
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.orange),
                            ),
                          ),
                        ),
                        const Gap(10),
                        Text(progressLabel, style: AppTextStyles.bodyLarge),
                      ],
                    ),
                    const Gap(16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                           BoxShadow(
                             color: Colors.black.withOpacity(0.05),
                             blurRadius: 10,
                             offset: const Offset(0, 4),
                           )
                        ]
                      ),
                      child: Column(
                        children: [
                          Text(
                            instruction,
                            style: AppTextStyles.titleMedium.copyWith(fontSize: 20, color: AppColors.textSecondary),
                            textAlign: TextAlign.center,
                          ),
                          if (onHint != null)
                            Align(
                              alignment: Alignment.centerRight,
                              child: _HintButton(onPressed: onHint!, showGlow: showHintGlow),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Main Game Area
              Expanded(child: child),

              // Bottom Action Area
              if (bottomAction != null)
                Container(
                   padding: const EdgeInsets.all(24),
                   decoration: const BoxDecoration(
                     color: Color(0xFFFFFdd0), // Creamy background
                     borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                   ),
                   child: bottomAction,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HintButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool showGlow;

  const _HintButton({required this.onPressed, required this.showGlow});

  @override
  State<_HintButton> createState() => _HintButtonState();
}

class _HintButtonState extends State<_HintButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.0, end: 15.0).animate(
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _glowAnimation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: widget.showGlow // Only show shadow if requested
                    ? [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.6),
                    blurRadius: _glowAnimation.value,
                    spreadRadius: _glowAnimation.value / 2,
                  ),
                ] : [],
              ),
              child: child,
            );
          },
          child: IconButton(
            icon: const Icon(Icons.lightbulb_circle, size: 40, color: Colors.orange),
            onPressed: widget.onPressed,
          ),
        ),
        const Text(
          "Petunjuk",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }
}
