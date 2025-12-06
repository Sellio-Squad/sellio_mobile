import 'package:equatable/equatable.dart';

class ResetPasswordState extends Equatable {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  bool get isFormValid =>
      newPassword.isNotEmpty &&
          confirmPassword.isNotEmpty &&
          newPassword == confirmPassword;

  const ResetPasswordState({
    this.currentPassword = '',
    this.newPassword = '',
    this.confirmPassword = '',
  });

  ResetPasswordState copyWith({
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,
  }) {
    return ResetPasswordState(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  List<Object?> get props => [
    currentPassword,
    newPassword,
    confirmPassword,
  ];
}
