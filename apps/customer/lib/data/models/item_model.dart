import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/item.dart';

part 'item_model.freezed.dart';
part 'item_model.g.dart';

@freezed
class ItemModel with _$ItemModel {
  // Added a private constructor to allow defining custom methods (like toEntity)
  const ItemModel._();

  const factory ItemModel({
    required String id,
    required double price,
    required int stock,
    required String discountId,
    required String colorId,
    required String sizeId,
    required String weightId,
  }) = _ItemModel;

  // Handles JSON serialization
  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  // Mapper to Domain Entity
  Item toEntity() {
    return Item(
      id: id,
      price: price,
      stock: stock,
      discountId: discountId,
      colorId: colorId,
      sizeId: sizeId,
      weightId: weightId,
    );
  }

  // Mapper from Domain Entity
  factory ItemModel.fromEntity(Item item) {
    return ItemModel(
      id: item.id,
      price: item.price,
      stock: item.stock,
      discountId: item.discountId,
      colorId: item.colorId,
      sizeId: item.sizeId,
      weightId: item.weightId,
    );
  }
}