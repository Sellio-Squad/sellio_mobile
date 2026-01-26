import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/localization/cubit/locale_cubit.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';
import 'package:sellio_mobile/presentation/screens/account/cubit/account_cubit.dart';
import 'package:sellio_mobile/presentation/screens/account/navigation/account_navigation.dart';
import 'package:sellio_mobile/presentation/screens/account/reset_password/reset_password_content.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/repositories/user_repository.dart';
import 'account_option_card.dart';
import 'account_options/account_options_bottom_sheet.dart';
import 'account_settings/account_settings_bottom_sheet.dart';
import 'cubit/account_state.dart';
import 'delete_account/delete_account_bottom_sheet.dart';
import 'language/change_language_bottom_sheet.dart';
import 'logout/logout_bottom_sheet.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    SellioColorScheme colors = context.theme.colors;

    return BlocProvider(
      create: (context) =>
          AccountCubit(context.read<UserRepository>())..loadAccountDetails(),
      child: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: colors.surfaceLow,
            appBar: _buildAppBar(context, state),
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, AccountState state) {
    if (state is AccountError) {
      return SellioAppBar(
        title: context.local.account_screen,
      );
    }

    return SellioAppBar(
      title: context.local.account_screen,
      actions: [
        GestureDetector(
          onTap: () => _showAccountOptionsBottomSheet(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: SvgPicture.asset(
              AppImages.moreHorizontalSquare,
              width: 24,
              height: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, AccountState state) {
    if (state is AccountError) {
      return _buildErrorState(context);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildUserInfoSection(context, state),
        const SizedBox(height: 24),
        _buildOptionBody(context),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context) {
    return EmptySection(
      icon: AppImages.notLoggedIn,
      title: context.local.not_registered,
      description: context.local.login_to_access_your_account,
      buttonText: context.local.login,
      color: context.theme.colors.redVariant,
      onTap: () => navigateToLoginScreen(context),
    );
  }

  Widget _buildUserInfoSection(BuildContext context, AccountState state) {
    if (state is AccountLoading || state is AccountInitial) {
      return _buildLoadingInfo(context);
    } else if (state is AccountLoaded) {
      return _buildLoadedInfo(context, state);
    }

    return _buildLoadingInfo(context);
  }

  Widget _buildLoadingInfo(BuildContext context) {
    SellioColorScheme colors = context.theme.colors;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Center(
        child: Column(
          children: [
            Container(
              width: 136,
              height: 136,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.surface,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: 150,
              height: 20,
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 200,
              height: 16,
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadedInfo(BuildContext context, AccountLoaded state) {
    SellioColorScheme colors = context.theme.colors;
    SellioTextTheme themeText = context.theme.typography.textTheme;

    return Center(
      child: Column(
        children: [
          uploadImageCard(
            imagePath: state.imagePath ?? AppImages.imgAccount,
            editIconPath: AppImages.pencilEdit,
            context: context,
            onEditTap: () =>
                context.read<AccountCubit>().updateProfilePicture(),
          ),
          const SizedBox(height: 12),
          Text(
            state.fullName,
            style: themeText.titleSmall.copyWith(color: colors.title),
          ),
          if (state.email != null)
            Text(
              state.email!,
              style: themeText.labelSmall.copyWith(color: colors.body),
            ),
        ],
      ),
    );
  }

  Widget _buildOptionBody(BuildContext context) {
    SellioColorScheme colors = context.theme.colors;
    SellioTextTheme themeText = context.theme.typography.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: AccountCustomCard(
                  icon: AppImages.package,
                  orderTitle: context.local.my_orders,
                  onTap: () => navigateToMyOrders(context),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AccountCustomCard(
                  icon: AppImages.heartCheck,
                  orderTitle: context.local.my_favourites,
                  onTap: () => navigateToMyFavourites(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          AccountOptionCard(
            prefixIcon: AppImages.repair,
            orderTitle: context.local.account_settings,
            onCardClicked: () => _showAccountSettingsBottomSheet(context),
            trailing: SvgPicture.asset(AppImages.arrowRightCustom,
                matchTextDirection: true),
          ),
          const SizedBox(height: 12),
          AccountOptionCard(
            prefixIcon: AppImages.circleLockAdd,
            orderTitle: context.local.reset_password,
            onCardClicked: () => _showResetPasswordBottomSheet(context),
            trailing: SvgPicture.asset(AppImages.arrowRightCustom,
                matchTextDirection: true),
          ),
          const SizedBox(height: 12),
          BlocBuilder<LocaleCubit, LocaleState>(
            builder: (context, localeState) {
              final localeCubit = context.read<LocaleCubit>();

              return AccountOptionCard(
                prefixIcon: AppImages.languageCircle,
                orderTitle: context.local.language,
                onCardClicked: () => _showLanguageBottomSheet(context),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      localeCubit.getLocaleName(localeState.locale),
                      style: themeText.labelSmall.copyWith(color: colors.body),
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset(AppImages.arrowRightCustom,
                        matchTextDirection: true),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          BlocBuilder<AccountCubit, AccountState>(
            builder: (context, state) {
              final notificationsEnabled =
                  state is AccountLoaded ? state.notificationsEnabled : true;

              return AccountOptionCard(
                prefixIcon: AppImages.notification,
                orderTitle: context.local.notifications,
                onCardClicked: () {
                  context
                      .read<AccountCubit>()
                      .toggleNotifications(!notificationsEnabled);
                },
                trailing: SellioSwitch(
                  value: notificationsEnabled,
                  onChanged: (bool value) {
                    context.read<AccountCubit>().toggleNotifications(value);
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          AccountOptionCard(
            prefixIcon: AppImages.mobileProgramming,
            orderTitle: context.local.app_version,
            onCardClicked: () {},
            trailing: Text(
              '1.2',
              style: themeText.labelSmall.copyWith(color: colors.body),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  void _showAccountSettingsBottomSheet(BuildContext context) async {
    final result =
        await AccountSettingsBottomSheet.show(context: context, onSave: () {});

    if (result != null) {
      context.read<AccountCubit>().loadAccountDetails();
    }
  }

  void _showResetPasswordBottomSheet(BuildContext context) {
    ResetPasswordBottomSheet.show(
      context: context,
      onSave: () {
        debugPrint('Password reset successfully');
        context.read<AccountCubit>().loadAccountDetails();
      },
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    ChangeLanguageBottomSheet.show(context: context);
  }

  void _showLogoutBottomSheet(BuildContext context) {
    LogoutBottomSheet.show(
      context: context,
      onLogout: () {
        navigateToLoginScreen(context);
      },
    );
  }

  void _showDeleteAccountBottomSheet(BuildContext context) async {
    final result = await DeleteAccountBottomSheet.show(
      context: context,
    );
    if (result == true && context.mounted) {
      navigateToLoginScreen(context);
      Future.delayed(const Duration(milliseconds: 300), () {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.local.account_deleted_successfully ??
                  'Your account has been deleted successfully'),
              backgroundColor: context.theme.colors.body,
            ),
          );
        }
      });
    }
  }

  void _showAccountOptionsBottomSheet(BuildContext context) {
    AccountOptionsBottomSheet.show(
      onLogout: () => _showLogoutBottomSheet(context),
      onDeleteAccount: () => _showDeleteAccountBottomSheet(context),
      context: context,
      onDismiss: () {
        debugPrint('Dismissing bottom sheet...');
      },
    );
  }
}

Widget uploadImageCard({
  required String imagePath,
  required String editIconPath,
  required VoidCallback onEditTap,
  required BuildContext context,
  double shadowBlur = 8,
}) {
  return SizedBox(
    width: 140,
    height: 140,
    child: Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 136,
          height: 136,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                color: const Color(0x1F000000),
                blurRadius: shadowBlur,
              ),
            ],
          ),
        ),
        ClipOval(
          child: SizedBox(
            width: 136,
            height: 136,
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                CircleAvatar(
                  radius: 68,
                  backgroundImage: _getImageProvider(imagePath),
                  backgroundColor: context.theme.colors.surface,
                ),
                Positioned(
                  bottom: 0,
                  left: 2,
                  right: 2,
                  child: GestureDetector(
                    onTap: onEditTap,
                    child: Container(
                      width: 118,
                      height: 32,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Color(0x70000000)),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          editIconPath,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            context.theme.colors.onPrimary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

ImageProvider _getImageProvider(String imagePath) {
  if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
    return NetworkImage(imagePath);
  } else {
    return AssetImage(imagePath);
  }
}

class AccountCustomCard extends StatelessWidget {
  final Color? cardColor;
  final double borderRadius;
  final String icon;
  final double iconSize;
  final String orderTitle;
  final VoidCallback onTap;

  const AccountCustomCard({
    super.key,
    this.cardColor,
    this.borderRadius = 8,
    required this.icon,
    this.iconSize = 28,
    required this.orderTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        height: 90,
        width: 160,
        decoration: BoxDecoration(
          color: cardColor ?? context.theme.colors.surface,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              SvgPicture.asset(
                icon,
                width: iconSize,
                height: iconSize,
              ),
              const SizedBox(height: 16),
              Text(
                orderTitle,
                style: context.theme.typography.textTheme.labelMedium.copyWith(
                  color: context.theme.colors.title,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
