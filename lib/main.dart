import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flask/theme.dart';
import 'package:flutter_flask/ui/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      title: 'Flutter Flask',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const LogInPage(),
    );
  }
}
