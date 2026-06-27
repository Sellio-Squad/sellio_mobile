import 'dart:ui';
import 'package:equatable/equatable.dart';

class LocaleState extends Equatable {
  final Locale locale;

  const LocaleState({required this.locale});

  @override
  List<Object?> get props => [locale];
}
