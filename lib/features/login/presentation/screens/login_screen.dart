import 'package:flutter/material.dart';
import 'package:family_guard/core/constants/app_colors.dart';
import 'package:family_guard/core/constants/app_routes.dart';
import 'package:family_guard/core/widgets/buttons/app_button.dart';
import 'package:family_guard/core/widgets/display/app_field_label.dart';
import 'package:family_guard/core/widgets/inputs/app_text_input.dart';
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
    return Scaffold(
      backgroundColor: AppColors.background,
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
                        color: AppColors.brand,
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
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: AppFieldLabel(text: 'Email'),
                        ),
                        const SizedBox(height: 8),
                        AppTextInput(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: Validators.email,
                          borderRadius: 8,
                          fillColor: AppColors.background,
                          enabledBorderColor: AppColors.borderDark,
                          focusedBorderColor: AppColors.borderDark,
                        ),
                        const SizedBox(height: 20),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: AppFieldLabel(text: 'Mật khẩu'),
                        ),
                        const SizedBox(height: 8),
                        AppTextInput(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          validator: Validators.password,
                          borderRadius: 8,
                          fillColor: AppColors.background,
                          enabledBorderColor: AppColors.borderDark,
                          focusedBorderColor: AppColors.borderDark,
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
                                color: AppColors.primary,
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
                AppPrimaryButton(
                  label: 'Đăng nhập',
                  onPressed: _handleLogin,
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    const Expanded(child: Divider(color: AppColors.divider, thickness: 1)),
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
                    const Expanded(child: Divider(color: AppColors.divider, thickness: 1)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.divider),
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
                            color: AppColors.borderDark,
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
                          side: const BorderSide(color: AppColors.divider),
                          minimumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.apple, color: AppColors.borderDark, size: 16),
                        label: Text(
                          'Apple',
                          style: GoogleFonts.publicSans(
                            color: AppColors.borderDark,
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
                        color: AppColors.textMuted,
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
                          color: AppColors.primary,
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
