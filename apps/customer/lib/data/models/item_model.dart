import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/item.dart';

part 'item_model.freezed.dart';
part 'item_model.g.dart';

@freezed
class ItemModel with _$ItemModel {
  const ItemModel._();

  const factory ItemModel({
    required String id,
    required double price,
    required int stock,
    String? discountId,
    String? colorId,
    String? sizeId,
    String? weightId,
  }) = _ItemModel;

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Item toEntity() {
    return Item(
      id: id,
      price: price,
      stock: stock,
      discountId: discountId ?? '',
      colorId: colorId ?? '',
      sizeId: sizeId ?? '',
      weightId: weightId ?? '',
    );
  }

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
