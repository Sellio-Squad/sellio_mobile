import 'address.dart';

enum OrderStatus { pending, processing, completed, cancelled }

class Order {

  final String id;
  final String userId;
  final String storeId;
  final String storeName;
  final String storeImage;
  final List<OrderItem> items;
  final OrderStatus status;
  final Address deliveryAddress;
  final String? note;
  final DateTime createdAt;


  const Order({
    required this.id,
    required this.userId,
    required this.storeId,
    required this.storeName,
    required this.storeImage,
    required this.items,
    required this.status,
    required this.deliveryAddress,
    this.note,
    required this.createdAt,

  });

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  bool get canBeCancelled =>
      status == OrderStatus.pending || status == OrderStatus.processing;

  Order copyWith({
    String? id,
    String? userId,
    String? storeId,
    String? storeName,
    String? storeImage,
    List<OrderItem>? items,
    double? total,
    OrderStatus? status,
    Address? deliveryAddress,
    String? note,
    DateTime? createdAt,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      storeId: storeId ?? this.storeId,
      storeName: storeName ?? this.storeName,
      storeImage: storeImage ?? this.storeImage,
      items: items ?? this.items,
      status: status ?? this.status,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class OrderItem {
  final String id;
  final String productId;
  final String productName;
  final String productImage;
  final double price;
  final int quantity;

  const OrderItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
  });

  double get totalPrice => price * quantity;

  OrderItem copyWith({
    String? id,
    String? productId,
    String? productName,
    String? productImage,
    double? price,
    int? quantity,
  }) {
    return OrderItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}