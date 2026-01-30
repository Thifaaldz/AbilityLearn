import 'package:flutter/material.dart';
import 'dart:async';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _firstLogoController;
  late AnimationController _secondLogoController;
  late Animation<double> _firstScaleAnimation;
  late Animation<double> _firstOpacityAnimation;
  late Animation<double> _secondScaleAnimation;
  late Animation<double> _secondOpacityAnimation;

  bool _showFirstLogo = true;
  bool _showSecondLogo = false;

  @override
  void initState() {
    super.initState();

    // First logo animation controller
    _firstLogoController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // First logo scale animation
    _firstScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _firstLogoController,
      curve: Curves.elasticOut,
    ));

    // First logo opacity animation
    _firstOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _firstLogoController,
      curve: Curves.easeIn,
    ));

    // Second logo animation controller
    _secondLogoController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Second logo scale animation
    _secondScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _secondLogoController,
      curve: Curves.elasticOut,
    ));

    // Second logo opacity animation
    _secondOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _secondLogoController,
      curve: Curves.easeIn,
    ));

    // Start first logo animation
    _firstLogoController.forward();

    // Sequence the animations
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        // Fade out first logo
        _firstLogoController.reverse().then((_) {
          setState(() {
            _showFirstLogo = false;
            _showSecondLogo = true;
          });
          // Start second logo animation
          _secondLogoController.forward();
        });
      }
    });

    // Navigate to home screen after second logo animation
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _firstLogoController.dispose();
    _secondLogoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD3E1EC), // Same background as home screen
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // First logo
            if (_showFirstLogo)
              AnimatedBuilder(
                animation: _firstLogoController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _firstOpacityAnimation.value,
                    child: Transform.scale(
                      scale: _firstScaleAnimation.value,
                      child: Image.asset(
                        'assets/images/home/logo.png',
                        width: 200,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
            // Second logo
            if (_showSecondLogo)
              AnimatedBuilder(
                animation: _secondLogoController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _secondOpacityAnimation.value,
                    child: Transform.scale(
                      scale: _secondScaleAnimation.value,
                      child: Image.asset(
                        'assets/images/home/logoueu.png',
                        width: 200,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
