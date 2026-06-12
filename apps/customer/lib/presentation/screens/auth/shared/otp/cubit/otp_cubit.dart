import 'dart:async';
import 'package:core/error/result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sellio_mobile/domain/repositories/auth_repository.dart';
import 'package:sellio_mobile/presentation/screens/auth/shared/constants/auth_constants.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final Future<Result<void>> Function(String otp) onVerify;
  final int otpLength;
  final int countdownDuration;
  Timer? _countdownTimer;
  final AuthRepository _authRepository;

  int _liveCountdown = 0;
  bool _liveCanResend = false;

  OtpCubit({
    required this.onVerify,
    this.otpLength = 4,
    this.countdownDuration = AuthConstants.otpResendCountdown,
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const OtpIdle()) {
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

    _liveCountdown = countdownDuration;
    _liveCanResend = false;

    final currentState = state;
    final idleState = currentState is OtpIdle ? currentState : const OtpIdle();
    emit(idleState.copyWith(
      countdown: _liveCountdown,
      canResend: false,
      otpValue: '',
      isComplete: false,
    ));

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _liveCountdown--;
      _liveCanResend = _liveCountdown <= 0;

      if (_liveCountdown <= 0) {
        timer.cancel();
      }

      final current = state;
      if (current is OtpIdle) {
        emit(current.copyWith(
          countdown: _liveCountdown.clamp(0, countdownDuration),
          canResend: _liveCanResend,
        ));
      }
    });
  }

  Future<void> verifyOtp() async {
    final currentState = state;
    if (currentState is! OtpIdle || !currentState.isComplete) return;

    final otp = currentState.otpValue;
    emit(const OtpVerifying());

    final result = await onVerify(otp);

    result.fold(
      onSuccess: (message) {
        emit(const OtpVerified());
      },
      onFailure: (failure) {
        emit(OtpFailure(errorMessage: failure.message));
        emit(currentState.copyWith(
          countdown: _liveCountdown.clamp(0, countdownDuration),
          canResend: _liveCanResend,
        ));
      },
    );
  }

  Future<void> resendOtp() async {
    final currentState = state;
    if (currentState is! OtpIdle || !currentState.canResend) return;
    final result = await _authRepository.resendOtp();

    result.fold(
      onSuccess: (message) {
        emit(OtpResent(message: message));
        startCountdown();
      },
      onFailure: (failure) {
        emit(OtpFailure(errorMessage: failure.message));
      },
    );
  }

  @override
  Future<void> close() {
    _countdownTimer?.cancel();

    return super.close();
  }
}
