import 'package:equatable/equatable.dart';

sealed class OtpVerificationState extends Equatable {
  const OtpVerificationState();

  @override
  List<Object?> get props => [];
}

class OtpVerificationInitial extends OtpVerificationState {
  const OtpVerificationInitial();
}

class OtpVerificationLoading extends OtpVerificationState {
  const OtpVerificationLoading();
}

class OtpVerificationSuccess extends OtpVerificationState {
  const OtpVerificationSuccess();
}

class OtpVerificationError extends OtpVerificationState {
  final String message;

  const OtpVerificationError({required this.message});

  @override
  List<Object?> get props => [message];
}

class OtpResendLoading extends OtpVerificationState {
  const OtpResendLoading();
}

class OtpResendSuccess extends OtpVerificationState {
  const OtpResendSuccess();
}

