import 'package:equatable/equatable.dart';

sealed class OtpState extends Equatable {
  const OtpState();
}

class OtpIdle extends OtpState {
  final String otpValue;
  final bool isComplete;
  final int countdown;
  final bool canResend;

  const OtpIdle({
    this.otpValue = '',
    this.isComplete = false,
    this.countdown = 0,
    this.canResend = true,
  });

  OtpIdle copyWith({
    String? otpValue,
    bool? isComplete,
    int? countdown,
    bool? canResend,
  }) {
    return OtpIdle(
      otpValue: otpValue ?? this.otpValue,
      isComplete: isComplete ?? this.isComplete,
      countdown: countdown ?? this.countdown,
      canResend: canResend ?? this.canResend,
    );
  }

  @override
  List<Object?> get props => [
        otpValue,
        isComplete,
        countdown,
        canResend,
      ];
}

class OtpVerifying extends OtpState {
  const OtpVerifying();

  @override
  List<Object?> get props => [];
}

class OtpVerified extends OtpState {
  const OtpVerified();

  @override
  List<Object> get props => [];
}

class OtpFailure extends OtpState {
  final String? errorMessage;

  const OtpFailure({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class OtpResending extends OtpState {
  const OtpResending();

  @override
  List<Object?> get props => [];
}

class OtpResent extends OtpState {
  final String? message;

  const OtpResent({this.message});

  @override
  List<Object?> get props => [message];
}