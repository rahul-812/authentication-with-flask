import 'package:flutter/material.dart';

class AppearAnimation extends AnimatedWidget {
  const AppearAnimation({Key? key, required this.animation, this.child})
      : super(key: key, listenable: animation);

  final Animation<double> animation;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
            .animate(animation),
        child: child,
      ),
    );
  }
}

class SlideRouteAnimation extends PageRouteBuilder {
  final Widget page;
  final bool slideToLeft;

  SlideRouteAnimation({required this.page, this.slideToLeft = true})
      : super(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(
                Tween<Offset>(
                  begin: slideToLeft
                      ? const Offset(1.0, 0.0)
                      : const Offset(-1.0, 0.0),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.decelerate)),
              ),
              child: child,
            );
          },
        );
}
