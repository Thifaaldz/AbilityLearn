class SelectableItem {
  final String id;
  final String name;
  final String imagePath;

  const SelectableItem({
    required this.id,
    required this.name,
    required this.imagePath,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectableItem && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
