import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _bg = Color(0xFFF0F8F7);
  static const _primary = Color(0xFF00ACB1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Stack(
          children: [
            const _TopDecoration(),
            Positioned.fill(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _Header(),
                    const SizedBox(height: 24),
                    const _MemberCardsSection(),
                    const SizedBox(height: 24),
                    _SectionTitle(
                      title: 'Tiện ích',
                      action: 'Xem tất cả',
                      color: _primary,
                    ),
                    const SizedBox(height: 16),
                    const _QuickActionsGrid(),
                  ],
                ),
              ),
            ),
            const _BottomNavigationBar(),
          ],
        ),
      ),
    );
  }
}

class _TopDecoration extends StatelessWidget {
  const _TopDecoration();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -96,
            right: -120,
            child: Container(
              width: 292,
              height: 287,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF00ACB1).withValues(alpha: 0.18),
              ),
            ),
          ),
          Positioned(
            top: -72,
            right: -96,
            child: Container(
              width: 252,
              height: 252,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF00ACB1).withValues(alpha: 0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Chào buổi tối,\nHuy',
            style: GoogleFonts.beVietnamPro(
              color: const Color(0xFF00ACB1),
              fontSize: 30,
              fontWeight: FontWeight.w700,
              height: 1.33,
            ),
          ),
          Container(
            width: 55,
            height: 55,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: const CircleAvatar(
              backgroundColor: Color(0xFFE5E7EB),
              child: Icon(Icons.person, color: Color(0xFF374151)),
            ),
          ),
        ],
      ),
    );
  }
}

class _MemberCardsSection extends StatelessWidget {
  const _MemberCardsSection();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 228,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          _MemberCard(
            name: 'Mẹ',
            status: 'Đang ở nhà',
            battery: '85%',
            location: '123 Đường Nguyễn Huệ…',
            statusColor: Color(0xFF00ADB2),
            statusDot: Color(0xFF00ADB2),
            batteryIcon: Icons.battery_full,
            locationIconBg: Color(0x4D87E4DB),
            locationIcon: Icons.location_on,
            locationIconColor: Color(0xFF008A8E),
          ),
          SizedBox(width: 16),
          Opacity(
            opacity: 0.8,
            child: _MemberCard(
              name: 'Bố',
              status: 'Đang đi dạo',
              battery: '24%',
              location: 'Công viên Tao Đàn',
              statusColor: Color(0xFF374151),
              statusDot: Color(0xFFEAB308),
              batteryIcon: Icons.battery_alert,
              batteryColor: Color(0xFFCA8A04),
              locationIconBg: Color(0xFFDBEAFE),
              locationIcon: Icons.park,
              locationIconColor: Color(0xFF2563EB),
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
    required this.status,
    required this.battery,
    required this.location,
    required this.statusColor,
    required this.statusDot,
    required this.batteryIcon,
    required this.locationIconBg,
    required this.locationIcon,
    required this.locationIconColor,
    this.batteryColor = const Color(0xFF00ADB2),
  });

  final String name;
  final String status;
  final String battery;
  final String location;
  final Color statusColor;
  final Color statusDot;
  final IconData batteryIcon;
  final Color batteryColor;
  final Color locationIconBg;
  final IconData locationIcon;
  final Color locationIconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 331.5,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0x1AFFFFFF),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x2600ADB2),
            blurRadius: 40,
            offset: Offset(0, 10),
            spreadRadius: -10,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x1AFFFFFF),
                    Color(0x99FFFFFF),
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x26000000),
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const CircleAvatar(
                              backgroundColor: Color(0xFFE5E7EB),
                              child: Icon(Icons.person, color: Color(0xFF6B7280)),
                            ),
                          ),
                          Positioned(
                            right: -1,
                            bottom: -1,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: statusDot,
                                border: Border.all(color: Colors.white, width: 2),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x6687E4DB),
                                    blurRadius: 0,
                                    spreadRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: GoogleFonts.publicSans(
                              color: const Color(0xFF00ACB1),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              height: 1.4,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.8),
                              borderRadius: BorderRadius.circular(999),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x1A000000),
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: statusDot,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  status,
                                  style: GoogleFonts.publicSans(
                                    color: statusColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    height: 20 / 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        Icon(batteryIcon, color: batteryColor, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          battery,
                          style: GoogleFonts.publicSans(
                            color: const Color(0xFF4B5563),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 20 / 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: locationIconBg,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(locationIcon, color: locationIconColor, size: 24),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Vị trí hiện tại',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.publicSans(
                                    color: const Color(0xFF6B7280),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    height: 16 / 12,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  location,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.publicSans(
                                    color: const Color(0xFF111827),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 20 / 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3F4F6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF4B5563),
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({
    required this.title,
    required this.action,
    required this.color,
  });

  final String title;
  final String action;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.publicSans(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              height: 28 / 18,
            ),
          ),
          Text(
            action,
            style: GoogleFonts.beVietnamPro(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 28 / 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      childAspectRatio: 165 / 152,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        _QuickActionCard(
          title: 'Thành viên',
          subtitle: 'Quản lí thành viên',
          icon: Icons.home_rounded,
          iconBg: Color(0x33D1FAE5),
          iconColor: Color(0xFF0EA5A8),
        ),
        _QuickActionCard(
          title: 'Tâm trạng',
          subtitle: 'Nhật ký hôm nay',
          icon: Icons.sentiment_satisfied_alt,
          iconBg: Color(0xFFFFEDD5),
          iconColor: Color(0xFFF97316),
        ),
        _QuickActionCard(
          title: 'An toàn',
          subtitle: 'Thiết lập vùng',
          icon: Icons.shield,
          iconBg: Color(0xFFFCE7F3),
          iconColor: Color(0xFFD946EF),
        ),
        _QuickActionCard(
          title: 'Lịch nhắc',
          subtitle: 'Nhắc nhở hằng ngày',
          icon: Icons.alarm,
          iconBg: Color(0xFFDBEAFE),
          iconColor: Color(0xFF3B82F6),
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: const Color(0xFF87E4DB), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: const Color(0xFF7EE7E0), width: 1),
              boxShadow: [
                BoxShadow(
                  color: iconBg,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.publicSans(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 24 / 16,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.publicSans(
              color: const Color(0xFF6B7280),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 16 / 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 24,
      right: 24,
      bottom: 16,
      child: Container(
        height: 74,
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 9),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: const Color(0xFFF3F4F6)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3300ADB2),
              blurRadius: 50,
              offset: Offset(0, 25),
              spreadRadius: -12,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            _NavItem(icon: Icons.dashboard, active: true),
            _NavItem(icon: Icons.map, active: false),
            _NavItem(icon: Icons.notifications, active: false),
            _NavItem(icon: Icons.person, active: false),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.icon, required this.active});

  final IconData icon;
  final bool active;

  @override
  Widget build(BuildContext context) {
    if (active) {
      return Container(
        width: 56,
        height: 56,
        decoration: const BoxDecoration(
          color: Color(0xFF00ACB1),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0x6600ADB2),
              blurRadius: 15,
              offset: Offset(0, 4),
              spreadRadius: -3,
            ),
          ],
        ),
        child: const Icon(Icons.dashboard, color: Colors.white, size: 24),
      );
    }

    return SizedBox(
      width: 56,
      height: 56,
      child: Icon(icon, color: const Color(0xFF9CA3AF), size: 24),
    );
  }
}
