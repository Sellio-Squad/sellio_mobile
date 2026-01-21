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
  final String firstName;
  final String lastName;
  final String? email;
  final String? imagePath;
  final bool notificationsEnabled;

  const AccountLoaded({
    required this.firstName,
    required this.lastName,
    this.email,
    this.imagePath,
    this.notificationsEnabled = true,
  });

  AccountLoaded copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? imagePath,
    bool? notificationsEnabled,
  }) {
    return AccountLoaded(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      imagePath: imagePath ?? this.imagePath,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }

  @override
  List<Object?> get props =>
      [firstName, lastName, email, imagePath, notificationsEnabled];
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