import 'package:flutter/material.dart';
import '../../data/models/trash_item.dart';

class TrashDraggable extends StatelessWidget {
  final TrashItem item;
  final VoidCallback? onDragCanceled;
  final VoidCallback? onDragStarted;
  final VoidCallback? onDragCompleted;

  const TrashDraggable({
    super.key, 
    required this.item, 
    this.onDragCanceled,
    this.onDragStarted,
    this.onDragCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<TrashItem>(
      data: item,
      onDraggableCanceled: (_, __) => onDragCanceled?.call(),
      onDragStarted: onDragStarted,
      onDragCompleted: onDragCompleted,
      feedback: Transform.scale(
        scale: 1.2,
        child: _buildContent(context, isDragging: true),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: _buildContent(context),
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context, {bool isDragging = false}) {
    // Using Container with Icon as placeholder. 
    // In production, use Image.asset(item.imageAsset)
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: isDragging
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ]
            : [],
      ),
      child: Center(
      child: Image.asset(item.imageAsset, fit: BoxFit.contain),
      ),
    );
  }
}
