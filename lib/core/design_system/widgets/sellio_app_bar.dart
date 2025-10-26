import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import '../constants/assets.dart';

class SellioAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBack;
  final String? title;
  final String? userName;
  final String? location;
  final VoidCallback? onNotificationTap;
  final bool showGreeting;

  const SellioAppBar({
    Key? key,
    this.showBack = false,
    this.title,
    this.userName,
    this.location,
    this.onNotificationTap,
    this.showGreeting = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: context.theme.colors.surfaceLow,
      elevation: 0,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showBack)
                IconButton(
                  icon: SvgPicture.asset(Assets.arrowLeft),
                  onPressed: () => Navigator.of(context).pop(),
                )
              else
                Image.asset(
                  Assets.sellio,
                  height: 58,
                  width: 61,
                ),
              Expanded(
                child: showGreeting
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome, $userName',
                      style: context.theme.typography.textTheme.labelSmall.copyWith(
                        color: context.theme.colors.title,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Assets.location,
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          location ?? '',
                          style: context.theme.typography.textTheme.labelXSmall.copyWith(
                            color: context.theme.colors.body,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
                    : Text(
                  title ?? '',
                  style: context.theme.typography.textTheme.titleMedium.copyWith(
                    color: context.theme.colors.title,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              IconButton(
                icon: SvgPicture.asset(Assets.bell),
                onPressed: onNotificationTap,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
