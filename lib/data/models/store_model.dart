import '../../domain/entities/category.dart';
import '../../domain/entities/store.dart';
import 'address_model.dart';
import 'category_model.dart';

class StoreModel extends Store {
  const StoreModel({
    required super.id,
    required super.name,
    required super.description,
    required super.coverImage,
    required super.profileImage,
    super.sale,
    super.rating,
    required super.address,
    required super.contactInfo,
    required super.categories,
    super.reviews,
    super.isActive,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      coverImage: json['coverImage'] as String,
      profileImage: json['profileImage'] as String,
      sale: json['sale'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      contactInfo: ContactInfoModel.fromJson(
          json['contactInfo'] as Map<String, dynamic>),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviews: [],
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'coverImage': coverImage,
      'profileImage': profileImage,
      'sale': sale,
      'rating': rating,
      'address': (address as AddressModel).toJson(),
      'contactInfo': (contactInfo as ContactInfoModel).toJson(),
      'categories':
          categories.map((e) => (e as CategoryModel).toJson()).toList(),
      'isActive': isActive,
    };
  }

  Map<String, dynamic> toDbMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'coverImage': coverImage,
      'profileImage': profileImage,
      'sale': sale,
      'rating': rating,
      'country': address.country,
      'city': address.city,
      'isActive': isActive ? 1 : 0,
      'isFavorite': 0,
    };
  }

  factory StoreModel.fromDbMap(
    Map<String, dynamic> map,
    List<Category> categories,
    ContactInfo contactInfo,
  ) {
    return StoreModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      coverImage: map['coverImage'] as String,
      profileImage: map['profileImage'] as String,
      sale: map['sale'] as String?,
      rating: map['rating'] as double,
      address: AddressModel(
        id: map['id'] as String,
        country: map['country'] as String,
        city: map['city'] as String
      ),
      contactInfo: contactInfo,
      categories: categories,
      isActive: map['isActive'] == 1,
    );
  }

  factory StoreModel.fromEntity(Store store) {
    return StoreModel(
      id: store.id,
      name: store.name,
      description: store.description,
      coverImage: store.coverImage,
      profileImage: store.profileImage,
      sale: store.sale,
      rating: store.rating,
      address: store.address,
      contactInfo: store.contactInfo,
      categories: store.categories,
      reviews: store.reviews,
      isActive: store.isActive,
    );
  }

  Store toEntity() {
    return Store(
      id: id,
      name: name,
      description: description,
      coverImage: coverImage,
      profileImage: profileImage,
      sale: sale,
      rating: rating,
      address: address,
      contactInfo: contactInfo,
      categories: categories,
      reviews: reviews,
      isActive: isActive,
    );
  }
}

class ContactInfoModel extends ContactInfo {
  ContactInfoModel({
    required super.provider,
    required super.type,
  });

  factory ContactInfoModel.fromJson(Map<String, dynamic> json) {
    return ContactInfoModel(
      provider: json['provider'] as String,
      type: ContactType.values.firstWhere(
        (e) => e.toString() == 'ContactType.${json['type']}',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provider': provider,
      'type': type.toString().split('.').last,
    };
  }

  Map<String, dynamic> toDbMap(String storeId) {
    return {
      'storeId': storeId,
      'provider': provider,
      'type': type.toString().split('.').last,
    };
  }

  factory ContactInfoModel.fromDbMap(Map<String, dynamic> map) {
    return ContactInfoModel(
      provider: map['provider'] as String,
      type: ContactType.values.firstWhere(
        (e) => e.toString() == 'ContactType.${map['type']}',
      ),
    );
  }
}
