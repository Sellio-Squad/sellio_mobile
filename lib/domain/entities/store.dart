import 'package:sellio_mobile/domain/entities/review.dart';

import 'address.dart';
import 'category.dart';

class Store {
  final String id;
  final String name;
  final String description;
  final String coverImage;
  final String profileImage;
  final String? sale;
  final double rating;
  final List<Review> reviews;
  final Address address;
  final List<ContactInfo> contactInfoList;
  final List<Category> categories;
  final bool isActive;

  const Store({
    required this.id,
    required this.name,
    required this.description,
    required this.coverImage,
    required this.profileImage,
    this.sale,
    this.rating = 0.0,
    required this.address,
    required this.contactInfoList,
    required this.categories,
    this.reviews = const [],
    this.isActive = true,
  });

  bool get hasSale => sale != null && sale!.isNotEmpty;

  Store copyWith({
    String? id,
    String? name,
    String? description,
    String? coverImage,
    String? profileImage,
    String? sale,
    double? rating,
    Address? address,
    List<ContactInfo>? contactInfoList,
    List<Category>? categories,
    bool? isActive,
  }) {
    return Store(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      coverImage: coverImage ?? this.coverImage,
      profileImage: profileImage ?? this.profileImage,
      sale: sale ?? this.sale,
      rating: rating ?? this.rating,
      address: address ?? this.address,
      categories: categories ?? this.categories,
      contactInfoList: contactInfoList ?? this.contactInfoList,
      isActive: isActive ?? this.isActive,
    );
  }
}

enum ContactType { email, phone, facebook, whatsapp, website }

class ContactInfo {
  final String provider;
  final ContactType type;

  ContactInfo({
    required this.provider,
    required this.type,
  });

  ContactInfo copyWith({
    String? provider,
    ContactType? type,
  }) {
    return ContactInfo(
      provider: provider ?? this.provider,
      type: type ?? this.type,
    );
  }
}
