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
    @JsonKey(name: 'title') String? name,
    required String? description,
    @JsonKey(name: 'coverImageURL') String? coverImage,
    @JsonKey(name: 'avatarImageURL') String? profileImage,
    String? sale,
    @JsonKey(name: 'avgRating') double? rating,
    required String city,
    required String government,
    required String country,
    required List<ContactInfoModel>? contactInfoList,
    required List<CategoryModel>? categories,
    @Default([]) List<ReviewModel> ?reviews,
    @Default(true) bool? isActive,
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
