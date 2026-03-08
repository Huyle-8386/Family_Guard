import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

class SafeZoneScreen extends StatelessWidget {
  const SafeZoneScreen({super.key});

  static const LatLng _homeCenter = LatLng(16.4696, 107.5930);
  static const LatLng _schoolCenter = LatLng(16.4762, 107.6002);
  static const LatLng _grandmaCenter = LatLng(16.4621, 107.6036);

  @override
  Widget build(BuildContext context) {
    const zones = [
      _ZoneCardData(
        title: 'Nhà',
        radius: 'Bán kính 200m',
        iconBg: Color(0xFFEEF2FF),
        icon: Icons.home_outlined,
        iconColor: Color(0xFF4F46E5),
        alertTitle: 'Tất cả thành viên đang trong vùng',
        alertSubtitle: null,
        alertBg: Color(0xFFF0FDF4),
        alertBorder: Color(0xFFDCFCE7),
        alertDotColor: Color(0xFF16A34A),
        alertTitleColor: Color(0xFF15803D),
        alertSubColor: Color(0xFF15803D),
        avatarCount: 2,
        extraCount: '+1',
        scheduleText: 'T2-T6',
        scheduleIcon: Icons.calendar_today_outlined,
        softDangerOverlay: false,
      ),
      _ZoneCardData(
        title: 'Trường học',
        radius: 'Bán kính 500m',
        iconBg: Color(0xFFFFF7ED),
        icon: Icons.school_outlined,
        iconColor: Color(0xFFEA580C),
        alertTitle: 'Phát hiện rời khỏi vùng',
        alertSubtitle: 'Đã rời khỏi 12 phút trước',
        alertBg: Color(0xFFFEE2E2),
        alertBorder: Color(0xFFFECACA),
        alertDotColor: Color(0xFFDC2626),
        alertTitleColor: Color(0xFFB91C1C),
        alertSubColor: Color(0xCCDC2626),
        avatarCount: 1,
        extraCount: null,
        scheduleText: '8:00 AM - 4:00 PM',
        scheduleIcon: Icons.schedule_outlined,
        softDangerOverlay: true,
      ),
      _ZoneCardData(
        title: 'Nhà Bà Nội',
        radius: 'Bán kính 100m',
        iconBg: Color(0xFFFFF7ED),
        icon: Icons.home_outlined,
        iconColor: Color(0xFFEA580C),
        alertTitle: 'Phát hiện té ngã',
        alertSubtitle: 'Đã phát đi cảnh báo tới mọi người',
        alertBg: Color(0xFFFEE2E2),
        alertBorder: Color(0xFFFECACA),
        alertDotColor: Color(0xFFDC2626),
        alertTitleColor: Color(0xFFB91C1C),
        alertSubColor: Color(0xCCDC2626),
        avatarCount: 1,
        extraCount: null,
        scheduleText: 'T2-T6',
        scheduleIcon: Icons.calendar_today_outlined,
        softDangerOverlay: true,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFCCEFF0),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 35, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _HeaderRow(),
                  const SizedBox(height: 12),
                  Text(
                    'Vùng An Toàn',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF111818),
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.85,
                      height: 42.5 / 34,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const _SectionTitle('XEM TRƯỚC BẢN ĐỒ'),
                  const SizedBox(height: 8),
                  const _MapPreviewCard(
                    homeCenter: _homeCenter,
                    schoolCenter: _schoolCenter,
                    grandmaCenter: _grandmaCenter,
                  ),
                  const SizedBox(height: 16),
                  const _SectionTitle('VÙNG AN TOÀN ĐANG HOẠT ĐỘNG'),
                  const SizedBox(height: 16),
                  ...zones.map(
                    (zone) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _SafeZoneCard(data: zone),
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              left: 5,
              right: 5,
              bottom: 0.5,
              child: _BottomNav(),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow();

  @override
  Widget build(BuildContext context) {
    return Row(
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
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    height: 25.5 / 17,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 7, 16, 8),
          decoration: BoxDecoration(
            color: const Color(0xFF17E8E8),
            borderRadius: BorderRadius.circular(999),
            boxShadow: const [
              BoxShadow(color: Color(0x0D000000), blurRadius: 2, offset: Offset(0, 1)),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.add, color: Colors.white, size: 14),
              const SizedBox(width: 6),
              Text(
                'Thêm Vùng',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 22.5 / 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        title,
        style: GoogleFonts.inter(
          color: const Color(0xFF638888).withValues(alpha: 0.8),
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.65,
          height: 19.5 / 13,
        ),
      ),
    );
  }
}

class _MapPreviewCard extends StatelessWidget {
  const _MapPreviewCard({
    required this.homeCenter,
    required this.schoolCenter,
    required this.grandmaCenter,
  });

  final LatLng homeCenter;
  final LatLng schoolCenter;
  final LatLng grandmaCenter;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 288,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Color(0x0D000000), blurRadius: 30, offset: Offset(0, 8)),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(16.4696, 107.5960),
              initialZoom: 13.1,
              interactionOptions: InteractionOptions(flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.familyguard.app',
              ),
              PolygonLayer(
                polygons: [
                  Polygon(
                    points: [
                      LatLng(16.4680, 107.5905),
                      LatLng(16.4712, 107.5908),
                      LatLng(16.4715, 107.5958),
                      LatLng(16.4683, 107.5956),
                    ],
                    color: Color(0x3317E8E8),
                    borderColor: Color(0x6617E8E8),
                    borderStrokeWidth: 1,
                    isFilled: true,
                  ),
                  Polygon(
                    points: [
                      LatLng(16.4746, 107.5978),
                      LatLng(16.4780, 107.5985),
                      LatLng(16.4772, 107.6025),
                      LatLng(16.4737, 107.6018),
                    ],
                    color: Color(0x3317E8E8),
                    borderColor: Color(0x6617E8E8),
                    borderStrokeWidth: 1,
                    isFilled: true,
                  ),
                  Polygon(
                    points: [
                      LatLng(16.4608, 107.6018),
                      LatLng(16.4630, 107.6018),
                      LatLng(16.4630, 107.6055),
                      LatLng(16.4608, 107.6055),
                    ],
                    color: Color(0x3317E8E8),
                    borderColor: Color(0x6617E8E8),
                    borderStrokeWidth: 1,
                    isFilled: true,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  _zoneMarker(homeCenter, const Color(0xFF22C55E)),
                  _zoneMarker(schoolCenter, const Color(0xFF22C55E)),
                  _zoneMarker(grandmaCenter, const Color(0xFFEF4444)),
                ],
              ),
            ],
          ),
          const Positioned(left: 16, top: 16, child: _LiveChip()),
          const Positioned(left: 68, top: 70, child: _ZoneLabel('Nhà')),
          const Positioned(left: 160, top: 52, child: _ZoneLabel('Trường')),
          const Positioned(left: 150, top: 188, child: _ZoneLabel('Nhà Bà Nội')),
          Positioned(
            right: 16,
            bottom: 16,
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.95),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(color: Color(0x1A000000), blurRadius: 8, offset: Offset(0, 3)),
                ],
              ),
              child: const Icon(Icons.open_in_full_rounded, size: 18, color: Color(0xFF1F2937)),
            ),
          ),
        ],
      ),
    );
  }

  Marker _zoneMarker(LatLng point, Color color) {
    return Marker(
      point: point,
      width: 16,
      height: 16,
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: const [
            BoxShadow(color: Color(0x29000000), blurRadius: 8, offset: Offset(0, 3)),
          ],
        ),
      ),
    );
  }
}

