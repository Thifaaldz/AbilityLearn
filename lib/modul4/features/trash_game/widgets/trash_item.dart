import 'package:flutter/material.dart';

class TrashItem extends StatelessWidget {
  final String name;
  final double size;

  const TrashItem({super.key, required this.name, this.size = 60});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: size,
        height: size,
        child: Center(
          child: _getTrashIcon(name, size),
        ),
      ),
    );
  }

  Widget _getTrashIcon(String name, double iconSize) {
    switch (name) {
      case 'sisa-apel':
        return Icon(Icons.apple_sharp, color: Colors.red.shade700, size: iconSize);
      case 'botol-plastik':
        return Icon(Icons.water_drop_sharp, color: Colors.blue.shade700, size: iconSize);
      case 'kardus':
        return Icon(Icons.inventory_2_sharp, color: Colors.brown.shade700, size: iconSize);
      default:
        return Icon(Icons.circle, color: Colors.grey, size: iconSize);
    }
  }
}
