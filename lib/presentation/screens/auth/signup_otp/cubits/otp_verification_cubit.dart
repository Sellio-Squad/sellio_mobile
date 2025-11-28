import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/core/localization/l10n/app_localizations.dart';
import 'package:sellio_mobile/domain/repositories/auth_repository.dart';

import 'otp_verification_state.dart';

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  final AuthRepository _authRepository;

  OtpVerificationCubit({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const OtpVerificationInitial());

  Future<void> verifyOtp({
    required String sessionId,
    required String otp,
    AppLocalizations? localizations,
  }) async {
    emit(const OtpVerificationLoading());

    try {
      final result = await _authRepository.verifyOtp(
        sessionId: sessionId,
        otp: otp,
      );

      result.fold(
        onSuccess: (_) {
          // Tokens are already saved in repository
          emit(const OtpVerificationSuccess());
        },
        onFailure: (error) {
          emit(OtpVerificationError(
            message: error.message,
          ));
        },
      );
    } catch (e) {
      emit(OtpVerificationError(
        message: localizations?.failed_to_create_account ?? 
                'Failed to verify OTP. Please try again.',
      ));
    }
  }

  Future<void> resendOtp({
    required String sessionId,
  }) async {
    emit(const OtpResendLoading());

    try {
      final result = await _authRepository.resendOtp(
        sessionId: sessionId,
      );

      result.fold(
        onSuccess: (_) {
          emit(const OtpResendSuccess());
          // Reset to initial state after a short delay
          Future.delayed(const Duration(milliseconds: 500), () {
            if (state is OtpResendSuccess) {
              emit(const OtpVerificationInitial());
            }
          });
        },
        onFailure: (error) {
          emit(OtpVerificationError(
            message: error.message,
          ));
        },
      );
    } catch (e) {
      emit(OtpVerificationError(
        message: 'Failed to resend OTP. Please try again.',
      ));
    }
  }
}

