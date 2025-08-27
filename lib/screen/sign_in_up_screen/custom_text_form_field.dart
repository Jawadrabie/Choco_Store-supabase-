import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.label,
      required this.icon,
      this.obscureText = false,
      this.validator});

  final String label;
  final IconData icon;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText,
      cursorColor: const Color(0xFF160704),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF160704),
        ),
        labelText: '$label',
        labelStyle: const TextStyle(
          color: Color(0xFF160704),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(
            width: 1.6,
            color: Color(0xFF160704),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF160704),
          ),
        ),
      ),
    );
  }
}
