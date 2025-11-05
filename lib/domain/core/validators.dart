class Validators {
  Validators._();

  /// Validate email address
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Validate phone number (basic validation)
  static bool isValidPhoneNumber(String phone) {
    final phoneRegex = RegExp(r'^\d{7,15}$');
    return phoneRegex.hasMatch(phone.replaceAll(RegExp(r'[\s\-\(\)]'), ''));
  }

  /// Validate password strength
  static bool isValidPassword(String password) {
    // At least 6 characters
    return password.length >= 6;
  }

  /// Validate password match
  static bool passwordsMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  /// Validate OTP code
  static bool isValidOtp(String otp) {
    return otp.length == 4 && RegExp(r'^\d{4}$').hasMatch(otp);
  }

  /// Validate name
  static bool isValidName(String name) {
    return name.trim().length >= 2;
  }

  /// Validate quantity
  static bool isValidQuantity(int quantity) {
    return quantity > 0;
  }

  /// Validate price
  static bool isValidPrice(double price) {
    return price >= 0;
  }

  /// Validate rating
  static bool isValidRating(double rating) {
    return rating >= 0 && rating <= 5;
  }

  /// Get validation error message for phone
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!isValidPhoneNumber(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  /// Get validation error message for password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (!isValidPassword(value)) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Get validation error message for name
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (!isValidName(value)) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  /// Get validation error message for email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!isValidEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  /// Get validation error message for OTP
  static String? validateOtp(String? value) {
    if (value == null || value.isEmpty) {
      return 'OTP is required';
    }
    if (!isValidOtp(value)) {
      return 'OTP must be 4 digits';
    }
    return null;
  }
}