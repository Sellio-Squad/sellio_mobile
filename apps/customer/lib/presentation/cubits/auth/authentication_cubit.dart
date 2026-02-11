import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/domain/entities/user.dart';
import 'package:sellio_mobile/domain/repositories/auth_repository.dart';
import 'package:sellio_mobile/domain/repositories/user_repository.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  AuthenticationCubit(this._authRepository, this._userRepository)
      : super(const AuthenticationInitial()) {
    loadAuthenticationStatus();
  }

  Future<void> loadAuthenticationStatus() async {
    emit(const AuthenticationLoading());
    try {
      final isLoggedIn = await _authRepository.isLoggedIn();
      if (isLoggedIn) {
        await loadUserProfile();
      } else {
        emit(const Guest());
      }
    } catch (e) {
      emit(AuthenticationError(message: e.toString()));
    }
  }

  Future<void> loadUserProfile() async {
    final result = await _userRepository.getUserProfile();

    result.fold(
      onSuccess: (user) {
        emit(LoggedIn(user: user));
      },
      onFailure: (failure) {
        emit(AuthenticationError(
          message: failure.message,
        ));
      },
    );
  }

  Future<void> logout() async {
    emit(const AuthenticationLoading());

    final result = await _authRepository.logout();

    result.fold(
      onSuccess: (_) {
        emit(const Guest());
      },
      onFailure: (error) {
        emit(AuthenticationError(message: error.message));
      },
    );
  }

  void updateUserProfile(User user) {
    if (state is LoggedIn) {
      emit(LoggedIn(user: user));
    }
  }

  Future<T?> requireLogin<T>(Future<T> Function() action) async {
    if (state is LoggedIn) {
      return await action();
    }

    emit(const RequireLogin());

    return null;
  }
}
