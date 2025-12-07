import '../../domain/entities/special_offer.dart';

class SpecialOfferModel extends SpecialOffer {
  const SpecialOfferModel({
    required super.id,
    required super.title,
    super.description,
    required super.imageUrl,
    required super.discount,
    super.storeId,
    super.categoryId,
    required super.startDate,
    required super.endDate,
    super.isActive,
    required super.createdAt,
  });

  factory SpecialOfferModel.fromJson(Map<String, dynamic> json) {
    return SpecialOfferModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String,
      discount: json['discount'] as String,
      storeId: json['storeId'] as String?,
      categoryId: json['categoryId'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'discount': discount,
      'storeId': storeId,
      'categoryId': categoryId,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory SpecialOfferModel.fromEntity(SpecialOffer offer) {
    return SpecialOfferModel(
      id: offer.id,
      title: offer.title,
      description: offer.description,
      imageUrl: offer.imageUrl,
      discount: offer.discount,
      storeId: offer.storeId,
      categoryId: offer.categoryId,
      startDate: offer.startDate,
      endDate: offer.endDate,
      isActive: offer.isActive,
      createdAt: offer.createdAt,
    );
  }

  SpecialOffer toEntity() {
    return SpecialOffer(
      id: id,
      title: title,
      description: description,
      imageUrl: imageUrl,
      discount: discount,
      storeId: storeId,
      categoryId: categoryId,
      startDate: startDate,
      endDate: endDate,
      isActive: isActive,
      createdAt: createdAt,
    );
  }
}
