import 'package:sellio_mobile/data/mappers/review_mapper.dart';
import 'package:sellio_mobile/data/models/store_top_rating_model.dart';
import 'package:sellio_mobile/domain/entities/address.dart';

import '../../domain/entities/store.dart';
import '../models/store_model.dart';
import 'address_mapper.dart';
import 'category_mapper.dart';
import 'contact_info_mapper.dart';

extension StoreModelMapper on StoreModel {
  Store toEntity() => Store(
    id: id,
    name: name,
    description: description,
    coverImage: coverImage,
    profileImage: profileImage,
    sale: sale,
    rating: rating ?? 0.0,
    address: address.toEntity(),
    contactInfoList: contactInfoList.map((e) => e.toEntity()).toList(),
    categories: categories.map((e) => e.toEntity()).toList(),
    reviews: reviews.map((e) => e.toEntity()).toList(),
    isActive: isActive,
  );
}

extension StoreItemMapper on StoreTopRatingModel {
  Store toEntity() => Store(
        id: id,
        name: title,
        description: '',
        coverImage: coverImageURL ?? "",
        profileImage: "",
        sale: maxDiscount?.toString(),
        rating: 0.0,
        address: Address(country: "", city: ""),
        contactInfoList: [],
        categories: [],
        reviews: [],
        isActive: true,
      );
}