class _ZoneLabel extends StatelessWidget {
  const _ZoneLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: const Color(0xFF17E8E8),
          fontSize: 11,
          fontWeight: FontWeight.w700,
          height: 16.5 / 11,
        ),
      ),
    );
  }
}

class _LiveChip extends StatelessWidget {
  const _LiveChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(999),
        boxShadow: const [
          BoxShadow(color: Color(0x0D000000), blurRadius: 2, offset: Offset(0, 1)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(color: Color(0xFF22C55E), shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            'Trực Tiếp',
            style: GoogleFonts.inter(
              color: const Color(0xFF638888),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 16 / 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _SafeZoneCard extends StatelessWidget {
  const _SafeZoneCard({required this.data});

  final _ZoneCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Color(0x0D000000), blurRadius: 30, offset: Offset(0, 8)),
        ],
      ),
      child: Stack(
        children: [
          if (data.softDangerOverlay)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0x80FEE2E2),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(21),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: data.iconBg,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      alignment: Alignment.center,
                      child: Icon(data.icon, size: 22, color: data.iconColor),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.title,
                              style: GoogleFonts.inter(
                                color: const Color(0xFF111818),
                                fontSize: 19,
                                fontWeight: FontWeight.w700,
                                height: 28.5 / 19,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(Icons.circle_outlined, size: 12, color: Color(0xFF00ACB1)),
                                const SizedBox(width: 8),
                                Text(
                                  data.radius,
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF638888),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    height: 22.5 / 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const _EnabledToggle(),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, thickness: 1, color: Color(0xFFF3F4F6)),
                const SizedBox(height: 16),
                _AlertBadge(data: data),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _AvatarStack(count: data.avatarCount, extraCount: data.extraCount),
                    const Spacer(),
                    _ScheduleChip(icon: data.scheduleIcon, text: data.scheduleText),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EnabledToggle extends StatelessWidget {
  const _EnabledToggle();

  @override
  Widget build(BuildContext context) {
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
              color: const Color(0xFF17E8E8),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          Positioned(
            right: -4,
            top: -4,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF2563EB),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF17E8E8), width: 4),
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

class _AlertBadge extends StatelessWidget {
  const _AlertBadge({required this.data});

  final _ZoneCardData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: BoxDecoration(
        color: data.alertBg,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: data.alertBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: data.alertDotColor, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.alertTitle,
                  style: GoogleFonts.inter(
                    color: data.alertTitleColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                if (data.alertSubtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    data.alertSubtitle!,
                    style: GoogleFonts.inter(
                      color: data.alertSubColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarStack extends StatelessWidget {
  const _AvatarStack({required this.count, this.extraCount});

  final int count;
  final String? extraCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Row(
        children: [
          for (var i = 0; i < count; i++)
            Transform.translate(
              offset: Offset(-12.0 * i, 0),
              child: _InitialAvatar(index: i),
            ),
          if (extraCount != null)
            Transform.translate(
              offset: Offset(-12.0 * count, 0),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                alignment: Alignment.center,
                child: Text(
                  extraCount!,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6B7280),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    height: 16 / 12,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _InitialAvatar extends StatelessWidget {
  const _InitialAvatar({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    const initials = ['B', 'K', 'N'];
    const bg = [Color(0xFFFED7AA), Color(0xFFBFDBFE), Color(0xFFE9D5FF)];
    const fg = [Color(0xFF9A3412), Color(0xFF1D4ED8), Color(0xFF7E22CE)];

    final i = index % initials.length;

    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: bg[i],
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      alignment: Alignment.center,
      child: Text(
        initials[i],
        style: GoogleFonts.inter(
          color: fg[i],
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ScheduleChip extends StatelessWidget {
  const _ScheduleChip({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Icon(icon, size: 13, color: const Color(0xFF638888)),
          const SizedBox(width: 8),
          Text(
            text,
            style: GoogleFonts.inter(
              color: const Color(0xFF638888),
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

class _ZoneCardData {
  const _ZoneCardData({
    required this.title,
    required this.radius,
    required this.iconBg,
    required this.icon,
    required this.iconColor,
    required this.alertTitle,
    required this.alertSubtitle,
    required this.alertBg,
    required this.alertBorder,
    required this.alertDotColor,
    required this.alertTitleColor,
    required this.alertSubColor,
    required this.avatarCount,
    required this.extraCount,
    required this.scheduleText,
    required this.scheduleIcon,
    required this.softDangerOverlay,
  });

  final String title;
  final String radius;
  final Color iconBg;
  final IconData icon;
  final Color iconColor;
  final String alertTitle;
  final String? alertSubtitle;
  final Color alertBg;
  final Color alertBorder;
  final Color alertDotColor;
  final Color alertTitleColor;
  final Color alertSubColor;
  final int avatarCount;
  final String? extraCount;
  final String scheduleText;
  final IconData scheduleIcon;
  final bool softDangerOverlay;
}
