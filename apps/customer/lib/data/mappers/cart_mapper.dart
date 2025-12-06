import '../../domain/entities/cart.dart';
import '../models/cart_model.dart';

class CartMapper {
  static Cart toEntity(CartModel model) {
    return model.toEntity();
  }

  static CartModel toModel(Cart entity) {
    return CartModel.fromEntity(entity);
  }

  static List<Cart> toEntityList(List<CartModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  static List<CartModel> toModelList(List<Cart> entities) {
    return entities.map((entity) => CartModel.fromEntity(entity)).toList();
  }
}
