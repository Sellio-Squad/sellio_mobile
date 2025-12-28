enum ValidationErrorType {
  // Phone errors
  phoneMinLength,
  phoneDigitsOnly,

  // Password errors
  passwordMinLength,
  passwordMaxLength,
  passwordsDoNotMatch,

  // First Name errors
  firstNameMinLength,
  firstNameLettersOnly,

  // Last Name errors
  lastNameMinLength,
  lastNameLettersOnly,

  // Email errors
  emailEmpty,
  emailInvalid,

  // City errors
  cityMinLength,
  cityLettersOnly,
}