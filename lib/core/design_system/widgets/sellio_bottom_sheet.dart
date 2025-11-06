import 'package:flutter/material.dart';
import 'package:sellio_mobile/core/design_system/themes/sellio_theme_provider.dart';

class SellioBottomSheet extends StatelessWidget {
  final Widget content;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  SellioBottomSheet({super.key, required this.content});

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
          Navigator.of(context).pop();
        }
      },
      child:  IntrinsicHeight(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _CustomDragHandle(),
            Navigator(
              key: navigatorKey,
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) => content,
                );
              },
            ),
          ],
        ),
      )
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
