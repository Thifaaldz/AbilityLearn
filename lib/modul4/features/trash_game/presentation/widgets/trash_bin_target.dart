import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/trash_item.dart';
import '../providers/trash_game_provider.dart';

class TrashBinTarget extends StatelessWidget {
  const TrashBinTarget({super.key});

  @override
  Widget build(BuildContext context) {
    return DragTarget<TrashItem>(
      builder: (context, candidateData, rejectedData) {
        final isHovered = candidateData.isNotEmpty;
        return AnimatedScale(
          scale: isHovered ? 1.1 : 1.0,
          duration: const Duration(milliseconds: 300),
          child: SizedBox(
            width: 180,
            height: 200,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), // Circular glow
                boxShadow: isHovered
                    ? [
                        BoxShadow(
                          color: Colors.greenAccent.withOpacity(0.8),
                          blurRadius: 30,
                          spreadRadius: 10,
                        )
                      ]
                    : [],
              ),
              child: Image.asset(
                'assets/images/modul4/trash_bin_new.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
      onWillAccept: (data) => true, // Accept all trash for now
      onAccept: (data) {
        context.read<TrashGameProvider>().handleDrop(data);
      },
    );
  }
}