import 'package:flutter/material.dart';
import 'package:flutter_flask/animations.dart';
import 'package:flutter_flask/auth_methods.dart';
import 'package:flutter_flask/constants.dart' show scaffoldPadding;
import 'package:flutter_flask/ui/signup_page.dart';
import 'package:flutter_flask/widgets.dart';
import 'package:flutter_flask/ui/home_page.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LogInPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  Future<void>? _waitForFuture;
  var _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  String? _errorText;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void _togglePasswordVisibility() =>
      setState(() => _passwordVisible = !_passwordVisible);

  String? _emailFormFieldValidator(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter your email address";
    } else if (_errorText == "user-not-found") {
      _errorText = null;
      return "No user found for this email address";
    }
    return null;
  }

  String? _passwordFormFieldValidator(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter your email address";
    } else if (text.length < 8) {
      return "Must contain atleast 8 characters";
    } else if (_errorText == "wrong-password") {
      _errorText = null;
      return "Please check the password and try again";
    }
    return null;
  }

  Future<void> _login(BuildContext context) async {
    _errorText = await AuthMethods.signIn(
      _emailController.text,
      _passwordController.text,
    );
    if (_formKey.currentState!.validate()) {
      if (!mounted) {
        return;
      }
      Navigator.of(context).pushAndRemoveUntil(
        SlideRouteAnimation(page: const HomePage()),
        (Route<dynamic> rout) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: scaffoldPadding),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FlutterLogo(size: 100),
                const SizedBox(height: 40),
                EmailTextField(
                  controller: _emailController,
                  validator: _emailFormFieldValidator,
                ),
                const SizedBox(height: 20),
                PasswordTextField(
                  controller: _passwordController,
                  onTapSuffix: _togglePasswordVisibility,
                  visible: _passwordVisible,
                  validator: _passwordFormFieldValidator,
                ),
                const SizedBox(height: 40),
                AppButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _waitForFuture = _login(context);
                      });
                    }
                  },
                  child: FutureBuilder(
                    future: _waitForFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      return const Text(
                        "LOG IN",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Footer(
                  suggestion: "Don't have an account?",
                  action: "Create account",
                  onAction: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      SlideRouteAnimation(page: const SignUpPage()),
                      (Route<dynamic> rout) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
