import 'package:freezed_annotation/freezed_annotation.dart';
import 'review_model.dart';
import 'address_model.dart';
import 'category_model.dart';
import 'contact_info_model.dart';
part 'store_model.freezed.dart';
part 'store_model.g.dart';

@freezed
class StoreModel with _$StoreModel {
  const factory StoreModel({
    required String id,
    required String name,
    required String description,
    required String coverImage,
    required String profileImage,
    String? sale,
    double? rating,
    required AddressModel address,
    required List<ContactInfoModel> contactInfoList,
    required List<CategoryModel> categories,
    @Default([]) List<ReviewModel> reviews,
    @Default(true) bool isActive,
  }) = _StoreModel;

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson({
        ...json,
        'reviews': (json['reviews'] as List<dynamic>?)
            ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
            [],
      });
}
