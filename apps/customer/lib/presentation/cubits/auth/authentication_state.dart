part of 'authentication_cubit.dart';

@immutable
sealed class AuthenticationState {
  const AuthenticationState();
}

final class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

final class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();
}

final class LoggedIn extends AuthenticationState {
  final User user;

  const LoggedIn({required this.user});
}

final class Guest extends AuthenticationState {
  const Guest();
}

final class AuthenticationError extends AuthenticationState {
  final String message;

  const AuthenticationError({required this.message});
}

final class RequireLogin extends AuthenticationState {
  const RequireLogin();
}
