import '../../domain/entities/cart.dart';
import '../models/cart_item_model.dart';

class CartItemMapper {
  static CartItem toEntity(CartItemModel model) {
    return model.toEntity();
  }

  static CartItemModel toModel(CartItem entity) {
    return CartItemModel.fromEntity(entity);
  }

  static List<CartItem> toEntityList(List<CartItemModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  static List<CartItemModel> toModelList(List<CartItem> entities) {
    return entities.map((entity) => CartItemModel.fromEntity(entity)).toList();
  }
}
