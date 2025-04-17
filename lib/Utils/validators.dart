class Validators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) return 'Enter your full name';
    return null;
  }

  static String? validateContact(String? value) {
    if (value == null || value.isEmpty) return 'Enter contact number';
    if (!RegExp(r'^\d{10,15}$').hasMatch(value)) return 'Invalid contact number';
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Enter email';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Invalid email';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.length < 6) return 'Min 6 characters';
    return null;
  }

  static String? validateConfirmPassword(String? value, String original) {
    if (value == null || value != original) return 'Passwords do not match';
    return null;
  }
}
