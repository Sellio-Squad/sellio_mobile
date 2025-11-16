import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sellio_mobile/core/design_system/constants/app_strings.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_colors.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_typography.dart';
import 'package:sellio_mobile/core/design_system/widgets/buttons/switch.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
import 'package:sellio_mobile/domain/repositories/auth_repository.dart';
import 'package:sellio_mobile/presentation/screens/account/reset_password/reset_password_content.dart';

import '../../../core/design_system/constants/assets.dart';
import 'AccountOptionCard.dart';
import 'account_options/account_options_bottom_sheet.dart';
import 'account_settings/account_settings_bottom_sheet.dart';
import 'cubits/BottomSheetType.dart';
import 'cubits/account_cubit.dart';
import 'cubits/account_state.dart';
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
    SellioTextTheme themeText = context.theme.typography.textTheme;
    SellioColorScheme colors = context.theme.colors;
    return BlocProvider(
        create: (context) => AccountCubit(
          context.read<AuthRepository>(),
        )..loadProfileData(),
        child: BlocConsumer<AccountCubit, AccountState>(
            listener: (context, state) {
          if (state is AccountLoaded &&
              state.activeBottomSheet != BottomSheetType.none) {
            _showBottomSheetByType(context, state.activeBottomSheet);
          }
        }, builder: (context, state) {
          switch (state) {
            case AccountInitial():
              return const Center(child: CircularProgressIndicator());
            case AccountLoading():
              return const Center(child: CircularProgressIndicator());
            case AccountLoaded():
              return _accountContent(context, state, themeText, colors);
            case AccountError():
              return Scaffold(
                body: Center(child: Text('An error occurred ${state.message}')),
              );
            case AccountActionLoading():
               return Stack(
                children: [
                  _accountContent(context, state.previousState, themeText, colors),
                  const Center(child: CircularProgressIndicator()),
                ],
              );
          }
        }));
  }

  Widget _accountContent(
    BuildContext context,
    AccountLoaded state,
    SellioTextTheme themeText,
    SellioColorScheme colors,
  ) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: colors.surfaceLow,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: false,
        backgroundColor: colors.surfaceLow,
        appBar: SellioAppBar(
          title: AppStrings.account,
          actions: [
            GestureDetector(
              onTap: () {
                _showAccountOptionsBottomSheet(context);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: SvgPicture.asset(
                  Assets.moreHorizontalSquare,
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        uploadImageCard(
                          imagePath: Assets.cat,
                          editIconPath: Assets.pencilEdit,
                          context: context,
                          onEditTap: () {},
                        ),
                        const SizedBox(height: 12),
                        Text(
                          state.userProfile.fullName,
                          style: themeText.titleSmall
                              .copyWith(color: colors.title),
                        ),
                        Text(
                          state.userProfile.email ?? '',
                          style:
                              themeText.labelSmall.copyWith(color: colors.body),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: AccountCustomCard(
                            icon: Assets.package,
                            orderTitle: AppStrings.myOrders),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: AccountCustomCard(
                            icon: Assets.heartCheck,
                            orderTitle: AppStrings.myFavourites),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  AccountOptionCard(
                    prefixIcon: Assets.repair,
                    orderTitle: AppStrings.accountSettings,
                    onCardClicked: () {
                      context
                          .read<AccountCubit>()
                          .showBottomSheet(BottomSheetType.accountSettings);
                    },
                    trailing: SvgPicture.asset(Assets.arrowRightCustom),
                  ),
                  const SizedBox(height: 12),
                  AccountOptionCard(
                    prefixIcon: Assets.circleLockAdd,
                    orderTitle: AppStrings.resetPassword,
                    onCardClicked: () {
                      context
                          .read<AccountCubit>()
                          .showBottomSheet(BottomSheetType.resetPassword);
                    },
                    trailing: SvgPicture.asset(Assets.arrowRightCustom),
                  ),
                  const SizedBox(height: 12),
                  AccountOptionCard(
                    prefixIcon: Assets.languageCircle,
                    orderTitle: AppStrings.language,
                    onCardClicked: () {
                      context
                          .read<AccountCubit>()
                          .showBottomSheet(BottomSheetType.language);
                    },
                    trailing: SvgPicture.asset(Assets.arrowRightCustom),
                  ),
                  const SizedBox(height: 12),
                  AccountOptionCard(
                    prefixIcon: Assets.notification,
                    orderTitle: AppStrings.notification,
                    onCardClicked: () {},
                    trailing: DesignSwitch(
                      value: state.notificationsEnabled,
                      onChanged: (bool value) {
                        context.read<AccountCubit>().toggleNotifications(value);
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  AccountOptionCard(
                    prefixIcon: Assets.mobileProgramming,
                    orderTitle: AppStrings.appVersion,
                    onCardClicked: () {},
                    trailing: Text(
                      AppStrings.appVersionNumber,
                      style: themeText.labelSmall.copyWith(
                        color: colors.body,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheetByType(BuildContext context, BottomSheetType type) {
    switch (type) {
      case BottomSheetType.none:
        return;
      case BottomSheetType.accountSettings:
        return _showAccountSettingsBottomSheet(context);
      case BottomSheetType.resetPassword:
        return _showResetPasswordBottomSheet(context);
      case BottomSheetType.language:
        return _showLanguageBottomSheet(context);
      case BottomSheetType.accountOptions:
        return _showAccountOptionsBottomSheet(context);
      case BottomSheetType.logout:
        return _showLogoutBottomSheet(context);
      case BottomSheetType.deleteAccount:
        return _showDeleteAccountBottomSheet(context);
    }
  }

  void _showAccountSettingsBottomSheet(BuildContext context) {
    AccountSettingsBottomSheet.show(
        context: context,
        onSave: (fullName, phoneNumber, countryCode) {
          context.read<AccountCubit>().updateAccountSettings(
              fullName: fullName, phone: phoneNumber, countryCode: countryCode);
        });
  }

  void _showResetPasswordBottomSheet(BuildContext context) {
    ResetPasswordBottomSheet.show(
      onSave: (currentPassword, newPassword, confirmNewPassword) {
        context.read<AccountCubit>().resetPassword(
            currentPassword: currentPassword, newPassword: newPassword);
      },
      context: context,
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    ChangeLanguageBottomSheet.show(
      context: context,
      onSave: (String language) {
        context.read<AccountCubit>().changeLanguage(language);
      },
      selectedLanguage: AppStrings.english,
    );
  }

  void _showLogoutBottomSheet(BuildContext context) {
    LogoutBottomSheet.show(
      context: context,
      onLogout: () {
        context.read<AccountCubit>().logout();
      },
    );
  }

  void _showDeleteAccountBottomSheet(BuildContext context) {
    DeleteAccountBottomSheet.show(
      context: context,
      onDeleteAccount: () {
        context.read<AccountCubit>().deleteAccount();
      },
    );
  }

  void _showAccountOptionsBottomSheet(BuildContext context) {
    AccountOptionsBottomSheet.show(
        onLogout: () {
          context.read<AccountCubit>().showBottomSheet(BottomSheetType.logout);
        },
        onDeleteAccount: () {
          context
              .read<AccountCubit>()
              .showBottomSheet(BottomSheetType.deleteAccount);
        },
        context: context);
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
          child: Container(
            width: 136,
            height: 136,
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                CircleAvatar(
                  radius: 68,
                  backgroundImage: AssetImage(imagePath),
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
                      decoration: BoxDecoration(
                        boxShadow: [
                          const BoxShadow(
                            color: Color(0x70000000),
                          ),
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

class AccountCustomCard extends StatelessWidget {
  final Color? cardColor;
  final double borderRadius;
  final String icon;
  final double iconSize;
  final String orderTitle;

  const AccountCustomCard({
    super.key,
    this.cardColor,
    this.borderRadius = 8,
    required this.icon,
    this.iconSize = 28,
    required this.orderTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 160,
      decoration: BoxDecoration(
        color: cardColor ?? context.theme.colors.surface,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
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
    );
  }
}
