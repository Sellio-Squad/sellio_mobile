import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sellio_mobile/core/design_system/constants/app_strings.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/button.dart';
import 'package:sellio_mobile/core/design_system/widgets/cards/order_details.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
import 'package:sellio_mobile/ui/screens/order_history/order_history_tabs.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: SellioAppBar(
            showBack: true,
            title: AppStrings.orderHistory,
            showActionIcon: false,
          ),
          body: CustomScrollView(slivers: [OrderHistoryTabs(), OrderSection()]),
        ),
      ),
    );
  }
}

class OrderSection extends StatefulWidget {
  const OrderSection({super.key});

  @override
  State<OrderSection> createState() => _OrderSectionState();
}

class _OrderSectionState extends State<OrderSection> {
  bool isOrderVisible = true;
  bool isViewDetailsVisible = false;

  void _handleCancelClick() {
    setState(() {
      isOrderVisible = false;
    });
  }

  void _handleViewDetailsClick() {
    setState(() {
      isViewDetailsVisible = true;
    });
  }

  void _handleOrderAgainClick() {
    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => StoreScreen(),),);
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: isOrderVisible && mockOrderItems.isNotEmpty
          ? OrderDetails(
              orderId: 'Order #2002124',
              orderDate: 'Placed on 12 Jun 2025',
              status: OrderStatus.processing,
              orderTotal: 4,
              marketName: 'Sweet Lovers - Pasteleria',
              marketImage: Assets.password,
              orderItems: mockOrderItems,
              onCancelClick: _handleCancelClick,
              onViewDetailsClick: _handleViewDetailsClick,
              onOrderAgainClick: _handleOrderAgainClick,
            )
          : emptyOrderHistory(context),
    );
  }
}

Widget? emptyOrderHistory(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.6,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(Assets.noOrderHistory, width: 112, height: 112),
        Text(
          'No order history!',
          style: context.theme.typography.textTheme.titleSmall.copyWith(
            color: context.theme.colors.title,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 24, left: 24),
          child: Text(
            'Start exploring and purchasing your favorite items',
            style: context.theme.typography.textTheme.bodySmall.copyWith(
              color: context.theme.colors.body,
            ),
          ),
        ),
        Gap(12),
        SellioButton(text: 'Start Exploring', fullWidth: false, onTap: () {}),
      ],
    ),
  );
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