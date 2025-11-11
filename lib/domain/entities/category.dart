// category.dart
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

  factory Category.dummy({int index = 0}) {
    return Category(
      id: 'category_$index',
      name: 'Category ${index + 1}',
    );
  }

  static List<Category> dummyList({int count = 4}) {
    return List.generate(count, (i) => Category.dummy(index: i));
  }
}
