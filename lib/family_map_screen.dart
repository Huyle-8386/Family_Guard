import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

class FamilyMapScreen extends StatefulWidget {
  const FamilyMapScreen({super.key});

  @override
  State<FamilyMapScreen> createState() => _FamilyMapScreenState();
}

class _FamilyMapScreenState extends State<FamilyMapScreen> {
  _MemberFilter _selectedFilter = _MemberFilter.children;
  String? _selectedMemberName;

  static const List<_MapMember> _members = [
    _MapMember(
      name: 'Xôi',
      role: _MemberFilter.children,
      battery: 82,
      subtitle: 'Đang đi bộ về nhà từ trường',
      distanceLabel: '0.5 km',
      activityIcon: Icons.directions_walk,
      markerBorderColor: Color(0xFF60A5FA),
      location: LatLng(40.7212, -73.9950),
      avatarUrl: 'https://images.unsplash.com/photo-1621452773781-0f992fd1f5cb?q=80&w=300&auto=format&fit=crop',
    ),
    _MapMember(
      name: 'Bố xôi',
      role: _MemberFilter.adults,
      battery: 82,
      subtitle: 'Đang lái xe',
      distanceLabel: '3 km',
      activityIcon: Icons.pedal_bike_rounded,
      markerBorderColor: Color(0xFF17E8E8),
      location: LatLng(40.7342, -74.0195),
      avatarUrl: 'https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=300&auto=format&fit=crop',
    ),
    _MapMember(
      name: 'Bà nội',
      role: _MemberFilter.seniors,
      battery: 82,
      subtitle: 'Đang ở nhà riêng',
      distanceLabel: '5 km',
      activityIcon: Icons.directions_walk,
      markerBorderColor: Color(0xFF4ADE80),
      location: LatLng(40.7539, -73.9880),
      avatarUrl: 'https://images.unsplash.com/photo-1581579438747-1dc8d17bbce4?q=80&w=300&auto=format&fit=crop',
    ),
  ];

