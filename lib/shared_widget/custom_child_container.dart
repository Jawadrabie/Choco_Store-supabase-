import 'package:flutter/material.dart';

class CustomChildContainer extends StatelessWidget {
  const CustomChildContainer({super.key, required this.child, required this.width, required this.height, this.borderRadius});
final Widget child;
final double height;
final double width;
final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
        borderRadius: borderRadius??
        BorderRadius.circular(20),
    gradient: const LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
    Color(0xFFB69E99),
    Color(0xFFBD9882),
    ],
    ),
    ),
    child:child, );
  }
}
