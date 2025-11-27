class Validators {
  // Phone number validation with country-specific rules
  static String? phoneNumber(String? value, {String? countryCode}) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // Remove common formatting characters
    final cleaned = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    // Check if it contains only digits
    if (!RegExp(r'^[0-9]+$').hasMatch(cleaned)) {
      return 'Phone number must contain only digits';
    }

    // Country-specific validation
    if (countryCode == '+20' || countryCode == 'EG') {
      // Egypt: 10-11 digits
      if (cleaned.length < 10) {
        return 'Egyptian phone number must be at least 10 digits';
      }
    } else if (countryCode == '+964' || countryCode == 'IQ') {
      // Iraq: 10 digits
      if (cleaned.length < 9) {
        return 'Iraqi phone number must be at least 9 digits';
      }
    }
    return null;
  }

  // Full name validation
  static String? fullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }

    final trimmed = value.trim();

    if (trimmed.length < 2) {
      return 'Full name must be at least 2 characters';
    }

    // Allow letters, spaces, and common name characters (hyphens, apostrophes)
    // Also support Arabic and other Unicode letters
    if (!RegExp(r"^[\p{L}\s'\-]+$", unicode: true).hasMatch(trimmed)) {
      return 'Full name must contain only letters and spaces';
    }

    return null;
  }

  // Country validation
  static String? country(String? value) {
    if (value == null || value.isEmpty) {
      return 'Country is required';
    }

    final trimmed = value.trim();

    if (trimmed.length < 3) {
      return 'Country must be at least 3 characters';
    }

    // Support Unicode letters for international country names
    if (!RegExp(r'^[\p{L}\s]+$', unicode: true).hasMatch(trimmed)) {
      return 'Country must contain only letters and spaces';
    }

    return null;
  }

  // City validation
  static String? city(String? value) {
    if (value == null || value.isEmpty) {
      return 'City is required';
    }

    final trimmed = value.trim();

    if (trimmed.length < 2) {
      return 'City must be at least 2 characters';
    }

    // Support Unicode letters for international city names
    if (!RegExp(r'^[\p{L}\s]+$', unicode: true).hasMatch(trimmed)) {
      return 'City must contain only letters and spaces';
    }

    return null;
  }

  // Password validation
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    if (value.length > 20) {
      return 'Password must be less than 20 characters';
    }

    return null;
  }

  // Confirm password validation
  static String? confirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }

  // Email validation (bonus - you might need it later)
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final trimmed = value.trim();

    if (!RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,}$').hasMatch(trimmed)) {
      return 'Enter a valid email address';
    }

    return null;
  }
}