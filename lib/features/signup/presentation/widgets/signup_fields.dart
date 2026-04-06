import 'package:flutter/material.dart';
import 'package:family_guard/core/widgets/display/app_field_label.dart';
import 'package:family_guard/core/widgets/inputs/app_text_input.dart';

class SignupLabel extends StatelessWidget {
  const SignupLabel({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AppFieldLabel(
      text: text,
      fontSize: 16.5,
      fontWeight: FontWeight.w700,
    );
  }
}

class SignupTextField extends StatelessWidget {
  const SignupTextField({
    super.key,
    required this.hint,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.validator,
    this.onChanged,
    this.autovalidateMode,
    this.trailing,
  });

  final String hint;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final AutovalidateMode? autovalidateMode;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return AppTextInput(
      controller: controller,
      hintText: hint,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      onTap: onTap,
      validator: validator,
      onChanged: onChanged,
      autovalidateMode: autovalidateMode,
      borderRadius: 14,
      fillColor: const Color(0xFFF8FBFC),
      enabledBorderColor: const Color(0xFFB2E9EE),
      focusedBorderColor: const Color(0xFF07A9B0),
      errorBorderColor: const Color(0xFFFF2D2D),
      suffix: trailing,
      errorStyle: const TextStyle(
        color: Color(0xFFFF2D2D),
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),
    );
  }
}
