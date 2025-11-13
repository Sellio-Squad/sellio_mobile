import 'package:flutter_bloc/flutter_bloc.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(const ResetPasswordState());

  void updateCurrentPassword(String value) {
    emit(state.copyWith(currentPassword: value));
  }

  void updateNewPassword(String value) {
    emit(state.copyWith(newPassword: value));
  }

  void updateConfirmPassword(String value) {
    emit(state.copyWith(confirmPassword: value));
  }

  void submit(void Function() onSave) {
    if (state.isFormValid) {
      onSave();
    }
  }
}