  List<_MapMember> get _filteredMembers {
    if (_selectedFilter == _MemberFilter.all) {
      return _members;
    }
    return _members.where((member) => member.role == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    final visibleMembers = _filteredMembers;
    final selectedMember = _resolveSelectedMember(visibleMembers);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Stack(
              children: [
                Positioned.fill(
                  child: _MapLayer(
                    members: visibleMembers,
                    mapCenter: selectedMember.location,
                    mapKey: ValueKey(_selectedFilter),
                    onSelectMember: (memberName) {
                      setState(() => _selectedMemberName = memberName);
                    },
                  ),
                ),
                Positioned.fill(
                  child: Column(
                    children: [
                      _TopControls(
                        selected: _selectedFilter,
                        onChanged: (filter) {
                          setState(() {
                            _selectedFilter = filter;
                            _selectedMemberName = null;
                          });
                        },
                      ),
                      const Spacer(),
                      _BottomSheetAndNav(selectedMember: selectedMember),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _MapMember _resolveSelectedMember(List<_MapMember> visibleMembers) {
    if (visibleMembers.isEmpty) {
      return _members.first;
    }
    if (_selectedMemberName == null) {
      return visibleMembers.first;
    }
    for (final member in visibleMembers) {
      if (member.name == _selectedMemberName) {
        return member;
      }
    }
    return visibleMembers.first;
  }
}

class _MapLayer extends StatelessWidget {
  const _MapLayer({
    required this.members,
    required this.mapCenter,
    required this.mapKey,
    required this.onSelectMember,
  });

  final List<_MapMember> members;
  final LatLng mapCenter;
  final Key mapKey;
  final ValueChanged<String> onSelectMember;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: FlutterMap(
            key: mapKey,
            options: MapOptions(
              initialCenter: mapCenter,
              initialZoom: 12.7,
              minZoom: 3,
              maxZoom: 18,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.familyguard.app',
              ),
              CircleLayer(
                circles: members
                    .map(
                      (member) => CircleMarker(
                        point: member.location,
                        radius: 52,
                        color: const Color(0x4417E8E8),
                        borderColor: const Color(0x6617E8E8),
                        borderStrokeWidth: 1,
                        useRadiusInMeter: false,
                      ),
                    )
                    .toList(),
              ),
              MarkerLayer(
                markers: members
                    .map(
                      (member) => Marker(
                        point: member.location,
                        width: 76,
                        height: 98,
                        alignment: Alignment.topCenter,
                        child: GestureDetector(
                          onTap: () => onSelectMember(member.name),
                          child: _MemberMarker(
                            name: member.name,
                            avatarUrl: member.avatarUrl,
                            borderColor: member.markerBorderColor,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(40.7218, -74.0020),
                    width: 16,
                    height: 16,
                    alignment: Alignment.center,
                    child: _CenterMapDot(),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Container(
            color: const Color(0x6617E8E8),
          ),
        ),
        Positioned(
          right: 14,
          bottom: 286,
          child: Column(
            children: [
              _MapActionButton(
                icon: Icons.gps_fixed,
                onTap: () {},
              ),
              const SizedBox(height: 10),
              _MapActionButton(
                icon: Icons.layers_outlined,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

enum _MemberFilter {
  all,
  children,
  adults,
  seniors,
}

class _TopControls extends StatelessWidget {
  const _TopControls({required this.selected, required this.onChanged});

  final _MemberFilter selected;
  final ValueChanged<_MemberFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(999),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  _FilterPill(
                    label: 'Tất cả',
                    selected: selected == _MemberFilter.all,
                    onTap: () => onChanged(_MemberFilter.all),
                  ),
                  _FilterPill(
                    label: 'Trẻ em',
                    selected: selected == _MemberFilter.children,
                    onTap: () => onChanged(_MemberFilter.children),
                  ),
                  _FilterPill(
                    label: 'Ng.Lớn',
                    selected: selected == _MemberFilter.adults,
                    onTap: () => onChanged(_MemberFilter.adults),
                  ),
                  _FilterPill(
                    label: 'Ng.Già',
                    selected: selected == _MemberFilter.seniors,
                    onTap: () => onChanged(_MemberFilter.seniors),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings, size: 21, color: Color(0xFF334155)),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterPill extends StatelessWidget {
  const _FilterPill({
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          height: 36,
          margin: const EdgeInsets.symmetric(horizontal: 1),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF04D1D4) : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: selected ? const Color(0xFF0F172A) : const Color(0xFF64748B),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}

class _MemberMarker extends StatelessWidget {
  const _MemberMarker({
    required this.name,
    required this.avatarUrl,
    required this.borderColor,
  });

  final String name;
  final String avatarUrl;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 3),
            image: DecorationImage(
              image: NetworkImage(avatarUrl),
              fit: BoxFit.cover,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: null,
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.94),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            name,
            style: GoogleFonts.inter(
              color: const Color(0xFF0F172A),
              fontSize: 13,
              fontWeight: FontWeight.w600,
              height: 1,
            ),
          ),
        ),
      ],
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
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95),
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 22, color: const Color(0xFF475569)),
      ),
    );
  }
}

class _CenterMapDot extends StatelessWidget {
  const _CenterMapDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }
}

class _MapMember {
  const _MapMember({
    required this.name,
    required this.role,
    required this.battery,
    required this.subtitle,
    required this.distanceLabel,
    required this.activityIcon,
    required this.markerBorderColor,
    required this.location,
    required this.avatarUrl,
  });

  final String name;
  final _MemberFilter role;
  final int battery;
  final String subtitle;
  final String distanceLabel;
  final IconData activityIcon;
  final Color markerBorderColor;
  final LatLng location;
  final String avatarUrl;
}

class _BottomSheetAndNav extends StatelessWidget {
  const _BottomSheetAndNav({required this.selectedMember});

  final _MapMember selectedMember;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x2600ADB2),
            blurRadius: 40,
            offset: Offset(0, -10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _BottomSheetContent(selectedMember: selectedMember),
          const _BottomNavigationBar(),
        ],
      ),
    );
  }
}

class _BottomSheetContent extends StatelessWidget {
  const _BottomSheetContent({required this.selectedMember});

  final _MapMember selectedMember;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF0F8F7),
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
        mainAxisSize: MainAxisSize.min,
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
                _selectedAvatar(selectedMember.avatarUrl, selectedMember.activityIcon),
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
                                  selectedMember.name,
                                  style: GoogleFonts.inter(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                    height: 1,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  _twoLineSubtitle(selectedMember.subtitle),
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF64748B),
                                    height: 1.3,
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
                                const Icon(Icons.battery_charging_full, size: 14, color: Color(0xFF64748B)),
                                const SizedBox(width: 4),
                                Text(
                                  '${selectedMember.battery}%',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF334155),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    height: 1,
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
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  elevation: 1,
                                  backgroundColor: const Color(0xFF01ADB2),
                                  foregroundColor: Colors.white,
                                  shape: const StadiumBorder(),
                                  textStyle: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                child: const Text('Xem chi tiết'),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          _circleIconButton(Icons.call_outlined),
                          const SizedBox(width: 8),
                          _circleIconButton(Icons.chat_bubble_outline),
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
              border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _StatChip(
                    title: 'Lần cuối cập nhật',
                    value: 'Ngay bây giờ',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatChip(
                    title: 'Khoảng cách',
                    value: selectedMember.distanceLabel,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _twoLineSubtitle(String subtitle) {
    if (subtitle.length <= 23) {
      return subtitle;
    }
    final splitAt = subtitle.lastIndexOf(' ', 23);
    if (splitAt <= 0 || splitAt >= subtitle.length - 1) {
      return subtitle;
    }
    return '${subtitle.substring(0, splitAt)}\n${subtitle.substring(splitAt + 1)}';
  }

  Widget _selectedAvatar(String avatarUrl, IconData activityIcon) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF17E8E8), width: 2, style: BorderStyle.solid),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Image.network(
              avatarUrl,
              fit: BoxFit.cover,
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
              color: const Color(0xFF22C55E),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Icon(activityIcon, size: 12, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _circleIconButton(IconData icon) {
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

class _StatChip extends StatelessWidget {
  const _StatChip({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(48),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              color: const Color(0xFF64748B),
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(
              color: const Color(0xFF0F172A),
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1,
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
