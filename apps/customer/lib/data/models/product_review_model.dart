import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_review_model.freezed.dart';
part 'product_review_model.g.dart';

@freezed
abstract class ProductReviewModel with _$ProductReviewModel {
  const factory ProductReviewModel({
    required String id,
    @JsonKey(name: 'productId') required String productId,
    @JsonKey(name: 'userId') String? userId,
    @JsonKey(name: 'userName') String? userName,
    @JsonKey(name: 'userImage') String? userImage,
    @JsonKey(name: 'rating') double? rating,
    @JsonKey(name: 'comment') String? comment,
    @JsonKey(name: 'createdAt') DateTime? createdAt,
  }) = _ProductReviewModel;

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewModelFromJson(json);
}