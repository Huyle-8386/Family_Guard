import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThanhVienScreen extends StatelessWidget {
  const ThanhVienScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F8F7),
      body: SafeArea(
        child: Column(
          children: [
            const _HeaderSection(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                children: const [
                  _MemberCard(
                    name: 'Xôi',
                    roleLabel: 'TRẺ EM',
                    roleBgColor: Color(0xFFECF6F5),
                    roleTextColor: Color(0xFF00ACB1),
                    statusText: 'Đang ở trường',
                    statusTextColor: Color(0xFF8490A2),
                    statusIcon: Icons.directions_walk,
                    batteryText: '78%',
                    batteryTextColor: Color(0xFF00ACB1),
                    batteryBgColor: Color(0xFFF0FDF4),
                    batteryIconColor: Color(0xFF00ACB1),
                    locationText: 'Gần trường Tiểu Học 36',
                    locationTextColor: Color(0xFF64748B),
                    zoneText: 'Vùng an toàn',
                    zoneBgColor: Color(0xFFECF6F5),
                    zoneTextColor: Color(0xFF00ACB1),
                    zoneDotColor: Color(0xFF00ACB1),
                    avatarUrl:
                        'https://images.unsplash.com/photo-1588075592446-265fd1e6e76f?w=160&q=80',
                    avatarRingColor: Colors.white,
                    onlineDotColor: Color(0xFF00ACB1),
                  ),
                  SizedBox(height: 18),
                  _MemberCard(
                    name: 'Bà nội',
                    roleLabel: 'NGƯỜI GIÀ',
                    roleBgColor: Color(0xFFDCFCE7),
                    roleTextColor: Color(0xFF00ACB1),
                    statusText: 'Phát hiện té ngã !',
                    statusTextColor: Color(0xFFB91C1C),
                    statusIcon: Icons.medical_services_outlined,
                    batteryText: '12%',
                    batteryTextColor: Color(0xFFB91C1C),
                    batteryBgColor: Color(0x80FFFFFF),
                    batteryIconColor: Color(0xFFB91C1C),
                    locationText: 'Đã phát cảnh báo !',
                    locationTextColor: Color(0xFF991B1B),
                    locationIcon: Icons.wifi_tethering_error_rounded,
                    zoneText: 'Xem vị trí',
                    zoneBgColor: Color(0xFFDC2626),
                    zoneTextColor: Colors.white,
                    avatarUrl:
                        'https://images.unsplash.com/photo-1544717297-fa95b6ee9643?w=160&q=80',
                    avatarRingColor: Color(0xFFFECACA),
                    onlineDotColor: Color(0xFFEF4444),
                    critical: true,
                  ),
                  SizedBox(height: 18),
                  _MemberCard(
                    name: 'Bố xôi',
                    roleLabel: 'NGƯỜI LỚN',
                    roleBgColor: Color(0x3317E8E8),
                    roleTextColor: Color(0xFF00ACB1),
                    statusText: 'Đang lái xe',
                    statusTextColor: Color(0xFF64748B),
                    statusIcon: Icons.two_wheeler,
                    batteryText: '45%',
                    batteryTextColor: Color(0xFF475569),
                    batteryBgColor: Color(0xFFF1F5F9),
                    batteryIconColor: Color(0xFF475569),
                    locationText: 'Gần Quốc Lộ 1A',
                    locationTextColor: Color(0xFF64748B),
                    zoneText: 'Ngoài vùng',
                    zoneBgColor: Color(0xFFFFEDD5),
                    zoneTextColor: Color(0xFFC2410C),
                    zoneIcon: Icons.warning_amber_rounded,
                    avatarUrl:
                        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=160&q=80',
                    avatarRingColor: Colors.white,
                  ),
                  SizedBox(height: 18),
                  _MemberCard(
                    name: 'Suri',
                    roleLabel: 'TRẺ EM',
                    roleBgColor: Color(0xFFECF6F5),
                    roleTextColor: Color(0xFF00ACB1),
                    statusText: 'Ngoại tuyến - 2 giờ trước',
                    statusTextColor: Color(0xFF94A3B8),
                    statusIcon: Icons.signal_wifi_off,
                    batteryText: '--%',
                    batteryTextColor: Color(0xFF94A3B8),
                    batteryBgColor: Color(0x80E2E8F0),
                    batteryIconColor: Color(0xFF94A3B8),
                    locationText: 'Lần cuối ở: Nhà',
                    locationTextColor: Color(0xFF94A3B8),
                    locationIcon: Icons.history,
                    zoneText: 'Ngoại tuyến',
                    zoneBgColor: Color(0xFFE2E8F0),
                    zoneTextColor: Color(0xFF64748B),
                    avatarUrl:
                        'https://images.unsplash.com/photo-1599566150163-29194dcaad36?w=160&q=80',
                    avatarRingColor: Color(0xFFF1F5F9),
                    onlineDotColor: Color(0xFF94A3B8),
                    dimmed: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 17),
      decoration: const BoxDecoration(
        color: Color(0xFFECF6F5),
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: IconButton(
                      onPressed: () => Navigator.maybePop(context),
                      icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                      color: const Color(0xFF0F172A),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 56),
                    child: Text(
                      'Thành Viên',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF00ACB1),
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.75,
                        height: 36 / 30,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0x1A17E8E8),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add, size: 18),
                      color: const Color(0xFF00ACB1),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Quản lí và giám sát các thành viên trong gia đình',
            style: GoogleFonts.inter(
              color: const Color(0xFF8490A2),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 20 / 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({
    required this.name,
    required this.roleLabel,
    required this.roleBgColor,
    required this.roleTextColor,
    required this.statusText,
    required this.statusTextColor,
    required this.statusIcon,
    required this.batteryText,
    required this.batteryTextColor,
    required this.batteryBgColor,
    required this.batteryIconColor,
    required this.locationText,
    required this.locationTextColor,
    required this.zoneText,
    required this.zoneBgColor,
    required this.zoneTextColor,
    required this.avatarUrl,
    required this.avatarRingColor,
    this.onlineDotColor,
    this.zoneDotColor,
    this.zoneIcon,
    this.locationIcon = Icons.location_on_outlined,
    this.critical = false,
    this.dimmed = false,
  });

  final String name;
  final String roleLabel;
  final Color roleBgColor;
  final Color roleTextColor;
  final String statusText;
  final Color statusTextColor;
  final IconData statusIcon;
  final String batteryText;
  final Color batteryTextColor;
  final Color batteryBgColor;
  final Color batteryIconColor;
  final String locationText;
  final Color locationTextColor;
  final String zoneText;
  final Color zoneBgColor;
  final Color zoneTextColor;
  final String avatarUrl;
  final Color avatarRingColor;
  final Color? onlineDotColor;
  final Color? zoneDotColor;
  final IconData? zoneIcon;
  final IconData locationIcon;
  final bool critical;
  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    final baseColor = critical ? const Color(0x66FEE2E2) : Colors.white;
    final borderColor = critical ? const Color(0xFFFEE2E2) : const Color(0xFFF8FAFC);

    return Opacity(
      opacity: dimmed ? 0.9 : 1,
      child: Container(
        padding: const EdgeInsets.all(21),
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: borderColor),
          boxShadow: [
            const BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 20,
              offset: Offset(0, 4),
              spreadRadius: -2,
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Avatar(
                  url: avatarUrl,
                  ringColor: avatarRingColor,
                  dotColor: onlineDotColor,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: GoogleFonts.inter(
                                color: critical
                                    ? const Color(0xFF7F1D1D)
                                    : dimmed
                                        ? const Color(0xFF475569)
                                        : const Color(0xFF0F172A),
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                height: 28 / 18,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: roleBgColor,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              roleLabel,
                              style: GoogleFonts.inter(
                                color: roleTextColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.25,
                                height: 15 / 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(statusIcon, size: 14, color: statusTextColor),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              statusText,
                              style: GoogleFonts.inter(
                                color: statusTextColor,
                                fontSize: 14,
                                fontWeight: critical ? FontWeight.w600 : FontWeight.w400,
                                height: 20 / 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: critical
                          ? const Color(0xFFEF4444)
                          : const Color(0xFFCBD5E1),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: batteryBgColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.battery_std, size: 12, color: batteryIconColor),
                          const SizedBox(width: 4),
                          Text(
                            batteryText,
                            style: GoogleFonts.inter(
                              color: batteryTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              height: 16 / 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 1,
              color: critical ? const Color(0x80FECACA) : const Color(0xFFF1F5F9),
            ),
            const SizedBox(height: 13),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(locationIcon, size: 12, color: locationTextColor),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          locationText,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            color: locationTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 16 / 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: zoneBgColor,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (zoneDotColor != null)
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: zoneDotColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      if (zoneDotColor != null) const SizedBox(width: 5),
                      if (zoneIcon != null) Icon(zoneIcon, size: 11, color: zoneTextColor),
                      if (zoneIcon != null) const SizedBox(width: 4),
                      Text(
                        zoneText,
                        style: GoogleFonts.inter(
                          color: zoneTextColor,
                          fontSize: 12,
                          fontWeight: critical ? FontWeight.w700 : FontWeight.w500,
                          height: 16 / 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.url, required this.ringColor, this.dotColor});

  final String url;
  final Color ringColor;
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 64,
          height: 64,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: ringColor,
            shape: BoxShape.circle,
            border: Border.all(color: ringColor, width: 2),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFFE2E8F0),
                alignment: Alignment.center,
                child: const Icon(Icons.person, color: Color(0xFF64748B)),
              ),
            ),
          ),
        ),
        if (dotColor != null)
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
