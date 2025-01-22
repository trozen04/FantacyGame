import 'package:flutter/material.dart';

/// Helper function to navigate with slide transition
Future<void> navigateWithSlideTransition(
    BuildContext context,
    Widget page, {
      Offset begin = const Offset(1.0, 0.0), // Default: slide from right
      Offset end = Offset.zero, // Default: end at zero position
      Curve curve = Curves.easeInOut, // Default: easeInOut curve
    }) {
  return Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    ),
  );
}
