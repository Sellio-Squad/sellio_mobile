import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sellio_mobile/core/design_system/widgets/sellio_app_bar.dart';
import '../../core/design_system/themes/sellio_theme_provider.dart';
import 'package:sellio_mobile/core/design_system/constants/assets.dart';

void main() {
  runApp(SellioThemeProvider(
    brightness: Brightness.light,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sellio Preview',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NotificationScreen(),
    );
  }
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({
    super.key,
  });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colors.surfaceLow,
      appBar: SellioAppBar(
        title: "Notifications",
        showBackButton: true,
      ),
      body: Column(
        children: [
          DateHeader(
            date: "12/10/2024",
          ),
          NotificationItem(
            state: 0,
            orderId: "1x23456",
            storeName: "Sweet Lovers - Pasteleria",
            time: "11:12 PM",
          ),
          NotificationItem(
            state: 0,
            orderId: "1x23456",
            storeName: "Sweet Lovers - Pasteleria",
            time: "11:12 PM",
          ),
          NotificationItem(
            state: 0,
            orderId: "1x23456",
            storeName: "Sweet Lovers - Pasteleria",
            time: "11:12 PM",
          ),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final int state;
  final String orderId;
  final String storeName;
  final String time;

  const NotificationItem({
    super.key,
    required this.state,
    required this.orderId,
    required this.storeName,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final icon = switch (state) {
      0 => Assets.cart,
      1 => Assets.packageProcess,
      2 => Assets.packageProcess,
      _ => Assets.packageProcess,
    };
    final orderState = switch (state) {
      0 => "has been Placed successfully",
      1 => "has been delivered successfully",
      2 => "has been cancelled",
      _ => "has been cancelled",
    };

    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.theme.colors.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(9),
                    child: SvgPicture.asset(
                      icon,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                          context.theme.colors.title, BlendMode.srcIn),
                    ),
                  )),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 8, right: 16),
                    child: Text.rich(
                      TextSpan(
                        text: "Your order #$orderId from ",
                        style: context.theme.typography.textTheme.bodySmall
                            .copyWith(
                          color: context.theme.colors.body,
                        ),
                        children: [
                          TextSpan(
                            text: "$storeName ",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              fontFamily: 'Rubik',
                              color: context.theme.colors.body,
                            ),
                          ),
                          TextSpan(
                            text: "$orderState.",
                            style: context.theme.typography.textTheme.bodySmall
                                .copyWith(
                              color: context.theme.colors.body,
                            ),
                          ),
                        ],
                      ),
                      softWrap: true,
                    )),
                Padding(
                    padding: const EdgeInsets.only(left: 8, top: 1),
                    child: Text(
                      time,
                      style: context.theme.typography.textTheme.labelSmall
                          .copyWith(color: context.theme.colors.body),
                    )),
              ],
            )),
          ],
        ),
        Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
            child: Divider(
              color: context.theme.colors.stroke,
              thickness: 1,
            ))
      ],
    );
  }
}

class DateHeader extends StatelessWidget {
  final String date;

  const DateHeader({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Row(
        children: [
          Text(
            "Today",
            style: context.theme.typography.textTheme.labelSmall.copyWith(
              color: context.theme.colors.body,
            )
          ),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                child: Divider(
                  color: context.theme.colors.stroke,
                  thickness: 1,
                )
              )
          )
        ],
      ),
    );
  }
}
