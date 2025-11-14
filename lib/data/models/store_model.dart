import '../../domain/entities/store.dart';
import 'address_model.dart';
import 'category_model.dart';
import 'contact_info_model.dart';

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
    required super.contactInfoList,
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
      contactInfoList: (json['contactInfoList'] as List<dynamic>?)
              ?.map((e) => ContactInfoModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
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
      'contactInfoList':
          contactInfoList.map((e) => (e as ContactInfoModel).toJson()).toList(),
      'categories':
          categories.map((e) => (e as CategoryModel).toJson()).toList(),
      'isActive': isActive,
    };
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
      contactInfoList: store.contactInfoList,
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
      contactInfoList: contactInfoList,
      // Changed
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
        orElse: () => ContactType.email,
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
        orElse: () => ContactType.email,
      ),
    );
  }

  factory ContactInfoModel.fromEntity(ContactInfo contactInfo) {
    return ContactInfoModel(
      provider: contactInfo.provider,
      type: contactInfo.type,
    );
  }

  ContactInfo toEntity() {
    return ContactInfo(
      provider: provider,
      type: type,
    );
  }
}
