import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:sellio_mobile/core/localization/l10n/localization_service.dart';

class OtpResendSection extends StatelessWidget {
  final int resendCountdown;
  final bool canResend;
  final VoidCallback onResend;

  const OtpResendSection({
    super.key,
    required this.resendCountdown,
    required this.canResend,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;
    final textTheme = context.theme.typography.textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.local.dont_received_code,
          style: textTheme.labelMedium.copyWith(color: colors.body),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: canResend ? onResend : null,
          child: Text(
            canResend
                ? context.local.re_send
                : context.local.re_send_in_resend_countdown_Sec(resendCountdown),
            style: textTheme.labelMedium.copyWith(
              color: canResend ? colors.primary : colors.body,
              decoration: canResend ? TextDecoration.underline : null,
            ),
          ),
        ),
      ],
    );
  }
}