class Category {
  final String id;
  final String name;

  const Category({
    required this.id,
    required this.name,
  });

  Category copyWith({
    String? id,
    String? name,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
