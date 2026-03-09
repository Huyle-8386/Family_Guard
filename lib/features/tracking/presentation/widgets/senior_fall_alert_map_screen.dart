// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:family_guard/core/widgets/app_bottom_menu.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

class SeniorFallAlertMapScreen extends StatelessWidget {
  const SeniorFallAlertMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F8),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Stack(
              children: const [
                Positioned.fill(child: _AlertMapLayer()),
                Positioned.fill(child: _TopLayer()),
                Positioned.fill(child: _BottomSheetAndNav()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AlertMapLayer extends StatelessWidget {
  const _AlertMapLayer();

  static const LatLng _seniorPoint = LatLng(40.7539, -73.9880);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(40.7340, -74.0020),
              initialZoom: 12.7,
              minZoom: 3,
              maxZoom: 18,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.familyguard.app',
              ),
              const CircleLayer(
                circles: [
                  CircleMarker(
                    point: _seniorPoint,
                    radius: 154,
                    color: Color(0x5417E8E8),
                    borderColor: Color(0x4D17E8E8),
                    borderStrokeWidth: 2,
                  ),
                ],
              ),
              const MarkerLayer(
                markers: [
                  Marker(
                    point: _seniorPoint,
                    width: 112,
                    height: 120,
                    alignment: Alignment.topCenter,
                    child: _AlertMarker(),
                  ),
                  Marker(
                    point: LatLng(40.7218, -74.0020),
                    width: 24,
                    height: 24,
                    alignment: Alignment.center,
                    child: _CurrentLocationDot(),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right: 16,
          top: 365,
          child: Column(
            children: [
              _MapActionButton(icon: Icons.gps_fixed, onTap: () {}),
              const SizedBox(height: 12),
              _MapActionButton(icon: Icons.layers_outlined, onTap: () {}),
            ],
          ),
        ),
      ],
    );
  }
}

class _AlertMarker extends StatefulWidget {
  const _AlertMarker();

  @override
  State<_AlertMarker> createState() => _AlertMarkerState();
}

class _AlertMarkerState extends State<_AlertMarker>
    with SingleTickerProviderStateMixin {
  late final AnimationController _blinkController;

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _blinkController,
      builder: (context, _) {
        final t = _blinkController.value;
        final borderColor = Color.lerp(
          const Color(0xFFDE4A4A),
          const Color(0x99FF6B6B),
          t,
        )!;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ...List.generate(4, (index) {
                  final phase = (t + index * 0.2) % 1.0;
                  final opacity = 0.15 + (1 - phase) * 0.35;
                  final size = 58.0 + index * 9.0;
                  return Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFFF6B6B).withValues(alpha: opacity),
                        width: 2,
                      ),
                    ),
                  );
                }),
                Container(
                  width: 48,
                  height: 48,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: borderColor, width: 2.6),
                    boxShadow: [
                      const BoxShadow(
                        color: Color(0x1A000000),
                        blurRadius: 15,
                        offset: Offset(0, 6),
                      ),
                      BoxShadow(
                        color: const Color(0x66FF6B6B).withValues(alpha: 0.15 + (1 - t) * 0.45),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.network(
                      'https://images.unsplash.com/photo-1581579438747-1dc8d17bbce4?q=80&w=300&auto=format&fit=crop',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: const Color(0xFFE2E8F0)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(999),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Text(
                'Bà nội',
                style: GoogleFonts.inter(
                  color: const Color(0xFF0F172A),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CurrentLocationDot extends StatelessWidget {
  const _CurrentLocationDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
    );
  }
}

class _TopLayer extends StatelessWidget {
  const _TopLayer();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xCCFFFFFF), Color(0x00FFFFFF)],
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 44,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: const [
                    _FilterChip(label: 'Tất cả'),
                    _FilterChip(label: 'Trẻ em'),
                    _FilterChip(label: 'Ng.Lớn'),
                    _FilterChip(label: 'Ng.Già', selected: true),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings, size: 20, color: Color(0xFF334155)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, this.selected = false});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF04D1D4) : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: selected ? Colors.black : const Color(0xFF64748B),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _MapActionButton extends StatelessWidget {
  const _MapActionButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 15,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, size: 22, color: const Color(0xFF475569)),
      ),
    );
  }
}

class _BottomSheetAndNav extends StatelessWidget {
  const _BottomSheetAndNav();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          _AlertBottomSheet(),
          AppBottomMenu(current: AppNavTab.tracking),
        ],
      ),
    );
  }
}

class _AlertBottomSheet extends StatelessWidget {
  const _AlertBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF1F5F9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 8),
            child: Container(
              width: 48,
              height: 6,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _alertAvatar(),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bà nội',
                                  style: GoogleFonts.inter(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                    height: 1,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Phát hiện té ngã',
                                  style: GoogleFonts.inter(
                                    fontSize: 29,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFFF6B6B),
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.battery_charging_full, size: 14, color: Color(0xFF22C55E)),
                                const SizedBox(width: 4),
                                Text(
                                  '82%',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF334155),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Color(0xFFFFD5D5)),
                                  backgroundColor: const Color(0xFFFFF0F0),
                                  shape: const StadiumBorder(),
                                ),
                                child: Text(
                                  'Xem chi tiết',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFFFF6B6B),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          _circleIcon(Icons.call_outlined),
                          const SizedBox(width: 8),
                          _circleIcon(Icons.chat_bubble_outline),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: Row(
              children: const [
                Expanded(
                  child: _InfoChip(
                    title: 'Lần cuối cập nhật',
                    value: 'Ngay bây giờ',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _InfoChip(
                    title: 'Khoảng cách',
                    value: '5 km',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _alertAvatar() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFFF6B6B), width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Image.network(
              'https://images.unsplash.com/photo-1581579438747-1dc8d17bbce4?q=80&w=300&auto=format&fit=crop',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(color: const Color(0xFFE2E8F0)),
            ),
          ),
        ),
        Positioned(
          right: -3,
          bottom: -3,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: const Color(0xFFFF6B6B),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(Icons.priority_high, size: 13, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _circleIcon(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: Color(0xFFF1F5F9),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 20, color: const Color(0xFF475569)),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(48),
        border: Border.all(color: const Color(0xFF00ADB2)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: const Color(0xFF00ADB2),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(
              color: const Color(0xFF10B2B7),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _MapBottomNav extends StatelessWidget {
  const _MapBottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      color: Colors.white.withValues(alpha: 0.9),
      child: Center(
        child: Container(
          height: 58,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.symmetric(horizontal: 9),
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
              _NavItem(icon: Icons.map, selected: true),
              _NavItem(icon: Icons.notifications_none),
              _NavItem(icon: Icons.person_outline),
            ],
          ),
        ),
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
