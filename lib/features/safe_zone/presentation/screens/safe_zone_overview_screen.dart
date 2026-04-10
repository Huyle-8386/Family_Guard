import 'package:family_guard/core/constants/app_routes.dart';
import 'package:family_guard/features/safe_zone/presentation/widgets/safe_zone_active_screen.dart';
import 'package:family_guard/features/safe_zone/presentation/screens/safe_zone_screen.dart'
    as safe_zone_list;
import 'package:family_guard/core/widgets/app_back_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SafeZoneOverviewScreen extends StatefulWidget {
  const SafeZoneOverviewScreen({super.key});

  @override
  State<SafeZoneOverviewScreen> createState() => _SafeZoneOverviewScreenState();
}

class _SafeZoneOverviewScreenState extends State<SafeZoneOverviewScreen> {
  final MapController _mapController = MapController();

  static const LatLng _userPosition = LatLng(10.7769, 106.7009);

  static const List<_SafeZoneMember> _members = [
    _SafeZoneMember(
      id: 'm1',
      name: 'Nguyễn Văn A',
      avatarUrl: 'https://i.pravatar.cc/150?img=15',
      avatarColor: Color(0xFF80CBC4),
      zoneCount: 3,
      updatedLabel: '5 phút trước',
    ),
    _SafeZoneMember(
      id: 'm2',
      name: 'Trần Thị B',
      avatarUrl: 'https://i.pravatar.cc/150?img=32',
      avatarColor: Color(0xFFFFCC80),
      zoneCount: 2,
      updatedLabel: '12 phút trước',
    ),
  ];

  static const List<_SafeZoneMapItem> _zones = [
    _SafeZoneMapItem(
      label: 'Trường học',
      center: LatLng(10.7794, 106.7036),
      radiusInMeters: 220,
    ),
    _SafeZoneMapItem(
      label: 'Nhà',
      center: _userPosition,
      radiusInMeters: 150,
    ),
  ];

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F8F7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72 + topInset),
        child: SafeArea(
          bottom: false,
          child: AppBackHeaderBar(
            title: 'Quản lý vùng an toàn',
            trailingAreaWidth: 88,
            trailing: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const safe_zone_list.SafeZoneScreen(),
                  ),
                );
              },
              child: const Text(
                'Xem tất cả',
                style: TextStyle(
                  color: Color(0xCC00ACB2),
                  fontSize: 14,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F8F7), Color(0xFFF0F8F7)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMapCard(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'THÀNH VIÊN GIA ĐÌNH',
                  style: TextStyle(
                    color: Color(0x9900ACB2),
                    fontSize: 13,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.7,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: _members
                      .map(
                        (member) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _MemberCard(
                            member: member,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => SafeZoneMemberScreen(
                                    member: member.toLegacyMap(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.08,
                  children: [
                    _ActionCard(
                      icon: Icons.add_location_alt_outlined,
                      label: 'Thêm vùng mới',
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.safeZoneAdd),
                    ),
                    _ActionCard(
                      icon: Icons.history_toggle_off_rounded,
                      label: 'Lịch sử di chuyển',
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.activityHistory,
                      ),
                    ),
                    _ActionCard(
                      icon: Icons.notifications_active_outlined,
                      label: 'Cảnh báo',
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.safeZoneAlert),
                    ),
                    _ActionCard(
                      icon: Icons.settings_outlined,
                      label: 'Cài đặt',
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.safeZoneAlertSettings,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapCard() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
      child: Container(
        width: double.infinity,
        height: 260,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0x1900ACB2), width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1400ACB2),
              blurRadius: 20,
              offset: Offset(0, 4),
              spreadRadius: -2,
            ),
          ],
        ),
        child: Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: const MapOptions(
                initialCenter: _userPosition,
                initialZoom: 15.5,
                interactionOptions: InteractionOptions(
                  flags: InteractiveFlag.all,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.familyguard.app',
                  maxZoom: 19,
                ),
                CircleLayer(
                  circles: _zones
                      .map(
                        (zone) => CircleMarker(
                          point: zone.center,
                          radius: zone.radiusInMeters,
                          useRadiusInMeter: true,
                          color: const Color(0x3300ACB2),
                          borderColor: const Color(0xFF00ACB2),
                          borderStrokeWidth: 2,
                        ),
                      )
                      .toList(),
                ),
                MarkerLayer(
                  markers: [
                    ..._zones.map(
                      (zone) => Marker(
                        point: zone.center,
                        width: 86,
                        height: 30,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.94),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              zone.label,
                              style: const TextStyle(
                                color: Color(0xFF00ACB2),
                                fontSize: 11,
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Marker(
                      point: _userPosition,
                      width: 44,
                      height: 44,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF00ACB2),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x4400ACB2),
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: Image.network(
                            _members.first.avatarUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 12,
              right: 12,
              child: _MapButton(
                icon: Icons.my_location_rounded,
                onTap: () => _mapController.move(_userPosition, 15.5),
              ),
            ),
            Positioned(
              right: 12,
              bottom: 12,
              child: Column(
                children: [
                  _MapButton(
                    icon: Icons.add,
                    onTap: () => _mapController.move(
                      _mapController.camera.center,
                      _mapController.camera.zoom + 1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _MapButton(
                    icon: Icons.remove,
                    onTap: () => _mapController.move(
                      _mapController.camera.center,
                      _mapController.camera.zoom - 1,
                    ),
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

class _MemberCard extends StatelessWidget {
  const _MemberCard({
    required this.member,
    required this.onTap,
  });

  final _SafeZoneMember member;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0x1900ACB2)),
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0C000000),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: member.avatarColor,
                  backgroundImage: NetworkImage(member.avatarUrl),
                ),
                const Positioned(
                  right: 0,
                  bottom: 0,
                  child: _OnlineDot(size: 13),
                ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.name,
                    style: const TextStyle(
                      color: Color(0xFF0C1D1A),
                      fontSize: 15,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${member.zoneCount} vùng an toàn',
                    style: const TextStyle(
                      color: Color(0xFF00ACB2),
                      fontSize: 12,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Cập nhật ${member.updatedLabel}',
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 10,
                      fontFamily: 'Lexend',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Color(0x1900ACB2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.location_on_outlined,
                color: Color(0xFF00ACB2),
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0x1900ACB2), width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0C000000),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0x1400ACB2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: const Color(0xFF00ACB2), size: 22),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF0C1D1A),
                  fontSize: 12,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MapButton extends StatelessWidget {
  const _MapButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: const Color(0xFF00ACB2), size: 20),
      ),
    );
  }
}

class _OnlineDot extends StatelessWidget {
  const _OnlineDot({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFF00ACB2),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }
}

class _SafeZoneMember {
  const _SafeZoneMember({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.avatarColor,
    required this.zoneCount,
    required this.updatedLabel,
  });

  final String id;
  final String name;
  final String avatarUrl;
  final Color avatarColor;
  final int zoneCount;
  final String updatedLabel;

  Map<String, dynamic> toLegacyMap() {
    final trimmedName = name.trim();
    final avatarLetter = trimmedName.isEmpty
        ? 'A'
        : trimmedName.substring(0, 1).toUpperCase();
    return {
      'id': id,
      'name': name,
      'role': 'Người cao tuổi',
      'avatar': avatarLetter,
      'activeZones': zoneCount,
      'color': avatarColor,
    };
  }
}

class _SafeZoneMapItem {
  const _SafeZoneMapItem({
    required this.label,
    required this.center,
    required this.radiusInMeters,
  });

  final String label;
  final LatLng center;
  final double radiusInMeters;
}

