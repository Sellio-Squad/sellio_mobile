import 'package:flutter/material.dart';
import '../../l10n/auth_localizations.dart';

extension AuthL10nX on BuildContext {
  AuthLocalizations get authLocal => AuthLocalizations.of(this);
}
