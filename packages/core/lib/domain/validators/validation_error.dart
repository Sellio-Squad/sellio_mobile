import 'package:flutter/material.dart';

abstract class ValidationError {
  const ValidationError();

  String toLocalizedString(BuildContext context);
}
