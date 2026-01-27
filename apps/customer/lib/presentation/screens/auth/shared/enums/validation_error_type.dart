enum ValidationErrorType {
  // Phone errors
  phoneMinLength,
  phoneDigitsOnly,

  // Password errors
  passwordMinLength,
  passwordMaxLength,
  passwordsDoNotMatch,

  // First Name errors
  fullNameMinLength,
  fullNameLettersOnly,


  // Email errors
  emailEmpty,
  emailInvalid,

  // City errors
  cityMinLength,
  cityLettersOnly,
}