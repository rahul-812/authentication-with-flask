import 'package:flutter/material.dart';
import 'package:flutter_flask/animations.dart';
import 'package:flutter_flask/auth_methods.dart';
import 'package:flutter_flask/constants.dart' show scaffoldPadding;
import 'package:flutter_flask/ui/home_page.dart';
import 'package:flutter_flask/ui/login_page.dart';
import 'package:flutter_flask/widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignUpPage> {
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
    } else if (_errorText == "email-already-in-use") {
      _errorText = null;
      return "This email is already in use";
    }
    return null;
  }

  String? _passwordFormFieldValidator(String? text) {
    if (text == null || text.isEmpty) {
      return "Please enter your email address";
    } else if (text.length < 8) {
      return "Must contain atleast 8 characters";
    } else if (_errorText == "weak-password") {
      _errorText = null;
      return "Too weak, use characters & symbols e.g. /&#%#@";
    }
    return null;
  }

  Future<void> _createAccount(BuildContext context) async {
    _errorText = await AuthMethods.createAccount(
      _emailController.text,
      _passwordController.text,
    );
    if (_formKey.currentState!.validate()) {
      if (!mounted) {
        return;
      }
      Navigator.of(context).pushAndRemoveUntil(
        SlideRouteAnimation(page: const HomePage(), slideToLeft: false),
        (Route<dynamic> route) => false,
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
                        _waitForFuture = _createAccount(context);
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
                        "SIGN UP",
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
                  suggestion: "Already have an account?",
                  action: "Log In",
                  onAction: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      SlideRouteAnimation(
                        page: const LogInPage(),
                        slideToLeft: false,
                      ),
                      (Route<dynamic> route) => false,
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
