import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class FeedbackModal extends StatelessWidget {
  final bool isCorrect;
  final String instruction;
  final String category;
  final VoidCallback onContinue;

  const FeedbackModal({
    super.key,
    required this.isCorrect,
    required this.instruction,
    required this.category,
    required this.onContinue,
  });

  String _getCorrectMessage() {
    switch (category.toLowerCase()) {
      case 'sikat gigi':
        return 'Ayo sikat gigi agar gigi menjadi lebih sehat!';
      case 'mandi':
        return 'Mandi membuat badan bersih dan segar!';
      case 'cuci tangan':
        return 'Ayo cuci tangan pakai sabun agar kuman hilang!';
      case 'makan':
        return 'Makan yang sehat agar tubuh kuat!';
      case 'tidur':
        return 'Tidur yang cukup agar tubuh sehat!';
      case 'berpakaian':
        return 'Berpakaian rapi membuat kita terlihat bagus!';
      default:
        return 'Bagus sekali! Kamu hebat!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.3),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(32),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isCorrect ? AppTheme.correctGreen : AppTheme.wrongPink,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                isCorrect ? 'Jawaban Benar,' : 'Belum tepat,',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              // Message
              Text(
                isCorrect ? _getCorrectMessage() : 'coba lagi yaa',
                style: const TextStyle(fontSize: 16, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: isCorrect
                        ? AppTheme.correctGreen
                        : AppTheme.wrongRed,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isCorrect) const Icon(Icons.check, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        isCorrect ? 'Lanjutkan' : 'Yuk, coba lagi',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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
