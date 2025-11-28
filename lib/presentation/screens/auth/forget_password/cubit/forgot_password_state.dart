import 'package:equatable/equatable.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object?> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class ForgotPasswordOtpSent extends ForgotPasswordState {
  final String sessionId;
  final String phoneNumber;
  final String defaultRegion;

  const ForgotPasswordOtpSent({
    required this.sessionId,
    required this.phoneNumber,
    required this.defaultRegion,
  });

  @override
  List<Object?> get props => [sessionId, phoneNumber, defaultRegion];
}

class ForgotPasswordOtpVerified extends ForgotPasswordState {
  final String sessionId;

  const ForgotPasswordOtpVerified({required this.sessionId});

  @override
  List<Object?> get props => [sessionId];
}

class ForgotPasswordSuccess extends ForgotPasswordState {}

class ForgotPasswordFailure extends ForgotPasswordState {
  final String message;

  const ForgotPasswordFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
