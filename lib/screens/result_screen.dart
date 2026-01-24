import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class ResultScreen extends StatefulWidget {
  final int stars;
  final int totalQuestions;

  const ResultScreen({
    super.key,
    required this.stars,
    required this.totalQuestions,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getMessage() {
    final percentage = widget.stars / widget.totalQuestions;
    if (percentage >= 0.8) {
      return 'Luar Biasa!';
    } else if (percentage >= 0.6) {
      return 'Bagus Sekali!';
    } else if (percentage >= 0.4) {
      return 'Hebat!';
    } else {
      return 'Terus Belajar!';
    }
  }

  String _getEmoji() {
    final percentage = widget.stars / widget.totalQuestions;
    if (percentage >= 0.8) {
      return '🏆';
    } else if (percentage >= 0.6) {
      return '🎉';
    } else if (percentage >= 0.4) {
      return '⭐';
    } else {
      return '💪';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundGray,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryOrange,
        automaticallyImplyLeading: false,
        title: const Text(
          'Hasil Permainan',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Trophy/celebration
              ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: AppTheme.yellowCircle,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.yellowCircle.withValues(alpha: 0.4),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      _getEmoji(),
                      style: const TextStyle(fontSize: 72),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Message
              Text(
                _getMessage(),
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryOrange,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'Kamu sudah belajar merawat diri!',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // Star count card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Bintang Terkumpul',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('⭐', style: TextStyle(fontSize: 36)),
                        const SizedBox(width: 8),
                        Text(
                          '${widget.stars}',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryOrange,
                          ),
                        ),
                        Text(
                          ' / ${widget.totalQuestions}',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Stars row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(widget.totalQuestions, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Icon(
                            index < widget.stars
                                ? Icons.star
                                : Icons.star_border,
                            color: AppTheme.yellowCircle,
                            size: 28,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Play again button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryOrange,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.refresh, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Main Lagi',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Home button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: AppTheme.primaryOrange, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Kembali ke Beranda',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryOrange,
                    ),
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
