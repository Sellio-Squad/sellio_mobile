import 'package:equatable/equatable.dart';

class ResetPasswordState extends Equatable {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  bool get isFormValid =>
      currentPassword.isNotEmpty &&
      newPassword.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      newPassword == confirmPassword &&
      newPassword.length >= 8 &&
      currentPassword != newPassword;

  bool get passwordsMatch => newPassword == confirmPassword;

  bool get isNewPasswordValid => newPassword.length >= 8;

  const ResetPasswordState({
    this.currentPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  ResetPasswordState copyWith({
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return ResetPasswordState(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    currentPassword,
    newPassword,
    confirmPassword,
        isLoading,
        isSuccess,
        errorMessage,
      ];
}
