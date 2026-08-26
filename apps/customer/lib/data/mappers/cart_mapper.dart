import '../../domain/entities/cart.dart';
import '../models/cart_item_model.dart';
import '../models/cart_model.dart';

class CartMapper {
  static Cart toEntity(
      CartModel model,
      ) {
    return Cart(
      id: model.id,
      items: model.items
          .map(CartItemMapper.toEntity)
          .toList(),
      totalPrice: model.totalPrice,
      itemCount: model.itemCount,
    );
  }

  static CartModel toModel(
      Cart entity,
      ) {
    return CartModel(
      id: entity.id,
      items: entity.items
          .map(CartItemMapper.toModel)
          .toList(),
      totalPrice: entity.totalPrice,
      itemCount: entity.itemCount,
    );
  }

  static List<Cart> toEntityList(
      List<CartModel> models,
      ) {
    return models
        .map(toEntity)
        .toList();
  }

  static List<CartModel> toModelList(
      List<Cart> entities,
      ) {
    return entities
        .map(toModel)
        .toList();
  }
}

class CartItemMapper {
  static CartItem toEntity(
      CartItemModel model,
      ) {
    return CartItem(
      id: model.id,
      productId: model.productId,
      productTitle: model.productTitle,
      productImage: model.productImage ?? '',
      unitPrice: model.unitPrice,
      quantity: model.quantity,
      totalPrice: model.totalPrice,
    );
  }

  static CartItemModel toModel(
      CartItem entity,
      ) {
    return CartItemModel(
      id: entity.id,
      productId: entity.productId,
      productTitle: entity.productTitle,
      productImage: entity.productImage,
      unitPrice: entity.unitPrice,
      quantity: entity.quantity,
      totalPrice: entity.totalPrice,
    );
  }
}