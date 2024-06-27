// ignore: file_names
// ignore: file_names
// ignore: file_names
class RegexInput {
  static const String emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String passwordPattern =
      r'^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{7,}$';

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    RegExp regex = RegExp(emailPattern);
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static bool hasUpperCase(String value) => value.contains(RegExp(r'[A-Z]'));
  static bool hasDigit(String value) => value.contains(RegExp(r'\d'));
  static bool hasSpecialCharacter(String value) => value.contains(RegExp(r'[@$!%*?&]'));
  static bool hasMinLength(String value) => value.length >= 7;

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (!hasUpperCase(value)) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!hasDigit(value)) {
      return 'Password must contain at least one number';
    }
    if (!hasSpecialCharacter(value)) {
      return 'Password must contain at least one special character';
    }
    if (!hasMinLength(value)) {
      return 'Password must be at least 7 characters long';
    }
    return null;
  }
}
