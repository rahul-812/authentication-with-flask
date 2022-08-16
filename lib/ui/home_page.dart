import 'package:flutter/material.dart';
import 'package:flutter_flask/animations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    final animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.decelerate,
    );

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Authentication Using Flask")),
      body: AppearAnimation(
          animation: _animation,
          child: const Center(child: FlutterLogo(size: 300))),
    );
  }
}
