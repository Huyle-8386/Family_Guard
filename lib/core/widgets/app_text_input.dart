import 'package:family_guard/core/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class AppTextInput extends StatelessWidget {
  const AppTextInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.suffix,
    this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      style: GoogleFonts.publicSans(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.publicSans(
          color: AppColors.textMuted,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        suffixIcon: suffix,
      ),
    );
  }
}
