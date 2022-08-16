import 'package:flutter_flask/flaskbase_auth/flaskbase_auth.dart';

class AuthMethods {
  static Future<String?> createAccount(String email, String password) async {
    try {
      await FlaskbaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FlaskbaseAuthException catch (e) {
      if (e.code == "done") {
        return null;
      }
      return e.code;
    }
    return null;
  }

  static Future<String?> signIn(String email, String password) async {
    try {
      await FlaskbaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FlaskbaseAuthException catch (e) {
      if (e.code == "done") {
        return null;
      }
      return e.code;
    }
    return null;
  }
}
