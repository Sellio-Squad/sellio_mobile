class OrderRequestModel {
  final List<OrderItemModel> items;
  final String? note;

  const OrderRequestModel({
    required this.items,
    this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((e) => e.toJson()).toList(),
      if (note != null && note!.isNotEmpty) 'note': note,
    };
  }
}

class OrderItemModel {
  final String productId;
  final int quantity;

  const OrderItemModel({
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}