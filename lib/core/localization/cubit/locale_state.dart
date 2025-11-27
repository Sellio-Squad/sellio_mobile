part of 'locale_cubit.dart';

class LocaleState extends Equatable {
  final Locale locale;

  const LocaleState({required this.locale});

  @override
  List<Object?> get props => [locale];
}