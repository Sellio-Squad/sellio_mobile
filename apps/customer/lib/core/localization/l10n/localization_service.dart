import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_localizations.dart';
import '../cubit/locale_cubit.dart';

extension L10nX on BuildContext {
  AppLocalizations get local => AppLocalizations.of(this);

  LocaleCubit get localeCubit => read<LocaleCubit>();

  Locale get currentLocale => Localizations.localeOf(this);

  bool get isRTL => Directionality.of(this) == TextDirection.rtl;
}
