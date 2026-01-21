import 'package:equatable/equatable.dart';

abstract class AccountState extends Equatable {
  const AccountState();
  @override
  List<Object?> get props => [];
}

class AccountInitial extends AccountState {
  const AccountInitial();
}

class AccountLoading extends AccountState {
  const AccountLoading();
}

class AccountLoaded extends AccountState {
  final String fullName;
  final String email;
  final String? imagePath;
  final bool notificationsEnabled;

  const AccountLoaded({
    required this.fullName,
    required this.email,
    required this.imagePath,
    this.notificationsEnabled = true,
  });

  AccountLoaded copyWith({
    String? fullName,
    String? email,
    String? imagePath,
    bool? notificationsEnabled,
  }) {
    return AccountLoaded(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      imagePath: imagePath ?? this.imagePath,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }

  @override
  List<Object?> get props =>
      [fullName, email, imagePath, notificationsEnabled];
}

class AccountError extends AccountState {
  final String message;

  const AccountError({required this.message});

  @override
  List<Object?> get props => [message];
}

class AvatarNotUploaded extends AccountState {
  const AvatarNotUploaded();
}

class UserNotLoggedIn extends AccountState {
  const UserNotLoggedIn();
}