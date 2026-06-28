import 'package:flutter/material.dart';

import '../../../core/localization/l10n/localization_service.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(context.local.account)),
    );
  }
}
