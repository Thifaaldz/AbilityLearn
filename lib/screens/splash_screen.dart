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
  late AnimationController _loadingController;
  late Animation<double> _firstScaleAnimation;
  late Animation<double> _firstOpacityAnimation;
  late Animation<double> _secondScaleAnimation;
  late Animation<double> _secondOpacityAnimation;
  late Animation<double> _loadingRotationAnimation;

  bool _showFirstLogo = false;
  bool _showSecondLogo = false;
  bool _showLoading = true;

  @override
  void initState() {
    super.initState();

    // Loading animation controller
    _loadingController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Loading rotation animation
    _loadingRotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_loadingController);

    // Start loading animation
    _loadingController.repeat();

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

    // Sequence the animations: loading first, then first logo, then second logo
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showLoading = false;
          _showFirstLogo = true;
        });
        // Start first logo animation
        _firstLogoController.forward();
      }
    });

    // Transition to second logo after 5 seconds of first logo
    Timer(const Duration(seconds: 7), () {
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

    // Navigate to home screen after 5 seconds of second logo
    Timer(const Duration(seconds: 12), () {
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
    _loadingController.dispose();
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
            // Loading indicator
            if (_showLoading)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _loadingController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _loadingRotationAnimation.value * 2 * 3.14159,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFFF8A65),
                              width: 4,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFFFF8A65),
                              ),
                              strokeWidth: 3,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Sedang mengoptimalkan sistem...',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFFF8A65),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

            // First logo (logo ueu)
            if (_showFirstLogo)
              AnimatedBuilder(
                animation: _firstLogoController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _firstOpacityAnimation.value,
                    child: Transform.scale(
                      scale: _firstScaleAnimation.value,
                      child: Image.asset(
                        'assets/images/home/logoueu.png',
                        width: 300,
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),

            // Second logo (main logo)
            if (_showSecondLogo)
              AnimatedBuilder(
                animation: _secondLogoController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _secondOpacityAnimation.value,
                    child: Transform.scale(
                      scale: _secondScaleAnimation.value,
                      child: Image.asset(
                        'assets/images/home/logo.png',
                        width: 300,
                        height: 300,
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
