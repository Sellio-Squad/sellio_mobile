import 'package:authentication/authentication.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';

import '../../../core/localization/l10n/localization_service.dart';
import '../../../core/utils/price_calculator.dart';
import '../../cubits/cart/cubit/cart_cubit.dart';
import '../../cubits/cart/cubit/cart_state.dart';
import '../account/navigation/account_navigation.dart';
import 'constants/cart_constants.dart';
import 'widgets/cart_bottom_bar.dart';
import 'widgets/cart_items_list.dart';
import 'widgets/cart_note_section.dart';
import 'widgets/empty_cart_section.dart';
import 'widgets/order_confirmation_dialog.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _noteController = TextEditingController();
  bool _showLoginRequiredScreen = false;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _loadCart() {
    context.read<CartCubit>().loadCart();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, authState) {
        if (authState is LoggedIn) {
          setState(() {
            _showLoginRequiredScreen = false;
          });
          context.read<CartCubit>().loadCart();
        }
      },
      child: Scaffold(
        backgroundColor: context.theme.colors.surfaceLow,
        appBar: SellioAppBar(
          title: context.local.cart,
        ),
        body: BlocConsumer<CartCubit, CartState>(
          listener: _handleStateChanges,
          builder: (context, state) => _buildBody(state),
        ),
        bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (_showLoginRequiredScreen) {
              return const SizedBox.shrink();
            }

            if (state.cart == null || state.cart!.items.isEmpty) {
              return const SizedBox.shrink();
            }

            final totalPrice = PriceCalculator.calculateTotalPrice(
              state.cart!.items,
            );
            final itemCount = state.cart!.items.length;

            return CartBottomBar(
              totalPrice: totalPrice,
              itemCount: itemCount,
              onConfirmOrder: () => _handleConfirmOrder(context),
            );
          },
        ),
      ),
    );
  }

  void _handleStateChanges(BuildContext context, CartState state) {
    if (state is CartOrderSuccess) {
      OrderConfirmationDialog.show(context);

      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          context.read<CartCubit>().loadCart();
        }
      });
    } else if (state is CartError) {
      _showErrorSnackBar(state.message);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: context.theme.colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildBody(CartState state) {
    if (_showLoginRequiredScreen) {
      return _buildLoginRequiredSection(context);
    }

    if (state is CartLoading && state.cart == null) {
      return Center(
        child: CircularProgressIndicator(
          color: context.theme.colors.primary,
        ),
      );
    }

    if (state.cart == null || state.cart!.items.isEmpty) {
      return const EmptyCartSection();
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: _buildCartContent(state),
    );
  }

  Widget _buildLoginRequiredSection(BuildContext context) {
    return EmptySection(
      icon: AppImages.notLoggedIn,
      title: context.local.not_registered,
      description: context.local.cart_empty_screen,
      buttonText: context.local.login,
      color: context.theme.colors.redVariant,
      onTap: () => navigateToLoginScreen(context),
    );
  }

  Widget _buildCartContent(CartState state) {
    final cart = state.cart!;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: CartConstants.horizontalPadding,
        right: CartConstants.horizontalPadding,
        bottom: 160,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCartItemsCount(context, cart.itemCount),
          const Gap(CartConstants.sectionSpacing),
          CartItemsList(
            items: cart.items,
            productCounts: state.productCounts,
            onIncrement: _handleIncrement,
            onDecrement: _handleDecrement,
            onRemove: _handleRemove,
          ),
          const Gap(CartConstants.sectionSpacing),
          Divider(
            color: context.theme.colors.stroke,
            thickness: 1,
          ),
          const Gap(CartConstants.sectionSpacing),
          CartNoteSection(controller: _noteController),
        ],
      ),
    );
  }

  void _handleIncrement(String productId) {
    context.read<CartCubit>().incrementProduct(productId);
  }

  void _handleDecrement(String productId) {
    context.read<CartCubit>().decrementProduct(productId);
  }

  void _handleRemove(String productId) {
    context.read<CartCubit>().removeFromCart(productId);
  }

  void _handleConfirmOrder(BuildContext context) {
    final authState = context.read<AuthenticationCubit>().state;

    if (authState is Guest) {
      setState(() {
        _showLoginRequiredScreen = true;
      });
      return;
    }

    final note = _noteController.text.trim();
    context.read<CartCubit>().confirmOrder(
          note.isNotEmpty ? note : null,
        );
  }

  Widget _buildCartItemsCount(BuildContext context, int count) {
    final theme = context.theme;
    final textTheme = theme.typography.textTheme;
    final colors = theme.colors;

    return Text(
      '$count ${context.local.items}',
      style: textTheme.labelMedium.copyWith(
        color: colors.body,
      ),
    );
  }
}
