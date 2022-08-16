import 'package:http/http.dart' as http;

/// ### possible error codes are
///   * weak-password
///   * email-already-in-use
///   * user-not-found
///   * wrong-password
///   * done
///
/// #### Example:
///
/// ```dart
/// if (e.code == 'weak-password') {
///   print("The password provided is too weak");
/// } else if (e.code == 'email-already-in-use') {
///   print("This email has been already used");
/// }
/// ```
class FlaskbaseAuthException implements Exception {
  final String code;
  const FlaskbaseAuthException({required this.code});
}

class FlaskbaseAuth {
  const FlaskbaseAuth._();

  /// Get a new instance of [FlaskbaseAuth]
  static FlaskbaseAuth get instance => const FlaskbaseAuth._();

  /// Creates a user account on flask api using user's email address and
  /// password.
  ///
  /// Throws [FlaskbaseAuthException].
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final http.Response response = await http.post(
      // For emulator only
      Uri.parse("http://10.0.2.2:5000/signup"),
      body: <String, String>{
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      if (response.body == "done") {
        return;
      }
      throw FlaskbaseAuthException(code: response.body);
    } else {
      throw Exception("server error");
    }
  }

  /// Log in to accounts on flask api using user's email address and password.
  ///
  /// Throws [FlaskbaseAuthException].
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final http.Response response = await http.post(
      // For emulator only
      Uri.parse("http://10.0.2.2:5000/login"),
      body: <String, String>{
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      if (response.body == "done") {
        return;
      }
      throw FlaskbaseAuthException(code: response.body);
    } else {
      throw Exception("server error");
    }
  }
}
