// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:family_guard/core/widgets/app_bottom_menu.dart';
import 'package:family_guard/core/widgets/display/app_avatar.dart';
import 'package:family_guard/core/widgets/feedback/app_status_badge.dart';
import 'package:family_guard/core/widgets/layout/app_card_container.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberManagementScreen extends StatelessWidget {
  const MemberManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const members = [
      _MemberData(
        name: 'Trần Như Kha',
        relation: 'Tôi',
        role: 'NGƯỜI LỚN',
        status: 'Đã kết nối',
        avatarUrl: 'http://localhost:3845/assets/1c0749829b2a72faa4f3c548497e23d845e5d5c7.png',
        avatarBorder: Color(0xFFF3F4F6),
      ),
      _MemberData(
        name: 'Bố Xôi',
        relation: 'Vợ/ Chồng',
        role: 'NGƯỜI LỚN',
        status: 'Đã kết nối',
        avatarUrl: 'http://localhost:3845/assets/b4324a486844b9955c07fc89cbdb5a4969aada9f.png',
      ),
      _MemberData(
        name: 'Xôi',
        relation: 'Con',
        role: 'TRẺ EM',
        status: 'Đã kết nối',
        initials: 'L',
        avatarBg: Color(0xFFDBEAFE),
        avatarText: Color(0xFF2563EB),
      ),
      _MemberData(
        name: 'Suri',
        relation: 'Con',
        role: 'TRẺ EM',
        status: 'Đã gửi lời mời',
        initials: 'S',
        avatarBg: Color(0xFFF3E8FF),
        avatarText: Color(0xFF9333EA),
      ),
      _MemberData(
        name: 'Bà nội',
        relation: 'Mẹ',
        role: 'NGƯỜI GIÀ',
        status: 'Đã kết nối',
        initials: 'M',
        avatarBg: Color(0xFFFFEDD5),
        avatarText: Color(0xFFEA580C),
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFCCEFF0),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 32, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _TopHeader(),
                  const SizedBox(height: 16),
                  const _AddMemberButton(),
                  const SizedBox(height: 16),
                  ...members.map(
                    (member) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _MemberCard(member: member),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    children: [
                      Expanded(
                        child: _ShortcutCard(
                          icon: Icons.mail_outline_rounded,
                          label: 'Mời bằng email',
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _ShortcutCard(
                          icon: Icons.qr_code_2_rounded,
                          label: 'Quét mã QR',
                        ),
                      ),
                    ],
                  ),
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
                    color: const Color(0xFF17E8E8),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    height: 28 / 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Quản Lí Thành Viên',
          style: GoogleFonts.inter(
            color: const Color(0xFF111818),
            fontSize: 34,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.85,
            height: 42.5 / 34,
          ),
        ),
      ],
    );
  }
}

class _AddMemberButton extends StatelessWidget {
  const _AddMemberButton();

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 13, 14, 14),
      backgroundColor: const Color(0xFF17E8E8),
      borderRadius: 24,
      boxShadow: const [
        BoxShadow(color: Color(0x0D000000), blurRadius: 2, offset: Offset(0, 1)),
      ],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add_circle_outline_rounded, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(
            'Thêm thành viên',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
              height: 25.5 / 17,
            ),
          ),
        ],
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({required this.member});

  final _MemberData member;

  @override
  Widget build(BuildContext context) {
    final pending = member.status == 'Đã gửi lời mời';

    return AppCardContainer(
      padding: const EdgeInsets.all(17),
      backgroundColor: Colors.white,
      borderRadius: 24,
      borderColor: const Color(0xFFF3F4F6),
      boxShadow: const [
        BoxShadow(color: Color(0x0D000000), blurRadius: 2, offset: Offset(0, 1)),
      ],
      child: Row(
        children: [
          _Avatar(member: member),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        member.name,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF111818),
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          height: 25.5 / 17,
                        ),
                      ),
                    ),
                    AppStatusBadge(
                      label: member.role,
                      type: AppStatusBadgeType.info,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      borderRadius: 999,
                      backgroundColor: const Color(0x1A17E8E8),
                      foregroundColor: const Color(0xFF0EA5A5),
                      borderColor: null,
                      textStyle: GoogleFonts.inter(
                        color: const Color(0xFF0EA5A5),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.275,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      member.relation,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF6B7280),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 20 / 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const _Dot(),
                    const SizedBox(width: 8),
                    AppStatusBadge(
                      label: member.status,
                      type: pending ? AppStatusBadgeType.neutral : AppStatusBadgeType.success,
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      borderRadius: 16,
                      backgroundColor: pending ? const Color(0xFFF3F4F6) : const Color(0xFFECFDF5),
                      foregroundColor: pending ? const Color(0xFF6B7280) : const Color(0xFF10B981),
                      borderColor: null,
                      textStyle: GoogleFonts.inter(
                        color: pending ? const Color(0xFF6B7280) : const Color(0xFF10B981),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 16 / 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right_rounded, color: Color(0xFFD1D5DB), size: 20),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.member});

  final _MemberData member;

  @override
  Widget build(BuildContext context) {
    if (member.avatarUrl != null) {
      return AppAvatar(
        size: 56,
        imageUrl: member.avatarUrl,
        border: Border.fromBorderSide(BorderSide(color: Color(0xFFF3F4F6))),
      );
    }

    return AppAvatar(
      size: 56,
      initials: member.initials,
      backgroundColor: member.avatarBg,
      textColor: member.avatarText,
      border: Border.fromBorderSide(BorderSide(color: member.avatarBorder)),
    );
  }
}

class _ShortcutCard extends StatelessWidget {
  const _ShortcutCard({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
      padding: const EdgeInsets.fromLTRB(16, 17, 16, 17),
      backgroundColor: Colors.white,
      borderRadius: 24,
      borderColor: const Color(0xFFF3F4F6),
      boxShadow: const [
        BoxShadow(color: Color(0x0D000000), blurRadius: 2, offset: Offset(0, 1)),
      ],
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0x1A17E8E8),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: const Color(0xFF00ACB1), size: 20),
          ),
          const SizedBox(height: 7),
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF111818),
              fontSize: 13,
              fontWeight: FontWeight.w600,
              height: 19.5 / 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: 4,
      decoration: const BoxDecoration(color: Color(0xFFD1D5DB), shape: BoxShape.circle),
    );
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
          _NavItem(icon: Icons.groups_outlined),
          _NavItem(icon: Icons.map_outlined),
          _NavItem(icon: Icons.notifications_none),
          _NavItem(icon: Icons.person, selected: true),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.icon, this.selected = false});

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

class _MemberData {
  const _MemberData({
    required this.name,
    required this.relation,
    required this.role,
    required this.status,
    this.avatarUrl,
    this.initials,
    this.avatarBg = const Color(0xFFE5E7EB),
    this.avatarText = const Color(0xFF6B7280),
    this.avatarBorder = const Color(0xFFF3F4F6),
  });

  final String name;
  final String relation;
  final String role;
  final String status;
  final String? avatarUrl;
  final String? initials;
  final Color avatarBg;
  final Color avatarText;
  final Color avatarBorder;
}