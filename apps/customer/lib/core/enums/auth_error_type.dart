enum AuthErrorType {
  // Login errors
  loginFailed,

  // Account creation errors
  accountCreationFailed,

  // OTP errors (for future use)
  otpVerificationFailed,
  otpExpired,
  otpInvalid,

  // Password reset errors (for future use)
  passwordResetFailed,
  invalidResetToken,

  // General errors
  networkError,
  unknownError,
}
