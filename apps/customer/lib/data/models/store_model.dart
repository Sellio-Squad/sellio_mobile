import 'package:freezed_annotation/freezed_annotation.dart';
import 'review_model.dart';
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
    String? city,
    String? government,
    String? country,
    List<ContactInfoModel>? contactInfoList,
    List<CategoryModel>? categories,
    @Default([]) List<ReviewModel> reviews,
    @Default(true) bool isActive,
    @Default(false) bool isFavorite,
    @JsonKey(name: 'subCategories') @Default([]) List<CategoryModel> subCategories,
  }) = _StoreModel;

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);
}