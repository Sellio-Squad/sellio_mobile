import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme.dart';
import '../../../core/app_management/route/navigation_extensions.dart';
import '../../../core/design_system/constants/app_images.dart';
import '../../../core/design_system/constants/app_strings.dart';
import '../../../core/design_system/constants/assets.dart';
import '../../../core/design_system/widgets/buttons/sellio_button.dart';
import '../../../core/design_system/widgets/cards/sellio_product_horizontal_card.dart';
import '../../../core/design_system/widgets/sellio_text_field.dart';
import '../../../core/navigate/navigation_extensions.dart';
import '../../cubits/cart/cubit/cart_cubit.dart';
import '../../cubits/cart/cubit/cart_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().loadCart();
  }

  @override
  Widget build(BuildContext context) {
    final theme = SellioTheme.of(context);
    final textTheme = theme.typography.textTheme;
    final colors = theme.colors;

    return Scaffold(
      backgroundColor: colors.surfaceLow,
      appBar: _buildAppBar(context),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.cart == null || state.cart!.items.isEmpty) {
            return Center(
              child: Text(
                AppStrings.emptyCart,
                style: textTheme.titleMedium.copyWith(
                  color: colors.body,
                ),
              ),
            );
          }

          final cart = state.cart!;
          final totalPrice = cart.items.fold(
            0.0,
            (sum, item) => sum + (item.price * item.quantity),
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 46),
            child: Column(
              children: [
                _buildHeader(cart.items.length, textTheme, colors),
                const Gap(12),
                _buildCartItems(cart, state),
                const Gap(12),
                Divider(color: colors.stroke, thickness: 1),
                const Gap(12),
                _buildNoteSection(textTheme, colors),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cart = state.cart;
          final totalPrice = cart?.items.fold(
                0.0,
                (sum, item) => sum + (item.price * item.quantity),
              ) ??
              0.0;

          return _buildBottomBar(
            context,
            totalPrice,
            cart?.items.length ?? 0,
          );
        },
      ),
    );
  }
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final theme = SellioTheme.of(context);
    final textTheme = theme.typography.textTheme;
    final colors = theme.colors;

    return PreferredSize(
      preferredSize: const Size.fromHeight(68),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: AppBar(
          backgroundColor: colors.surfaceLow,
          title: Text(
            AppStrings.cart,
            style: textTheme.titleMedium.copyWith(color: colors.title),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Center(
                child: Text(
                  AppStrings.addMoreItems,
                  style: textTheme.labelMedium.copyWith(color: colors.primary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(int count, textTheme, colors) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$count ${AppStrings.items}',
          style: textTheme.labelMedium.copyWith(color: colors.body),
        ),
        Text(
          AppStrings.select,
          style: textTheme.labelMedium.copyWith(color: colors.primary),
        ),
      ],
    );
  }

  Widget _buildCartItems(cart, CartState state) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cart.items.length,
      separatorBuilder: (_, __) => const Gap(12),
      itemBuilder: (_, index) {
        final item = cart.items[index];
        final qty = state.productCounts[item.productId] ?? item.quantity;

        return SellioProductHorizontalCard(
          imageUrl: item.productImage,
          title: item.productName,
          description: '',
          price: '${item.currency} ${item.price}',
          originalPrice: null,
          count: qty,
          onIncrement: () =>
              context.read<CartCubit>().incrementProduct(item.productId),
          onDecrement: () =>
              context.read<CartCubit>().decrementProduct(item.productId),
        );
      },
    );
  }

  Widget _buildNoteSection(textTheme, colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.noteAboutOrder,
            style: textTheme.titleMedium.copyWith(color: colors.title)),
        const Gap(8),
        SellioTextField(
          controller: _noteController,
          isParagraph: true,
          hintText: AppStrings.writeHere,
          maxLine: 1,
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context, double total, int count) {
    final theme = SellioTheme.of(context);
    final textTheme = theme.typography.textTheme;
    final colors = theme.colors;

    return Container(
      decoration: BoxDecoration(
        color: colors.surfaceLow,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1), // FIXED
            offset: const Offset(0, -4),
            blurRadius: 8,
          ),
        ],
      ),
      height: 110,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              SvgPicture.asset(AppImages.discountTag),
              const Gap(4),
              Text(
                AppStrings.totalPrice,
                style: textTheme.titleSmall.copyWith(color: colors.title),
              ),
              const Spacer(),
              Text(
                total.toStringAsFixed(2),
                style: textTheme.titleSmall.copyWith(color: colors.primary),
              ),
            ],
          ),
          const Gap(12),
          SellioButton(
            text: '${AppStrings.confirmOrder} ($count)',
            backgroundColor: colors.primary,
            fullWidth: true,
            suffixSvgPath: AppImages.packageAdd,
            onTap: () => _showOrderConfirmation(context),
          ),
        ],
      ),
    );
  }

  void _showOrderConfirmation(BuildContext context) {
    final theme = SellioTheme.of(context);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  color: theme.colors.primaryVariant,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AppImages.cartPackageDelivered,
                  colorFilter: ColorFilter.mode(
                    theme.colors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const Gap(16),
              Text(
                '${AppStrings.order} #2002124',
                style: theme.typography.textTheme.labelMedium
                    .copyWith(color: theme.colors.title),
              ),
              const Gap(8),
              Text(
                AppStrings.orderReceived,
                style: theme.typography.textTheme.titleSmall
                    .copyWith(color: theme.colors.body),
              ),
              const Gap(24),
              SellioButton(
                text: AppStrings.backToShopping,
                backgroundColor: theme.colors.primaryVariant,
                textStyle: theme.typography.textTheme.labelMedium
                    .copyWith(color: theme.colors.primary),
                onTap: () => context.navigator.goToHome(),
                fullWidth: true,
              ),
            ],
          ),
        );
      },
    );
  }
}
