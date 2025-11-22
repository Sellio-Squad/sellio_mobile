import '../../domain/entities/order.dart';
import '../models/order_model.dart';
import 'address_mapper.dart';

extension OrderModelMapper on OrderModel {
  Order toEntity() => Order(
    id: id,
    userId: userId,
    storeId: storeId,
    storeName: storeName,
    storeImage: storeImage,
    items: items.map((e) => e.toEntity()).toList(),
    status: status,
    deliveryAddress: deliveryAddress.toEntity(),
    note: note,
    createdAt: createdAt,
  );
}

extension OrderItemModelMapper on OrderItemModel {
  OrderItem toEntity() => OrderItem(
    id: id,
    productId: productId,
    productName: productName,
    productImage: productImage,
    price: price,
    quantity: quantity,
  );
}

