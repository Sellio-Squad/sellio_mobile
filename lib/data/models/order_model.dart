import '../../domain/entities/order.dart';
import 'address_model.dart';

class OrderModel extends Order {
  const OrderModel({
    required super.id,
    required super.userId,
    required super.storeId,
    required super.storeName,
    required super.storeImage,
    required super.items,
    required super.status,
    required super.deliveryAddress,
    super.note,
    required super.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      storeId: json['storeId'] as String,
      storeName: json['storeName'] as String,
      storeImage: json['storeImage'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: OrderStatus.values.firstWhere(
        (e) => e.toString() == 'OrderStatus.${json['status']}',
      ),
      deliveryAddress: AddressModel.fromJson(
          json['deliveryAddress'] as Map<String, dynamic>),
      note: json['note'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'storeId': storeId,
      'storeName': storeName,
      'storeImage': storeImage,
      'items': items.map((e) => (e as OrderItemModel).toJson()).toList(),
      'status': status.toString().split('.').last,
      'deliveryAddress': (deliveryAddress as AddressModel).toJson(),
      'note': note,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory OrderModel.fromEntity(Order order) {
    return OrderModel(
      id: order.id,
      userId: order.userId,
      storeId: order.storeId,
      storeName: order.storeName,
      storeImage: order.storeImage,
      items: order.items,
      status: order.status,
      deliveryAddress: order.deliveryAddress,
      note: order.note,
      createdAt: order.createdAt,
    );
  }

  Order toEntity() {
    return Order(
      id: id,
      userId: userId,
      storeId: storeId,
      storeName: storeName,
      storeImage: storeImage,
      items: items,
      status: status,
      deliveryAddress: deliveryAddress,
      note: note,
      createdAt: createdAt,
    );
  }
}

class OrderItemModel extends OrderItem {
  const OrderItemModel({
    required super.id,
    required super.productId,
    required super.productName,
    required super.productImage,
    required super.price,
    required super.quantity,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] as String,
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      productImage: json['productImage'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productImage': productImage,
      'price': price,
      'quantity': quantity,
    };
  }

  factory OrderItemModel.fromEntity(OrderItem item) {
    return OrderItemModel(
      id: item.id,
      productId: item.productId,
      productName: item.productName,
      productImage: item.productImage,
      price: item.price,
      quantity: item.quantity,
    );
  }

  OrderItem toEntity() {
    return OrderItem(
      id: id,
      productId: productId,
      productName: productName,
      productImage: productImage,
      price: price,
      quantity: quantity,
    );
  }
}
