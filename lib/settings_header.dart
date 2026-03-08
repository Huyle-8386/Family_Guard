import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFCCEFF0),
      padding: const EdgeInsets.fromLTRB(20, 48, 20, 16),
      child: Text(
        'Cài đặt',
        style: GoogleFonts.inter(
          color: const Color(0xFF111818),
          fontSize: 34,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.85,
          height: 42.5 / 34,
        ),
      ),
    );
  }
}

class SettingsHeaderScreen extends StatelessWidget {
  const SettingsHeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      body: SafeArea(
        top: false,
        child: SettingsHeader(),
      ),
    );
  }
}
