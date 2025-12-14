import '../../enums/validation_error_type.dart';

class ValidationResult {
  final bool isValid;
  final ValidationErrorType? errorType;

  const ValidationResult._({
    required this.isValid,
    this.errorType,
  });

  const ValidationResult.valid() : this._(isValid: true);

  const ValidationResult.invalid(ValidationErrorType error)
      : this._(isValid: false, errorType: error);

  factory ValidationResult.fromCondition(
      bool condition,
      ValidationErrorType errorType,
      ) {
    return condition
        ? const ValidationResult.valid()
        : ValidationResult.invalid(errorType);
  }
}