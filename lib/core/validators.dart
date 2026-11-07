/// Reusable form validators. Each returns an error message or null if valid.
class Validators {
  static String? name(String? v) {
    final value = (v ?? '').trim();
    if (value.isEmpty) return 'Full name is required';
    if (value.length < 3) return 'Name must be at least 3 characters';
    if (!RegExp(r"^[a-zA-Z\s.]+$").hasMatch(value)) {
      return 'Name can contain only letters and spaces';
    }
    return null;
  }

  static String? email(String? v) {
    final value = (v ?? '').trim();
    if (value.isEmpty) return 'Email is required';
    if (!RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? password(String? v) {
    final value = v ?? '';
    if (value.isEmpty) return 'Password is required';
    if (value.length < 6) return 'Password must be at least 6 characters';
    if (!RegExp(r'[A-Za-z]').hasMatch(value) ||
        !RegExp(r'\d').hasMatch(value)) {
      return 'Use both letters and numbers';
    }
    return null;
  }

  static String? confirmPassword(String? v, String original) {
    if ((v ?? '').isEmpty) return 'Please confirm your password';
    if (v != original) return 'Passwords do not match';
    return null;
  }

  static String? message(String? v) {
    final value = (v ?? '').trim();
    if (value.isEmpty) return 'Message is required';
    if (value.length < 10) return 'Message must be at least 10 characters';
    return null;
  }

  static String? requiredField(String? v, String field) {
    if ((v ?? '').trim().isEmpty) return '$field is required';
    return null;
  }
}
