class Order {
  final String orderId;
  final DateTime orderDate;
  final OrderStatus status;
  final double totalPrice;
  final String storeName;
  final String? storeLogoUrl;
  final List<OrderItem> items;

  const Order({
    required this.orderId,
    required this.orderDate,
    required this.status,
    required this.totalPrice,
    required this.storeName,
    required this.storeLogoUrl,
    required this.items,
  });
}

class OrderItem {
  final String id;
  final String productId;
  final String productName;
  final String? productImageUrl;
  final int quantity;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;

  const OrderItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImageUrl,
    required this.quantity,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });
}

enum OrderStatus {
  processing,
  completed,
  cancelled,
}