import 'package:family_guard/core/constants/app_routes.dart';
import 'package:family_guard/core/widgets/app_bottom_menu.dart';
import 'package:family_guard/features/home/presentation/screens/kid_flow_models.dart';
import 'package:family_guard/features/profile_security/presentation/screens/personal_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KidProfileScreen extends StatelessWidget {
  const KidProfileScreen({super.key});

  static const _bg = Color(0xFFF7FBFF);
  static const _surface = Colors.white;
  static const _teal = Color(0xFF11B7B3);
  static const _tealDark = Color(0xFF0D7F7B);
  static const _text = Color(0xFF16304B);
  static const _muted = Color(0xFF73839B);
  static const _softMint = Color(0xFFE8FAF6);
  static const _softBlue = Color(0xFFEAF4FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 126),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 18),
                    _buildProfileCard(),
                    const SizedBox(height: 18),
                    _buildFamilyTrustCard(context),
                    const SizedBox(height: 18),
                    _buildActionList(context),
                    const SizedBox(height: 18),
                    _buildLogoutButton(context),
                  ],
                ),
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AppBottomMenu(
                current: AppNavTab.settings,
                homeRouteName: AppRoutes.kidHome,
                trackingRouteName: AppRoutes.kidLocation,
                settingsRouteName: AppRoutes.kidProfile,
                thirdTab: AppBottomMenuThirdTab.chat,
                thirdTabRouteName: AppRoutes.kidChatList,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      height: 42,
      child: Center(
        child: Text(
          'Thông tin cá nhân',
          textAlign: TextAlign.center,
          style: GoogleFonts.lexend(
            color: _text,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 98,
                height: 98,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFFFE7D8), Color(0xFFF7C6B4)],
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  'A',
                  style: GoogleFonts.lexend(
                    color: _text,
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Positioned(
                right: 4,
                bottom: 4,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: _teal,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: const Icon(
                    Icons.verified_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Xôi',
            style: GoogleFonts.lexend(
              color: _text,
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '12 tuổi',
            style: GoogleFonts.beVietnamPro(
              color: _muted,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyTrustCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Kết nối gia đình của con',
                  style: GoogleFonts.lexend(
                    color: _text,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              InkWell(
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.kidChatList),
                borderRadius: BorderRadius.circular(999),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _softBlue,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    'Mở chat',
                    style: GoogleFonts.lexend(
                      color: _tealDark,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ...KidFlowModels.threads
                  .skip(1)
                  .take(2)
                  .map(
                    (thread) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: thread.person.accent,
                        child: Text(
                          thread.person.initial,
                          style: GoogleFonts.lexend(
                            color: _text,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Mẹ, Bố và 1 người khác luôn thấy vị trí khi khẩn cấp',
                  style: GoogleFonts.beVietnamPro(
                    color: _muted,
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionList(BuildContext context) {
    return Column(
      children: [
        _actionTile(
          title: 'Vùng An Toàn',
          subtitle: 'Trường học - Nhà',
          badge: 'Đang bật',
          icon: Icons.shield_rounded,
          color: _teal,
          onTap: () => Navigator.pushNamed(context, AppRoutes.safeZone),
        ),
        const SizedBox(height: 12),
        _actionTile(
          title: 'Thay đổi điện thoại',
          subtitle: 'Xem và cập nhật thông tin cơ bản',
          icon: Icons.phone_android_rounded,
          color: const Color(0xFF5F8CFF),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const PersonalInfoScreen(
                showBackButton: false,
                homeRouteName: AppRoutes.kidHome,
                trackingRouteName: AppRoutes.kidLocation,
                settingsRouteName: AppRoutes.kidProfile,
                thirdTab: AppBottomMenuThirdTab.chat,
                thirdTabRouteName: AppRoutes.kidChatList,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        _actionTile(
          title: 'Màu sắc ứng dụng',
          subtitle: 'Tùy chỉnh giao diện dễ nhìn hơn',
          icon: Icons.palette_rounded,
          color: const Color(0xFFFF9D42),
          onTap: () => Navigator.pushNamed(context, AppRoutes.settings),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return InkWell(
      onTap: () => _showLogoutDialog(context),
      borderRadius: BorderRadius.circular(24),
      child: Ink(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          'Đăng xuất',
          textAlign: TextAlign.center,
          style: GoogleFonts.lexend(
            color: const Color(0xFFEF4444),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.logout_rounded,
                  color: Color(0xFFEF4444),
                  size: 32,
                ),
                const SizedBox(height: 16),
                Text(
                  'Đăng xuất?',
                  style: GoogleFonts.lexend(
                    color: _text,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Nhấn OK để quay về màn hình đăng nhập, hoặc Hủy để tiếp tục.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.beVietnamPro(
                    color: _muted,
                    fontSize: 14,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(dialogContext).pop(false),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: _text,
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('Hủy'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: () => Navigator.of(dialogContext).pop(true),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFFEF4444),
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('OK'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    if (shouldLogout == true && context.mounted) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (_) => false);
    }
  }

  Widget _actionTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    String? badge,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lexend(
                            color: _text,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      if (badge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _softMint,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            badge,
                            style: GoogleFonts.lexend(
                              color: _tealDark,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.beVietnamPro(
                      color: _muted,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFFB3C0CF)),
          ],
        ),
      ),
    );
  }
}
