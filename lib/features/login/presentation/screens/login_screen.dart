import 'package:flutter/material.dart';
import 'package:family_guard/core/constants/app_routes.dart';
import 'package:family_guard/core/utils/validators.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  void _goToSignup() {
    Navigator.pushNamed(context, AppRoutes.signup);
  }

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFFF5F8F8);
    const brandColor = Color(0xFF0E8C8F);
    const actionColor = Color(0xFF00ADB2);
    const borderColor = Color(0xFF0F172A);
    const textMuted = Color(0xFF475569);
    const lineColor = Color(0xFFE2E8F0);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 32),
                Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 160,
                      height: 160,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Family Guard',
                      style: GoogleFonts.beVietnamPro(
                        color: brandColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.75,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _Label(text: 'Email'),
                        const SizedBox(height: 8),
                        _InputField(
                          controller: _emailController,
                          obscureText: false,
                          borderColor: borderColor,
                          backgroundColor: bgColor,
                          keyboardType: TextInputType.emailAddress,
                          validator: Validators.email,
                        ),
                        const SizedBox(height: 20),
                        _Label(text: 'Mật khẩu'),
                        const SizedBox(height: 8),
                        _InputField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          borderColor: borderColor,
                          backgroundColor: bgColor,
                          validator: Validators.password,
                          suffix: IconButton(
                            onPressed: () {
                              setState(() => _obscurePassword = !_obscurePassword);
                            },
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.black,
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => Navigator.pushNamed(context, AppRoutes.forgotPassword),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 20),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Quên mật khẩu?',
                              style: GoogleFonts.publicSans(
                                color: actionColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 20 / 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: actionColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      shadowColor: const Color(0x3300ADB2),
                    ),
                    child: Text(
                      'Đăng nhập',
                      style: GoogleFonts.publicSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 24 / 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    const Expanded(child: Divider(color: lineColor, thickness: 1)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Tiếp tục với',
                        style: GoogleFonts.publicSans(
                          color: const Color(0xFF94A3B8),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 20 / 14,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider(color: lineColor, thickness: 1)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: lineColor),
                          minimumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: Text(
                          'G',
                          style: GoogleFonts.publicSans(
                            color: const Color(0xFFEA4335),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        label: Text(
                          'Google',
                          style: GoogleFonts.publicSans(
                            color: borderColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 20 / 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: lineColor),
                          minimumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.apple, color: borderColor, size: 16),
                        label: Text(
                          'Apple',
                          style: GoogleFonts.publicSans(
                            color: borderColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 20 / 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bạn chưa có tài khoản? ',
                      style: GoogleFonts.publicSans(
                        color: textMuted,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 20 / 14,
                      ),
                    ),
                    TextButton(
                      onPressed: _goToSignup,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 20),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Đăng ký',
                        style: GoogleFonts.publicSans(
                          color: actionColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          height: 20 / 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: GoogleFonts.publicSans(
          color: const Color(0xFF0F172A),
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 24 / 16,
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.controller,
    required this.obscureText,
    required this.borderColor,
    required this.backgroundColor,
    this.keyboardType,
    this.suffix,
    this.validator,
  });

  final TextEditingController controller;
  final bool obscureText;
  final Color borderColor;
  final Color backgroundColor;
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
        filled: true,
        fillColor: backgroundColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: borderColor),
        ),
        suffixIcon: suffix,
      ),
    );
  }
}
