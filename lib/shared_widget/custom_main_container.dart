import 'package:flutter/material.dart';

class CustomMainContainer extends StatelessWidget {
   CustomMainContainer({super.key, required this.child});
   final Widget child;
  @override
  Widget build(BuildContext context) {
    return  Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
        Color(0xFF995D39),
    Color(0xFF917665),
    ],
    ),
    ),
    child: child,
    );
  }
}
