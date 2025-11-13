class Validators {
  Validators._();

  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  static bool isValidPhoneNumber(String phone) {
    final phoneRegex = RegExp(r'^\d{7,15}$');
    return phoneRegex.hasMatch(phone.replaceAll(RegExp(r'[\s\-\(\)]'), ''));
  }

  static bool isValidPassword(String password) {
    return password.length >= 6;
  }

  static bool passwordsMatch(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  static bool isValidOtp(String otp) {
    return otp.length == 4 && RegExp(r'^\d{4}$').hasMatch(otp);
  }

  static bool isValidName(String name) {
    return name.trim().length >= 2;
  }

  static bool isValidQuantity(int quantity) {
    return quantity > 0;
  }

  static bool isValidPrice(double price) {
    return price >= 0;
  }

  static bool isValidRating(double rating) {
    return rating >= 0 && rating <= 5;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!isValidPhoneNumber(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (!isValidPassword(value)) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (!isValidName(value)) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!isValidEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

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