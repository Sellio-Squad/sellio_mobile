
class SpecialOffer {
  final String id;
  final String title;
  final String? description;
  final String imageUrl;
  final String discount;
  final String? storeId;
  final String? categoryId;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final DateTime createdAt;

  const SpecialOffer({
    required this.id,
    required this.title,
    this.description,
    required this.imageUrl,
    required this.discount,
    this.storeId,
    this.categoryId,
    required this.startDate,
    required this.endDate,
    this.isActive = true,
    required this.createdAt,
  });

  bool get isValid {
    final now = DateTime.now();
    return isActive && now.isAfter(startDate) && now.isBefore(endDate);
  }

  SpecialOffer copyWith({
  String? id,
  String? title,
  String? description,
  String? imageUrl,
  String? discount,
  String? storeId,
  String? categoryId,
  DateTime? startDate,
  DateTime? endDate,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return SpecialOffer(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      discount: discount ?? this.discount,
      storeId: storeId ?? this.storeId,
      categoryId: categoryId ?? this.categoryId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}