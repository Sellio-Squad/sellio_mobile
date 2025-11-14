
import 'package:equatable/equatable.dart';
import 'package:sellio_mobile/core/design_system/constants/app_strings.dart';
import 'package:sellio_mobile/domain/entities/user.dart';

import 'BottomSheetType.dart';

sealed class AccountState extends Equatable {
  const AccountState();
}

class AccountInitial extends AccountState {
  const AccountInitial();

  @override
  List<Object?> get props => [];
}

class AccountLoading extends AccountState {
  const AccountLoading();

  @override
  List<Object?> get props => [];
}

class AccountLoaded extends AccountState {
  final User userProfile;
  final bool notificationsEnabled;
  final String selectedLanguage;
  final String appVersion;
  final BottomSheetType activeBottomSheet;


  const AccountLoaded({
    required this.userProfile,
    this.notificationsEnabled = true,
    this.selectedLanguage = AppStrings.english,
    this.appVersion = AppStrings.appVersionNumber,
    this.activeBottomSheet = BottomSheetType.none,

  });

  AccountLoaded copyWith({
    User? userProfile,
    bool? notificationsEnabled,
    String? selectedLanguage,
    String? appVersion,
    BottomSheetType? activeBottomSheet,
  }) {
    return AccountLoaded(
      userProfile: userProfile ?? this.userProfile,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      appVersion: appVersion ?? this.appVersion,
      activeBottomSheet: activeBottomSheet ?? this.activeBottomSheet,
    );
  }

  @override
  List<Object?> get props => [
    userProfile,
    notificationsEnabled,
    selectedLanguage,
    appVersion,
    activeBottomSheet,
  ];
}

class AccountError extends AccountState {
  final String message;

  const AccountError({required this.message});

  @override
  List<Object?> get props => [message];
}

class AccountActionLoading extends AccountState {
  final AccountLoaded previousState;

  const AccountActionLoading({required this.previousState});

  @override
  List<Object?> get props => [previousState];
}