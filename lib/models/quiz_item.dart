/// Model for a quiz question in the self-care game
class QuizItem {
  final String id;
  final String instruction;
  final String category;
  final List<String> correctItems;
  final List<String> allItems;
  final String imagePath; // Path to main question image

  const QuizItem({
    required this.id,
    required this.instruction,
    required this.category,
    required this.correctItems,
    required this.allItems,
    required this.imagePath,
  });
}

/// Model for a selectable item
class SelectableItem {
  final String id;
  final String name;
  final String imagePath; // Path to item image

  const SelectableItem({
    required this.id,
    required this.name,
    required this.imagePath,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectableItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
