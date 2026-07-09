import 'package:authentication/domain/entities/address.dart';

import 'category.dart';

class StoreSeller {
  final String id;
  final String name;
  final String description;
  final String coverImage;
  final String profileImage;
  final double rating;
  final Address address;
  final List<ContactInfo> contactInfoList;
  final List<Category> categories;
  final bool isActive;

  const StoreSeller({
    required this.id,
    required this.name,
    required this.description,
    required this.coverImage,
    required this.profileImage,
    this.rating = 0.0,
    required this.address,
    required this.contactInfoList,
    required this.categories,
    this.isActive = true,
  });


  StoreSeller copyWith({
    String? id,
    String? name,
    String? description,
    String? coverImage,
    String? profileImage,
    double? rating,
    Address? address,
    List<ContactInfo>? contactInfoList,
    List<Category>? categories,
    bool? isActive,
  }) {
    return StoreSeller(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      coverImage: coverImage ?? this.coverImage,
      profileImage: profileImage ?? this.profileImage,
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
