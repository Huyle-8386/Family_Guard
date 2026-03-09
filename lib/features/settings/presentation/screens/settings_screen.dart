// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:family_guard/core/constants/app_routes.dart';
import 'package:family_guard/core/widgets/app_bottom_menu.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCCEFF0),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const _SettingsHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 96),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        _ProfileCard(),
                        SizedBox(height: 24),
                        _SectionBlock(
                          title: 'Tài khoản',
                          items: [
                            _MenuItemData(
                              icon: Icons.person_outline,
                              iconBg: Color(0xFFEFF6FF),
                              iconColor: Color(0xFF2563EB),
                              label: 'Thông tin cá nhân',
                              routeName: AppRoutes.profile,
                            ),
                            _MenuItemData(
                              icon: Icons.lock_outline,
                              iconBg: Color(0xFFEEF2FF),
                              iconColor: Color(0xFF4F46E5),
                              label: 'Mật khẩu & Bảo mật',
                              routeName: AppRoutes.passwordSecurity,
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        _SectionBlock(
                          title: 'Gia đình',
                          items: [
                            _MenuItemData(
                              icon: Icons.groups_2_outlined,
                              iconBg: Color(0x3317E8E8),
                              iconColor: Color(0xFF00ACB1),
                              label: 'Quản Lí Thành Viên',
                              routeName: AppRoutes.memberList,
                            ),
                            _MenuItemData(
                              icon: Icons.location_on_outlined,
                              iconBg: Color(0xFFECFDF5),
                              iconColor: Color(0xFF16A34A),
                              label: 'Vùng An Toàn',
                              routeName: AppRoutes.safeZone,
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        _SectionBlock(
                          title: 'Tùy chọn',
                          items: [
                            _MenuItemData(
                              icon: Icons.notifications_none,
                              iconBg: Color(0xFFFFF7ED),
                              iconColor: Color(0xFFEA580C),
                              label: 'Thông Báo',
                              routeName: AppRoutes.notifications,
                            ),
                            _MenuItemData(
                              icon: Icons.palette_outlined,
                              iconBg: Color(0xFFFAF5FF),
                              iconColor: Color(0xFF9333EA),
                              label: 'Màu Sắc Ứng Dụng',
                              routeName: AppRoutes.settings,
                            ),
                            _MenuItemData(
                              icon: Icons.shield_outlined,
                              iconBg: Color(0xFFF3F4F6),
                              iconColor: Color(0xFF6B7280),
                              label: 'An Toàn',
                              routeName: AppRoutes.priorityContacts,
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        _LogoutButton(),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
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

class _SettingsHeader extends StatelessWidget {
  const _SettingsHeader();

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

class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=300&q=80',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 1,
                bottom: 1,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Là Khôn',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF111818),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                Text(
                  'lakhon.vcl@email.com',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF638888),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xFFF9FAFB),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.edit_outlined, size: 16, color: Color(0xFF9CA3AF)),
          ),
        ],
      ),
    );
  }
}

class _SectionBlock extends StatelessWidget {
  const _SectionBlock({required this.title, required this.items});

  final String title;
  final List<_MenuItemData> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            title.toUpperCase(),
            style: GoogleFonts.inter(
              color: const Color(0xFF638888).withValues(alpha: 0.8),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6,
              height: 1.3,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: const Color(0xFFF3F4F6)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: List.generate(items.length, (index) {
              final item = items[index];
              return Column(
                children: [
                  _SectionItem(item: item),
                  if (index < items.length - 1)
                    const Padding(
                      padding: EdgeInsets.only(left: 68),
                      child: Divider(height: 1, color: Color(0xFFF3F4F6)),
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _SectionItem extends StatelessWidget {
  const _SectionItem({required this.item});

  final _MenuItemData item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, item.routeName),
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: item.iconBg,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(item.icon, size: 20, color: item.iconColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                item.label,
                style: GoogleFonts.inter(
                  color: const Color(0xFF111818),
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFF9CA3AF), size: 20),
          ],
        ),
      ),
    );
  }
}

class _MenuItemData {
  const _MenuItemData({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.label,
    required this.routeName,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String label;
  final String routeName;
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Text(
        'Đăng Xuất',
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          color: const Color(0xFFEF4444),
          fontSize: 17,
          fontWeight: FontWeight.w600,
          height: 1.5,
        ),
      ),
    );
  }
}

class _SettingsBottomNav extends StatelessWidget {
  const _SettingsBottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      padding: const EdgeInsets.fromLTRB(9, 9, 9, 9),
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
