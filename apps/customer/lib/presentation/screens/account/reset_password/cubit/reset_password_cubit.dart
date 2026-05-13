import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/error/result.dart';
import 'package:sellio_mobile/domain/repositories/user_repository.dart';

import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final UserRepository _userRepository;

  ResetPasswordCubit(this._userRepository) : super(const ResetPasswordState());

  void updateCurrentPassword(String value) {
    emit(state.copyWith(
      currentPassword: value,
      errorMessage: null,
    ));
  }

  void updateNewPassword(String value) {
    emit(state.copyWith(
      newPassword: value,
      errorMessage: null,
    ));
  }

  void updateConfirmPassword(String value) {
    emit(state.copyWith(
      confirmPassword: value,
      errorMessage: null,
    ));
  }

  Future<void> submit(void Function() onSave) async {
    if (!state.isFormValid) return;

    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _userRepository.resetPassword(
      currentPassword: state.currentPassword,
      newPassword: state.newPassword,
      confirmPassword: state.confirmPassword,
    );

    if (result is Success) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
      ));
      onSave();
    } else if (result is ResultFailure) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: result.failure.message,
      ));
    }
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }
}
