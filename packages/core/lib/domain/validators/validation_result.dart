import 'validation_error.dart';

class ValidationResult {
  final bool isValid;
  final ValidationError? error;

  const ValidationResult._({
    required this.isValid,
    this.error,
  });

  const ValidationResult.valid() : this._(isValid: true);

  const ValidationResult.invalid(ValidationError error)
      : this._(isValid: false, error: error);

  factory ValidationResult.fromCondition(
    bool condition,
    ValidationError errorType,
  ) {
    return condition
        ? const ValidationResult.valid()
        : ValidationResult.invalid(errorType);
  }
}
