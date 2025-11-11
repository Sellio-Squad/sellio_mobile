import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sellio_mobile/core/design_system/constants/app_strings.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/button.dart';
import 'package:sellio_mobile/core/design_system/widgets/cards/order_details.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';

import 'order_history_tabs.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  int selectedTabIndex = 0;

  List<OrderModel> get filteredOrders {
    switch (selectedTabIndex) {
      case 1:
        return mockOrders
            .where((order) => order.status == OrderStatus.processing)
            .toList();
      case 2:
        return mockOrders
            .where((order) => order.status == OrderStatus.completed)
            .toList();
      case 3:
        return mockOrders
            .where((order) => order.status == OrderStatus.cancelled)
            .toList();
      default:
        return mockOrders;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: SellioAppBar(
            showBackButton: true,
            title: AppStrings.orderHistory,
          ),
          body: CustomScrollView(
            slivers: [
              OrderHistoryTabs(
                onTabSelected: (index) {
                  setState(() {
                    selectedTabIndex = index;
                  });
                },
              ),
              OrderSection(orders: filteredOrders),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderSection extends StatelessWidget {
  final List<OrderModel> orders;

  const OrderSection({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return SliverToBoxAdapter(child: emptyOrderHistory(context));
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final order = orders[index];
        return Padding(
          padding: const EdgeInsets.all(16),
          child: OrderDetails(
            orderId: order.id,
            orderDate: order.date,
            status: order.status,
            orderTotal: order.totalItems,
            marketName: order.marketName,
            marketImage: order.marketImage,
            orderItems: order.orderItems,
            onCancelClick: () {},
            onViewDetailsClick: () {},
            onOrderAgainClick: () {},
          ),
        );
      }, childCount: orders.length),
    );
  }
}

Widget emptyOrderHistory(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.6,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(Assets.noOrderHistory, width: 112, height: 112),
        Text(
          'No order history!',
          style: context.theme.typography.textTheme.titleSmall.copyWith(
            color: context.theme.colors.title,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Start exploring and purchasing your favorite items',
            style: context.theme.typography.textTheme.bodySmall.copyWith(
              color: context.theme.colors.body,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Gap(12),
        SellioButton(text: 'Start Exploring', fullWidth: false, onTap: () {}),
      ],
    ),
  );
}

class OrderModel {
  final String id;
  final String date;
  final OrderStatus status;
  final int totalItems;
  final String marketName;
  final String marketImage;
  final List<OrderItem> orderItems;

  const OrderModel({
    required this.id,
    required this.date,
    required this.status,
    required this.totalItems,
    required this.marketName,
    required this.marketImage,
    required this.orderItems,
  });
}

final List<OrderItem> mockOrderItems = [
  OrderItem(
    productId: 'P001',
    productName: 'Wireless Mouse',
    quantity: 2,
    price: 25.99,
  ),
  OrderItem(
    productId: 'P002',
    productName: 'Mechanical Keyboard',
    quantity: 1,
    price: 89.50,
  ),
  OrderItem(
    productId: 'P003',
    productName: 'USB-C Hub',
    quantity: 3,
    price: 34.75,
  ),
  OrderItem(
    productId: 'P004',
    productName: '27" Monitor',
    quantity: 1,
    price: 229.99,
  ),
  OrderItem(
    productId: 'P005',
    productName: 'Laptop Stand',
    quantity: 2,
    price: 45.00,
  ),
];

final List<OrderModel> mockOrders = [
  OrderModel(
    id: '2002124',
    date: '12 Jun 2025',
    status: OrderStatus.processing,
    totalItems: 4,
    marketName: 'Sweet Lovers - Pasteleria',
    marketImage: Assets.password,
    orderItems: mockOrderItems,
  ),
  OrderModel(
    id: '2002125',
    date: '10 Jun 2025',
    status: OrderStatus.completed,
    totalItems: 3,
    marketName: 'Coffee Beans House',
    marketImage: Assets.password,
    orderItems: mockOrderItems,
  ),
  OrderModel(
    id: '2002126',
    date: '8 Jun 2025',
    status: OrderStatus.cancelled,
    totalItems: 2,
    marketName: 'Tech World Store',
    marketImage: Assets.password,
    orderItems: mockOrderItems,
  ),
];