import 'package:flutter/material.dart';
import '../models/quiz_item.dart';
import '../theme/app_theme.dart';

class ItemCard extends StatelessWidget {
  final SelectableItem item;
  final bool isSelected;
  final bool isCorrect;
  final bool showResult;
  final VoidCallback onTap;

  const ItemCard({
    super.key,
    required this.item,
    required this.isSelected,
    required this.isCorrect,
    required this.showResult,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.transparent;
    Color backgroundColor = AppTheme.cardWhite;

    if (showResult) {
      if (isCorrect && isSelected) {
        borderColor = AppTheme.correctGreen;
        backgroundColor = AppTheme.correctGreen.withValues(alpha: 0.1);
      } else if (!isCorrect && isSelected) {
        borderColor = AppTheme.wrongRed;
        backgroundColor = AppTheme.wrongPink.withValues(alpha: 0.3);
      } else if (isCorrect) {
        borderColor = AppTheme.correctGreen;
      }
    } else if (isSelected) {
      borderColor = AppTheme.primaryOrange;
      backgroundColor = AppTheme.primaryOrange.withValues(alpha: 0.1);
    }

    return GestureDetector(
      onTap: showResult ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected || (showResult && isCorrect)
                ? borderColor
                : Colors.grey.withValues(alpha: 0.2),
            width: isSelected || (showResult && isCorrect) ? 3 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Item image container
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  item.imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback if image not found - show placeholder
                    return Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 36,
                        color: Colors.grey[400],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Item name
            Text(
              item.name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
