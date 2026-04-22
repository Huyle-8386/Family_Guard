import 'package:family_guard/core/constants/app_routes.dart';
import 'package:family_guard/core/widgets/app_bottom_menu.dart';
import 'package:family_guard/features/kid_management/presentation/screens/kid_device_control_screen.dart';
import 'package:family_guard/features/tracking/presentation/screens/member_tracking/member_tracking_models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _backgroundColor = Color(0xFFF0F8F7);
  static const _primaryColor = Color(0xFF00ACB2);
  static const _secondaryColor = Color(0xFF87E4DB);
  static const _headerAvatarUrl =
      'https://www.figma.com/api/mcp/asset/2f585926-b307-4889-9fd8-50f79d086344';

  static final List<_MemberCardData> _members = [
    _MemberCardData(
      name: 'Mẹ',
      status: 'Đang ở nhà',
      battery: '85%',
      location: '123 Đường Nguyễn Huệ...',
      avatarUrl:
          'https://www.figma.com/api/mcp/asset/09129163-8902-4a06-b810-2bec557a806e',
      mapImageUrl:
          'https://www.figma.com/api/mcp/asset/377b4370-a162-4432-b61e-7545f1fb1039',
      statusDotColor: const Color(0xFF22C55E),
      statusTextColor: const Color(0xFF008A8E),
      accentColor: const Color(0xFF00ACB2),
      batteryIcon: Icons.battery_full_rounded,
      locationIcon: Icons.location_on_rounded,
      locationIconColor: const Color(0xFF008A8E),
      locationIconBackground: const Color(0x4D87E4DB),
      routeName: AppRoutes.adultMemberDetail,
      trackingArgs: MemberTrackingArgs(
        role: MemberRole.adult,
        name: 'Mẹ',
        status: 'Đang ở nhà',
        avatarUrl:
            'https://www.figma.com/api/mcp/asset/09129163-8902-4a06-b810-2bec557a806e',
        phoneNumber: '+84 909 123 456',
        relationship: 'Mẹ',
        battery: 85,
        connectionStatus: 'Trực tuyến',
        deviceName: 'iPhone 13',
        lastActive: '1 phút trước',
        timeLabel: '08:42 AM',
        mapCenter: const LatLng(16.0544, 108.2022),
        routeHistory: const [
          LatLng(16.0528, 108.1988),
          LatLng(16.0533, 108.1998),
          LatLng(16.0539, 108.2007),
          LatLng(16.0544, 108.2015),
          LatLng(16.0544, 108.2022),
        ],
        playbackStartLabel: '08:00 AM',
        playbackEndLabel: '04:30 PM',
        totalDistanceLabel: '1.8 km',
        totalDurationLabel: '1h 20m',
        stopCount: 2,
        averageSpeedLabel: '1.5 km/h',
        timelineItems: const [
          TrackingTimelineItem(timeLabel: '08:00 AM', title: 'Ở nhà'),
          TrackingTimelineItem(timeLabel: '09:10 AM', title: 'Ra chợ gần nhà'),
          TrackingTimelineItem(
            timeLabel: '10:20 AM',
            title: 'Đã về nhà',
            highlighted: true,
          ),
        ],
      ),
    ),
    _MemberCardData(
      name: 'Bố',
      status: 'Đang đi dạo',
      battery: '24%',
      location: 'Công viên Tao Đàn',
      avatarUrl:
          'https://www.figma.com/api/mcp/asset/5e8718f5-141a-45c5-9a6f-b47576bb2bc4',
      mapImageUrl:
          'https://www.figma.com/api/mcp/asset/5ecd790f-6840-4bcd-aef9-7210007ea537',
      statusDotColor: const Color(0xFFEAB308),
      statusTextColor: const Color(0xFF374151),
      accentColor: const Color(0xFF111827),
      batteryIcon: Icons.battery_alert_rounded,
      batteryColor: const Color(0xFFCA8A04),
      locationIcon: Icons.park_rounded,
      locationIconColor: const Color(0xFF2563EB),
      locationIconBackground: const Color(0xFFDBEAFE),
      routeName: AppRoutes.adultMemberDetail,
      trackingArgs: MemberTrackingArgs(
        role: MemberRole.adult,
        name: 'Bố',
        status: 'Đang đi dạo',
        avatarUrl:
            'https://www.figma.com/api/mcp/asset/5e8718f5-141a-45c5-9a6f-b47576bb2bc4',
        phoneNumber: '+84 909 456 123',
        relationship: 'Bố',
        battery: 24,
        connectionStatus: 'Trực tuyến',
        deviceName: 'iPhone 15 Pro',
        lastActive: '3 phút trước',
        timeLabel: '08:42 AM',
        mapCenter: const LatLng(16.0560, 108.2040),
        routeHistory: const [
          LatLng(16.0581, 108.2062),
          LatLng(16.0574, 108.2056),
          LatLng(16.0569, 108.2050),
          LatLng(16.0564, 108.2044),
          LatLng(16.0560, 108.2040),
        ],
        playbackStartLabel: '08:00 AM',
        playbackEndLabel: '04:30 PM',
        totalDistanceLabel: '3.2 km',
        totalDurationLabel: '2h 15m',
        stopCount: 1,
        averageSpeedLabel: '2.8 km/h',
        timelineItems: const [
          TrackingTimelineItem(timeLabel: '08:00 AM', title: 'Rời nhà'),
          TrackingTimelineItem(timeLabel: '08:45 AM', title: 'Đến công viên'),
          TrackingTimelineItem(
            timeLabel: '09:30 AM',
            title: 'Đang đi dạo',
            highlighted: true,
          ),
        ],
      ),
    ),
  ];

  static final List<_QuickActionData> _quickActions = [
    _QuickActionData(
      title: 'Thành viên',
      subtitle: 'Quản lí thành viên',
      icon: Icons.home_rounded,
      iconColor: const Color(0xFF0EA5A8),
      glowColor: const Color(0x3387E4DB),
      onTapRouteName: AppRoutes.memberList,
    ),
    _QuickActionData(
      title: 'Tâm trạng',
      subtitle: 'Nhật ký hôm nay',
      icon: Icons.sentiment_satisfied_alt_rounded,
      iconColor: const Color(0xFFF97316),
      glowColor: const Color(0x33FED7AA),
      onTapRouteName: AppRoutes.emotionJournal,
    ),
    _QuickActionData(
      title: 'An toàn',
      subtitle: 'Thiết lập vùng',
      icon: Icons.shield_rounded,
      iconColor: const Color(0xFFD946EF),
      glowColor: const Color(0x33F5D0FE),
      onTapRouteName: AppRoutes.safeZone,
    ),
    _QuickActionData(
      title: 'Lịch nhắc',
      subtitle: 'Nhắc nhở hằng ngày',
      icon: Icons.alarm_rounded,
      iconColor: const Color(0xFF3B82F6),
      glowColor: const Color(0x33BFDBFE),
      onTapRouteName: AppRoutes.checkinReminder,
    ),
    _QuickActionData(
      title: 'Camera',
      subtitle: 'Giám sát phát hiện',
      icon: Icons.videocam_rounded,
      iconColor: const Color(0xFF10B981),
      glowColor: const Color(0x33A7F3D0),
      onTap: _showCameraComingSoon,
    ),
    _QuickActionData(
      title: 'Nhịp tim',
      subtitle: 'Theo dõi chỉ số tim',
      icon: Icons.monitor_heart_rounded,
      iconColor: const Color(0xFFEF4444),
      glowColor: const Color(0x33FECACA),
      onTapRouteName: AppRoutes.emotionPulse,
    ),
    _QuickActionData(
      title: 'Quản Lí Ứng Dụng',
      subtitle: 'Thời gian, khu vực,...',
      icon: Icons.tune_rounded,
      iconColor: const Color(0xFF475569),
      glowColor: const Color(0x33CBD5E1),
      builder: _buildKidDeviceControlScreen,
    ),
    _QuickActionData(
      title: 'Tin nhắn',
      subtitle: 'Trò chuyện',
      icon: Icons.message_rounded,
      iconColor: const Color(0xFF6366F1),
      glowColor: const Color(0x33C7D2FE),
      onTapRouteName: AppRoutes.chatList,
    ),
  ];

  static Widget _buildKidDeviceControlScreen() =>
      const KidDeviceControlScreen();

  static void _showCameraComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Chức năng camera đang được phát triển.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Stack(
              children: [
                const Positioned.fill(child: _TopDecoration()),
                Positioned.fill(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 132),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        const _Header(),
                        const SizedBox(height: 26),
                        _MemberCardsSection(members: _members),
                        const SizedBox(height: 22),
                        Text(
                          'Tiện ích',
                          style: GoogleFonts.publicSans(
                            color: _primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            height: 28 / 18,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _QuickActionsGrid(actions: _quickActions),
                      ],
                    ),
                  ),
                ),
                const Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: AppBottomMenu(current: AppNavTab.home),
                ),
              ],
            ),
          ),
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
            right: -170,
            child: Container(
              width: 342,
              height: 337,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF00D4DA).withValues(alpha: 0.88),
              ),
            ),
          ),
          Positioned(
            top: -78,
            right: -120,
            child: Container(
              width: 270,
              height: 270,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF009EA7).withValues(alpha: 0.78),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Chào buổi tối,\nHuy',
          style: GoogleFonts.beVietnamPro(
            color: const Color(0xFF00ACB2),
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 32 / 24,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
          child: Container(
            width: 48,
            height: 48,
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
            child: ClipOval(
              child: Image.network(
                HomePage._headerAvatarUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFE5E7EB),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.person_rounded,
                      color: Color(0xFF4B5563),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MemberCardsSection extends StatelessWidget {
  const _MemberCardsSection({required this.members});

  final List<_MemberCardData> members;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 244,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: members.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final member = members[index];
          return _MemberCard(data: member, faded: index != 0);
        },
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({required this.data, required this.faded});

  final _MemberCardData data;
  final bool faded;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: faded ? 0.82 : 1,
      child: Container(
        width: 331.5,
        decoration: BoxDecoration(
          color: faded ? Colors.white : const Color(0x1AFFFFFF),
          borderRadius: BorderRadius.circular(24),
          border: faded ? Border.all(color: const Color(0xFFF3F4F6)) : null,
          boxShadow: const [
            BoxShadow(
              color: Color(0x2600ADB2),
              blurRadius: 40,
              spreadRadius: -10,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  data.mapImageUrl,
                  fit: BoxFit.cover,
                  opacity: const AlwaysStoppedAnimation(0.6),
                  errorBuilder: (context, error, stackTrace) {
                    return Container(color: const Color(0xFFF4F8F7));
                  },
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(alpha: 0.12),
                        Colors.white.withValues(alpha: 0.70),
                        Colors.white,
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  child: ClipOval(
                                    child: Image.network(
                                      data.avatarUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return Container(
                                              color: const Color(0xFFE5E7EB),
                                              alignment: Alignment.center,
                                              child: const Icon(
                                                Icons.person_rounded,
                                                color: Color(0xFF6B7280),
                                              ),
                                            );
                                          },
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: -1,
                                  bottom: -1,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: data.statusDotColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2,
                                      ),
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
                                  data.name,
                                  style: GoogleFonts.publicSans(
                                    color: data.accentColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    height: 28 / 20,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.82),
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
                                          color: data.statusDotColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        data.status,
                                        style: GoogleFonts.publicSans(
                                          color: data.statusTextColor,
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
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.70),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                data.batteryIcon,
                                size: 18,
                                color: data.batteryColor ?? data.accentColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                data.battery,
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
                    const Spacer(),
                    InkWell(
                      borderRadius: BorderRadius.circular(40),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          data.routeName,
                          arguments: data.trackingArgs,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(17),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
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
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: data.locationIconBackground,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                data.locationIcon,
                                color: data.locationIconColor,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Vị trí hiện tại',
                                    style: GoogleFonts.publicSans(
                                      color: const Color(0xFF6B7280),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      height: 16 / 12,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    data.location,
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
                            const SizedBox(width: 8),
                            Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                color: Color(0xFFF3F4F6),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 18,
                                color: Color(0xFF4B5563),
                              ),
                            ),
                          ],
                        ),
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
}

class _QuickActionsGrid extends StatelessWidget {
  const _QuickActionsGrid({required this.actions});

  final List<_QuickActionData> actions;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: actions.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 165 / 172,
      ),
      itemBuilder: (context, index) {
        final item = actions[index];
        return _QuickActionCard(data: item);
      },
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({required this.data});

  final _QuickActionData data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(40),
      onTap: () {
        final onTap = data.onTap;
        if (onTap != null) {
          onTap(context);
          return;
        }
        if (data.onTapRouteName != null) {
          Navigator.pushNamed(context, data.onTapRouteName!);
          return;
        }
        final builder = data.builder;
        if (builder != null) {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => builder()));
        }
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: HomePage._secondaryColor, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: HomePage._secondaryColor),
                boxShadow: [
                  BoxShadow(
                    color: data.glowColor,
                    blurRadius: 14,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(data.icon, color: data.iconColor, size: 22),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    data.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.publicSans(
                      color: const Color(0xFF1F2937),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      height: 22 / 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    data.subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.publicSans(
                      color: const Color(0xFF6B7280),
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      height: 15 / 11,
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

class _MemberCardData {
  const _MemberCardData({
    required this.name,
    required this.status,
    required this.battery,
    required this.location,
    required this.avatarUrl,
    required this.mapImageUrl,
    required this.statusDotColor,
    required this.statusTextColor,
    required this.accentColor,
    required this.batteryIcon,
    required this.locationIcon,
    required this.locationIconColor,
    required this.locationIconBackground,
    required this.routeName,
    required this.trackingArgs,
    this.batteryColor,
  });

  final String name;
  final String status;
  final String battery;
  final String location;
  final String avatarUrl;
  final String mapImageUrl;
  final Color statusDotColor;
  final Color statusTextColor;
  final Color accentColor;
  final IconData batteryIcon;
  final Color? batteryColor;
  final IconData locationIcon;
  final Color locationIconColor;
  final Color locationIconBackground;
  final String routeName;
  final MemberTrackingArgs trackingArgs;
}

class _QuickActionData {
  const _QuickActionData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.glowColor,
    this.onTap,
    this.onTapRouteName,
    this.builder,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color glowColor;
  final void Function(BuildContext context)? onTap;
  final String? onTapRouteName;
  final Widget Function()? builder;
}
