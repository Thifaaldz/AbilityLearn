import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class TrashCan extends StatelessWidget {
  final void Function(String) onDrop;

  const TrashCan({
    super.key,
    required this.onDrop,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 250,
      child: DragTarget<String>(
        builder: (context, candidateData, rejectedData) {
          final bool isHovering = candidateData.isNotEmpty;
          return Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: isHovering ? AppColors.pastelGreen.withOpacity(0.7) : Colors.brown[200],
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                  width: 4,
                  color: isHovering ? Colors.green.shade800 : Colors.brown.shade600,
                  style: BorderStyle.solid),
            ),
            child: Center(
              child: Icon(
                Icons.delete_sweep_rounded,
                size: 100,
                color: isHovering ? Colors.white : Colors.black.withOpacity(0.6),
              ),
            ),
          );
        },
        onWillAccept: (data) => true,
        onAccept: onDrop,
      ),
    );
  }
}
