import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/domain/repositories/auth_repository.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository _authRepository;

  ForgotPasswordCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(ForgotPasswordInitial());

  Future<void> requestOtp({
    required String phoneNumber,
    required String defaultRegion,
  }) async {
    emit(ForgotPasswordLoading());
    final result = await _authRepository.sendForgotPasswordOtp(
      phoneNumber: phoneNumber,
      defaultRegion: defaultRegion,
    );
    result.fold(
      onSuccess: (sessionId) {
        emit(ForgotPasswordOtpSent(
          sessionId: sessionId,
          phoneNumber: phoneNumber,
          defaultRegion: defaultRegion,
        ));
      },
      onFailure: (error) {
        emit(ForgotPasswordFailure(message: error.message));
      },
    );
  }

  Future<void> verifyOtp({
    required String sessionId,
    required String otp,
  }) async {
    emit(ForgotPasswordLoading());
    final result = await _authRepository.verifyForgotPasswordOtp(
      sessionId: sessionId,
      otp: otp,
    );
    result.fold(
      onSuccess: (_) {
        emit(ForgotPasswordOtpVerified(sessionId: sessionId));
      },
      onFailure: (error) {
        emit(ForgotPasswordFailure(message: error.message));
      },
    );
  }

  Future<void> resetPassword({
    required String sessionId,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ForgotPasswordLoading());
    final result = await _authRepository.resetPassword(
      sessionId: sessionId,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
    result.fold(
      onSuccess: (_) {
        emit(ForgotPasswordSuccess());
      },
      onFailure: (error) {
        emit(ForgotPasswordFailure(message: error.message));
      },
    );
  }
}
