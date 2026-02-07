class ToyItem {
  final String id;
  final String name;
  final String imageAsset; // We'll use this (simulated) for now.
  final bool isTidied;

  ToyItem({
    required this.id,
    required this.name,
    required this.imageAsset,
    this.isTidied = false,
  });

  ToyItem copyWith({bool? isTidied}) {
    return ToyItem(
      id: id,
      name: name,
      imageAsset: imageAsset,
      isTidied: isTidied ?? this.isTidied,
    );
  }
}
