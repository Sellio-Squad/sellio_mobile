import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class HorizontalDriver extends StatelessWidget {
  const HorizontalDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Divider(height: 1, color: context.theme.colors.stroke),
    );
  }
}
