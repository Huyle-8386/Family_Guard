// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:family_guard/core/widgets/app_bottom_menu.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordSecurityScreen extends StatelessWidget {
  const PasswordSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCCEFF0),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 39, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _TopHeader(),
                  SizedBox(height: 20),
                  _PasswordSection(),
                  SizedBox(height: 20),
                  _SecurityOptionsSection(),
                  SizedBox(height: 20),
                  _TrustedDevicesSection(),
                  SizedBox(height: 20),
                  _DeleteAccountCard(),
                  SizedBox(height: 16),
                ],
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AppBottomMenu(current: AppNavTab.settings),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopHeader extends StatelessWidget {
  const _TopHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => Navigator.maybePop(context),
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.chevron_left_rounded, size: 18, color: Color(0xFF17E8E8)),
                Text(
                  'Cài đặt',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF25E9E9),
                    fontSize: 30 / 1.666,
                    fontWeight: FontWeight.w500,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Mật khẩu & Bảo mật',
          style: GoogleFonts.inter(
            color: const Color(0xFF111818),
            fontSize: 48 / 1.4118,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.85,
            height: 1.25,
          ),
        ),
      ],
    );
  }
}

class _PasswordSection extends StatelessWidget {
  const _PasswordSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel('THAY ĐỔI MẬT KHẨU'),
        const SizedBox(height: 8),
        Container(
          decoration: _cardDecoration,
          child: Column(
            children: const [
              _PasswordRow(label: 'Hiện tại', value: '*********'),
              _DividerLine(),
              _PasswordRow(label: 'Mới', value: '*********'),
              _DividerLine(),
              _PasswordRow(label: 'Xác nhận', value: '*********'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Mật khẩu phải có ít nhất 8 ký tự và bao gồm cả số và ký hiệu.',
            style: GoogleFonts.inter(
              color: const Color(0xFF638888),
              fontSize: 13,
              fontWeight: FontWeight.w400,
              height: 17.88 / 13,
            ),
          ),
        ),
      ],
    );
  }
}

class _SecurityOptionsSection extends StatelessWidget {
  const _SecurityOptionsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel('TÙY CHỌN BẢO MẬT'),
        const SizedBox(height: 8),
        Container(
          decoration: _cardDecoration,
          child: Column(
            children: const [
              _SecurityOptionRow(label: 'Two-Factor Authentication', enabled: false),
              _DividerLine(),
              _SecurityOptionRow(label: 'Face ID Login', enabled: true),
              _DividerLine(),
              _SecurityOptionRow(label: 'Login Alerts', enabled: true),
            ],
          ),
        ),
      ],
    );
  }
}

class _TrustedDevicesSection extends StatelessWidget {
  const _TrustedDevicesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel('THIẾT BỊ TIN CẬY'),
        const SizedBox(height: 8),
        Container(
          decoration: _cardDecoration,
          child: Column(
            children: const [
              _TrustedDeviceRow(
                icon: Icons.smartphone_outlined,
                deviceName: 'iPhone 15 Pro',
                subtitle: 'Huế • Thiết bị hiện tại',
                subtitleColor: Color(0xFF1BD521),
              ),
              _DividerLine(),
              _TrustedDeviceRow(
                icon: Icons.laptop_mac_outlined,
                deviceName: 'MacBook Pro',
                subtitle: 'Huế • Hoạt động 2h trước',
                trailing: 'Đăng xuất',
                trailingColor: Color(0xFFFF0000),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DeleteAccountCard extends StatelessWidget {
  const _DeleteAccountCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _cardDecoration,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      alignment: Alignment.center,
      child: Text(
        'Xóa Tài Khoản',
        style: GoogleFonts.inter(
          color: const Color(0xFFEF4444),
          fontSize: 17,
          fontWeight: FontWeight.w500,
          height: 1.5,
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: const Color(0xFF638888).withValues(alpha: 0.8),
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.6,
          height: 1.3,
        ),
      ),
    );
  }
}

class _PasswordRow extends StatelessWidget {
  const _PasswordRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 11, 16, 13),
      child: Row(
        children: [
          SizedBox(
            width: 76,
            child: Text(
              label,
              style: GoogleFonts.inter(
                color: const Color(0xFF111818),
                fontSize: 17,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SecurityOptionRow extends StatelessWidget {
  const _SecurityOptionRow({required this.label, required this.enabled});

  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(
                color: const Color(0xFF111818),
                fontSize: 17,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          ),
          _StaticSwitch(enabled: enabled),
        ],
      ),
    );
  }
}

class _StaticSwitch extends StatelessWidget {
  const _StaticSwitch({required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return SizedBox(
        width: 48,
        height: 28,
        child: Stack(
          children: [
            Container(
              width: 48,
              height: 28,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            Positioned(
              left: 0,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF6B7280), width: 4),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return SizedBox(
      width: 48,
      height: 28,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 48,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFF2DD4BF),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          Positioned(
            right: -4,
            top: -4,
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0xFF2563EB),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.check_rounded, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _TrustedDeviceRow extends StatelessWidget {
  const _TrustedDeviceRow({
    required this.icon,
    required this.deviceName,
    required this.subtitle,
    this.subtitleColor = const Color(0xFF638888),
    this.trailing,
    this.trailingColor,
  });

  final IconData icon;
  final String deviceName;
  final String subtitle;
  final Color subtitleColor;
  final String? trailing;
  final Color? trailingColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 15, 16, 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F4F6),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 22, color: const Color(0xFF6B7280)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deviceName,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF111818),
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: subtitleColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null)
            Text(
              trailing!,
              style: GoogleFonts.inter(
                color: trailingColor ?? const Color(0xFFEF4444),
                fontSize: 15,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
        ],
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  const _DividerLine();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, thickness: 1, color: Color(0xFFF3F4F6));
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x3300ADB2),
            blurRadius: 30,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _NavItem(icon: Icons.groups_outlined, selected: false),
          _NavItem(icon: Icons.map_outlined, selected: false),
          _NavItem(icon: Icons.notifications_none, selected: false),
          _NavItem(icon: Icons.person, selected: true),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.icon, required this.selected});

  final IconData icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF00ACB1) : Colors.white,
        shape: BoxShape.circle,
        boxShadow: selected
            ? const [
                BoxShadow(
                  color: Color(0x6600ADB2),
                  blurRadius: 15,
                  offset: Offset(0, 6),
                ),
              ]
            : null,
      ),
      alignment: Alignment.center,
      child: Icon(
        icon,
        size: 24,
        color: selected ? const Color(0xFF002244) : const Color(0xFF9CA3AF),
      ),
    );
  }
}

const BoxDecoration _cardDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(24)),
  border: Border.fromBorderSide(BorderSide(color: Color(0xFFF3F4F6))),
  boxShadow: [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ],
);