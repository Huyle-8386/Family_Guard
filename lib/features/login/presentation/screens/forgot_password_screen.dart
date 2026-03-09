import 'package:family_guard/core/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quen mat khau'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tinh nang dang duoc cap nhat.',
              style: GoogleFonts.publicSans(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.login),
              child: const Text('Quay lai dang nhap'),
            ),
          ],
        ),
      ),
    );
  }
}
