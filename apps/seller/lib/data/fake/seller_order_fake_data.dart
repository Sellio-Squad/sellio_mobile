import 'dart:math';

import '../../domain/entities/seller_order.dart';

class SellerOrderFakeData {
  SellerOrderFakeData._();

  static final _random = Random(42);

  static const _customerNames = [
    'Ahmed Hassan',
    'Sara Ali',
    'Omar Khalil',
    'Layla Mahmoud',
    'Youssef Ibrahim',
    'Nour Farouk',
    'Hana Saleh',
    'Karim Nasser',
  ];

  static const _productNames = [
    'Chocolate Cake',
    'Vanilla Cupcake',
    'Red Velvet Slice',
    'Strawberry Tart',
    'Croissant Box',
    'Blueberry Muffin',
    'Cheesecake Jar',
    'Brownie Bites',
  ];

  static List<SellerOrder> generateOrders({
    int count = 12,
    SellerOrderStatus? status,
  }) {
    return List.generate(
      count,
      (index) => generateOrder(index: index, status: status),
    );
  }

  static SellerOrder generateOrder({
    int index = 0,
    SellerOrderStatus? status,
  }) {
    final items = List.generate(
      1 + _random.nextInt(3),
      (itemIndex) => generateOrderItem(index: itemIndex),
    );

    return SellerOrder(
      orderId: '${1000 + index}',
      orderDate: DateTime.now().subtract(Duration(hours: index * 5)),
      status: status ??
          SellerOrderStatus.values[
              _random.nextInt(SellerOrderStatus.values.length)],
      totalPrice: _calculateTotal(items),
      customerName: _customerNames[index % _customerNames.length],
      items: items,
    );
  }

  static SellerOrderItem generateOrderItem({int index = 0}) {
    final price = 5 + _random.nextDouble() * 45;

    return SellerOrderItem(
      id: 'item_$index',
      productName: _productNames[index % _productNames.length],
      quantity: 1 + _random.nextInt(3),
      price: double.parse(price.toStringAsFixed(2)),
    );
  }

  static double _calculateTotal(List<SellerOrderItem> items) {
    return items.fold<double>(
      0,
      (total, item) => total + (item.price * item.quantity),
    );
  }
}
