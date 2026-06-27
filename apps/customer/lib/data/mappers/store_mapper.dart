import 'package:authentication/domain/entities/address.dart';
import 'package:sellio_mobile/data/mappers/review_mapper.dart';
import 'package:sellio_mobile/data/models/store_top_rating_model.dart';

import '../../domain/entities/store.dart';
import '../models/store_model.dart';
import 'category_mapper.dart';
import 'contact_info_mapper.dart';

extension StoreModelMapper on StoreModel {
  Store toEntity() => Store(
        id: id,
        name: name ?? '',
        description: description ?? '',
        coverImage: coverImage ?? '',
        profileImage: profileImage ?? '',
        sale: sale,
        rating: rating ?? 0.0,
        address: Address(
          country: country ?? '',
          city: city ?? '',
        ),
        contactInfoList:
            contactInfoList?.map((e) => e.toEntity()).toList() ?? [],
        categories: subCategories.map((e) => e.toEntity()).toList(),
        reviews: reviews.map((e) => e.toEntity()).toList() ?? [],
        isActive: isActive ?? false,
        isFavorite: isFavorite ?? false,
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
        isFavorite: isFavorite,
      );
}
