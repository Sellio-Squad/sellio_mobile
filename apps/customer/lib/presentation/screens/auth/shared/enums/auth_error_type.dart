enum AuthErrorType {
  // Login errors
  loginFailed,

  // Account creation errors
  accountCreationFailed,

  // OTP errors
  otpVerificationFailed,
  otpExpired,
  otpInvalid,

  // Password reset errors
  passwordResetFailed,
  invalidResetToken,

  // General errors
  networkError,
  unknownError,
}
