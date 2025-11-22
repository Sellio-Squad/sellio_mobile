import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';
import '../constants/app_images.dart';

class SellioSnackBar extends StatefulWidget {
  final bool isError;
  final String message;
  final String? title;
  final VoidCallback onCancelTap;

  const SellioSnackBar({
    super.key,
    required this.isError,
    required this.message,
    required this.onCancelTap,
    this.title,
  });

  @override
  State<SellioSnackBar> createState() => _SellioSnackBarState();
}

class _SellioSnackBarState extends State<SellioSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  double dragOffset = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, -0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  void _dismiss() {
    _controller.reverse().then((_) => widget.onCancelTap());
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = context.theme.colors;
    final snackBarTitle =
        widget.title ?? (widget.isError ? 'Error' : 'Success');

    final iconPath = widget.isError
        ? AppImages.alertDiamond
        : AppImages.checkmarkBadge;

    final iconColor = widget.isError
        ? themeColor.errorVariant
        : themeColor.greenVariant;

    final shadowColor = widget.isError
        ? themeColor.red.withAlpha(35)
        : themeColor.green.withAlpha(35);

    return SlideTransition(
      position: _slide,
      child: FadeTransition(
        opacity: _fade,
        child: Transform.translate(
          offset: Offset(dragOffset, 0),
          child: GestureDetector(
            onHorizontalDragUpdate: (details) {
              setState(() {
                dragOffset += details.delta.dx;
              });
            },
            onHorizontalDragEnd: (details) {
              const dismissThreshold = 80;

              if (dragOffset.abs() > dismissThreshold) {
                _dismiss();
              } else {
                setState(() => dragOffset = 0);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: context.theme.colors.surfaceLow,
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    offset: const Offset(0, 4),
                    blurRadius: 24,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  snackBarIcon(iconPath, iconColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: snackBarText(context, snackBarTitle, widget.message),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _dismiss,
                    child: SvgPicture.asset(
                      AppImages.cancelCircle,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget snackBarIcon(String iconPath, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: iconColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: SvgPicture.asset(iconPath, width: 28, height: 28),
    );
  }

  Widget snackBarText(BuildContext context, String title, String message) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.theme.typography.textTheme.labelLarge.copyWith(
            color: context.theme.colors.title,
          ),
        ),
        Text(
          message,
          style: context.theme.typography.textTheme.bodySmall.copyWith(
            color: context.theme.colors.body,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}