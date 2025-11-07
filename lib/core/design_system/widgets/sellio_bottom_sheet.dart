import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/app_management/route/navigation_extensions.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

class SellioBottomSheet extends StatelessWidget {
  final Widget content;
  final double? height;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  SellioBottomSheet({
    super.key,
    required this.content,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final NavigatorState? childNavigator = navigatorKey.currentState;
        if (childNavigator != null && childNavigator.canPop()) {
          childNavigator.pop();
        } else {
          context.navigator.pop();
        }
      },
      child: SizedBox(
        height: height ?? MediaQuery.of(context).size.height * 0.25,
        child: Column(
          children: [
            _CustomDragHandle(),
            Expanded(
              child: Navigator(
                key: navigatorKey,
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (context) {
                      return content;
                    },
                    // => nextBottomSheet ?? Container(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomDragHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 6, bottom: 22),
        child: Container(
          width: 44,
          height: 4,
          decoration: BoxDecoration(
            color: context.theme.colors.stroke,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
