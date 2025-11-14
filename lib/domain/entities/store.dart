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
  final ContactInfo contactInfo;
  final List<Category> categories;
  final bool isActive;
  final bool isFavorite;


  const Store({
    required this.id,
    required this.name,
    required this.description,
    required this.coverImage,
    required this.profileImage,
    this.sale,
    this.rating = 0.0,
    required this.address,
    required this.contactInfo,
    required this.categories,
    this.reviews = const [],
    this.isActive = true,
    this.isFavorite = false,
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
    ContactInfo? contactInfo,
    List<Category>? categories,
    bool? isActive,
    bool? isFavorite,
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
      contactInfo: contactInfo ?? this.contactInfo,
      isActive: isActive ?? this.isActive,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory Store.dummy({int index = 0}) {
    return Store(
      id: 'store_$index',
      name: 'Store #$index',
      description:
      'This is a brief description of Store #$index, offering great products and services.',
      coverImage:
      'https://picsum.photos/seed/store_cover_$index/800/400', // random placeholder
      profileImage:
      'https://picsum.photos/seed/store_profile_$index/200/200', // random placeholder
      sale: index.isEven ? '20%' : null,
      rating: (3 + (index % 3) * 0.5),
      address: Address.dummy(index: index),
      contactInfo: ContactInfo(
        provider: 'contact$index@example.com',
        type: ContactType.email,
      ),
      categories: Category.dummyList(count: 3),
      reviews: Review.dummyList(count: 3),
    );
  }

  static List<Store> dummyList({int count = 5}) {
    return List.generate(count, (i) => Store.dummy(index: i));
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
