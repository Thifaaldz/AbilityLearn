import 'package:equatable/equatable.dart';

enum TrashType { organic, inorganic }

class TrashItem extends Equatable {
  final String id;
  final String name;
  final String imageAsset;
  final TrashType type;
  final bool isDropped;

  const TrashItem({
    required this.id,
    required this.name,
    required this.imageAsset,
    required this.type,
    this.isDropped = false,
  });

  TrashItem copyWith({
    String? id,
    String? name,
    String? imageAsset,
    TrashType? type,
    bool? isDropped,
  }) {
    return TrashItem(
      id: id ?? this.id,
      name: name ?? this.name,
      imageAsset: imageAsset ?? this.imageAsset,
      type: type ?? this.type,
      isDropped: isDropped ?? this.isDropped,
    );
  }

  @override
  List<Object?> get props => [id, name, imageAsset, type, isDropped];
}
