import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/presentation/screens/auth/shared/constants/auth_constants.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final Future<void> Function(String otp) onVerify;
  final Future<void> Function() onResend;
  final int otpLength;
  final int countdownDuration;
  
  Timer? _countdownTimer;

  OtpCubit({
    required this.onVerify,
    required this.onResend,
    this.otpLength = 4,
    this.countdownDuration = AuthConstants.otpResendCountdown,
  }) : super(const OtpIdle()) {
    startCountdown();
  }

  void updateOtp(String value) {
    final currentState = state;
    if (currentState is! OtpIdle) return;

    final isComplete = value.length == otpLength;
    emit(currentState.copyWith(
      otpValue: value,
      isComplete: isComplete,
    ));
  }

  void clearOtp() {
    final currentState = state;
    if (currentState is! OtpIdle) return;

    emit(currentState.copyWith(
      otpValue: '',
      isComplete: false,
    ));
  }

  void startCountdown() {
    _countdownTimer?.cancel();

    final currentState = state;
    final idleState = currentState is OtpIdle ? currentState : const OtpIdle();

    emit(idleState.copyWith(
      countdown: countdownDuration,
      canResend: false,
    ));

    _countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        final state = this.state;
        if (state is OtpIdle && state.countdown > 0) {
          emit(state.copyWith(countdown: state.countdown - 1));
        } else {
          timer.cancel();
          if (state is OtpIdle) {
            emit(state.copyWith(canResend: true));
          }
        }
      },
    );
  }

  Future<void> verifyOtp() async {
    final currentState = state;
    if (currentState is! OtpIdle || !currentState.isComplete) return;

    final otp = currentState.otpValue;
    emit(const OtpVerifying());

    try {
      await onVerify(otp);
      emit(const OtpVerified());
    } catch (e) {
      emit(OtpFailure(errorMessage: e.toString()));
      emit(currentState);
    }
  }

  Future<void> resendOtp() async {
    final currentState = state;
    if (currentState is! OtpIdle || !currentState.canResend) return;

    emit(const OtpResending());

    try {
      await onResend();
      emit(const OtpResent());
      startCountdown();
    } catch (e) {
      emit(OtpFailure(errorMessage: e.toString()));
      emit(currentState);
    }
  }

  @override
  Future<void> close() {
    _countdownTimer?.cancel();
    return super.close();
  }
}
