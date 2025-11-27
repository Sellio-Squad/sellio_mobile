import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_top_rating_model.freezed.dart';
part 'store_top_rating_model.g.dart';

@freezed
class StoreTopRatingModel with _$StoreTopRatingModel {
  const factory StoreTopRatingModel({
    required String id,
    required String title,
    String? coverImageURL,
    double? maxDiscount,
    @Default(false) bool isFavorite,
  }) = _StoreTopRatingModel;

  factory StoreTopRatingModel.fromJson(Map<String, dynamic> json) =>
      _$StoreTopRatingModelFromJson(json);
}
