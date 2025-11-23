import 'package:sellio_mobile/data/mappers/review_mapper.dart';

import 'address_mapper.dart';
import 'category_mapper.dart';
import 'contact_info_mapper.dart';
import '../models/store_model.dart';
import '../../domain/entities/store.dart';

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
