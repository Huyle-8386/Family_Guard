import 'package:family_guard/core/constants/app_routes.dart';
import 'package:family_guard/features/member_management/presentation/models/member_management_demo_data.dart';
import 'package:family_guard/features/tracking/presentation/screens/member_tracking/member_tracking_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberDetailFigmaScreen extends StatelessWidget {
  const MemberDetailFigmaScreen({
    super.key,
    required this.member,
  });

  final MemberManagementMember member;

  @override
  Widget build(BuildContext context) {
    final personalInfo = [
      _InfoRowData(label: 'Tên', value: member.name),
      _InfoRowData(label: 'SĐT', value: member.phoneNumber),
      _InfoRowData(label: 'Quan hệ', value: member.relation),
    ];

    final zones = [
      const _ZoneRowData(name: 'Nhà', isSafe: true),
      _ZoneRowData(name: member.address, isSafe: !member.invitationPending),
      _ZoneRowData(name: 'Trường học / Điểm đến', isSafe: member.role == MemberRole.child),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF0F8F7),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 402),
            child: Column(
              children: [
                _TopBar(
                  onBack: () => Navigator.maybePop(context),
                  onEdit: () => Navigator.pushNamed(
                    context,
                    AppRoutes.addMember,
                    arguments: AddMemberFlowArgs.edit(member),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(6, 9, 6, 24),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _ProfileCard(
                            member: member,
                            onViewLocation: () => _openLocation(context, member),
                            onCallTap: () => Navigator.pushNamed(
                              context,
                              AppRoutes.inAppCall,
                              arguments: member.inAppCallArgs,
                            ),
                            onChatTap: () => Navigator.pushNamed(
                              context,
                              AppRoutes.chatConversation,
                              arguments: member.chatThreadArgs,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _SectionCard(
                            title: 'Thông tin cá nhân',
                            leadingIcon: Icons.person_outline_rounded,
                            child: Column(
                              children: [
                                for (int i = 0; i < personalInfo.length; i++)
                                  _DataLine(
                                    data: personalInfo[i],
                                    isLast: i == personalInfo.length - 1,
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _SectionCard(
                            title: 'Vùng an toàn',
                            leadingIcon: Icons.location_on,
                            child: Column(
                              children: [
                                for (int i = 0; i < zones.length; i++)
                                  _ZoneLine(
                                    data: zones[i],
                                    isLast: i == zones.length - 1,
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _LocationHistoryCard(
                            trackingArgs: member.trackingArgs,
                            onReviewTap: () => Navigator.pushNamed(
                              context,
                              AppRoutes.routePlayback,
                              arguments: member.trackingArgs,
                            ),
                            onLocateTap: () => _openLocation(context, member),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _DeviceInfoCard(member: member),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () => _confirmDelete(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFB9DDE0),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                              ),
                              child: Text(
                                'Xóa Thành Viên',
                                style: GoogleFonts.beVietnamPro(
                                  color: const Color(0xFFA24814),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void _openLocation(BuildContext context, MemberManagementMember member) {
    switch (member.role) {
      case MemberRole.child:
        Navigator.pushNamed(context, AppRoutes.kidManagement);
        return;
      case MemberRole.adult:
        Navigator.pushNamed(
          context,
          AppRoutes.adultMemberDetail,
          arguments: member.trackingArgs,
        );
        return;
      case MemberRole.senior:
        Navigator.pushNamed(
          context,
          AppRoutes.seniorMemberDetail,
          arguments: member.trackingArgs,
        );
        return;
    }
  }

  static Future<void> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Xóa thành viên'),
          content: const Text('Đây là flow mô phỏng. Bạn muốn đóng màn chi tiết này?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Hủy'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Xác nhận'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !context.mounted) {
      return;
    }

    Navigator.maybePop(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Đã đóng flow xóa thành viên mô phỏng'),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.onBack,
    required this.onEdit,
  });

  final VoidCallback onBack;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            IconButton(
              onPressed: onBack,
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF00A5AB),
                size: 20,
              ),
              padding: EdgeInsets.zero,
              splashRadius: 20,
            ),
            const Spacer(),
            InkWell(
              onTap: onEdit,
              borderRadius: BorderRadius.circular(999),
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: Color(0xFF00AEB3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit_outlined, size: 14, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    required this.member,
    required this.onViewLocation,
    required this.onCallTap,
    required this.onChatTap,
  });

  final MemberManagementMember member;
  final VoidCallback onViewLocation;
  final VoidCallback onCallTap;
  final VoidCallback onChatTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(38),
      ),
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF7ECFD0), width: 4),
            ),
            child: ClipOval(
              child: Image.network(
                member.avatarUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFFE2E8F0),
                  alignment: Alignment.center,
                  child: const Icon(Icons.person, color: Color(0xFF64748B), size: 40),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  member.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1D2128),
                    height: 1,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFA8DADC),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  member.roleChipLabel,
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF3B5860),
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  color: member.invitationPending
                      ? const Color(0xFF94A3B8)
                      : const Color(0xFF00837F),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                member.status,
                style: GoogleFonts.beVietnamPro(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF323A3F),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 54,
                  child: ElevatedButton(
                    onPressed: onViewLocation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF07AEB3),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(27),
                      ),
                    ),
                    child: Text(
                      'Xem Vị Trí',
                      style: GoogleFonts.beVietnamPro(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              _RoundIconButton(icon: Icons.call_outlined, onTap: onCallTap),
              const SizedBox(width: 14),
              _RoundIconButton(
                icon: Icons.chat_bubble_outline_rounded,
                onTap: onChatTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 58,
        height: 58,
        decoration: const BoxDecoration(
          color: Color(0xFFE3E8EC),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: const Color(0xFF00A5AB), size: 22),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.leadingIcon,
    required this.child,
  });

  final String title;
  final IconData leadingIcon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(38),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(leadingIcon, size: 22, color: const Color(0xFF007E84)),
              const SizedBox(width: 10),
              Text(
                title,
                style: GoogleFonts.beVietnamPro(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1D2128),
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

class _DataLine extends StatelessWidget {
  const _DataLine({required this.data, required this.isLast});

  final _InfoRowData data;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: [
              Text(
                data.label,
                style: GoogleFonts.beVietnamPro(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF495056),
                ),
              ),
              const Spacer(),
              Text(
                data.value,
                style: GoogleFonts.beVietnamPro(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1F232A),
                ),
              ),
            ],
          ),
        ),
        if (!isLast) const Divider(height: 1, color: Color(0xFFECEFF1)),
      ],
    );
  }
}

class _ZoneLine extends StatelessWidget {
  const _ZoneLine({required this.data, required this.isLast});

  final _ZoneRowData data;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final chipBg = data.isSafe ? const Color(0xFFE6F7EF) : const Color(0xFFE6E7E8);
    final dotColor = data.isSafe ? const Color(0xFF10B981) : const Color(0xFF9AA0A6);
    final textColor = data.isSafe ? const Color(0xFF00895A) : const Color(0xFF7A8087);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  data.name,
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF3C4348),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: chipBg,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      data.isSafe ? 'Trong vùng an toàn' : 'Ngoài vùng an toàn',
                      style: GoogleFonts.beVietnamPro(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast) const Divider(height: 1, color: Color(0xFFECEFF1)),
      ],
    );
  }
}

class _LocationHistoryCard extends StatelessWidget {
  const _LocationHistoryCard({
    required this.trackingArgs,
    required this.onReviewTap,
    required this.onLocateTap,
  });

  final MemberTrackingArgs trackingArgs;
  final VoidCallback onReviewTap;
  final VoidCallback onLocateTap;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Lịch sử di chuyển',
      leadingIcon: Icons.pin_drop_outlined,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: onReviewTap,
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF3A5E66),
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 24),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              icon: const Icon(Icons.schedule_rounded, size: 13),
              label: Text(
                'Xem lại',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: SizedBox(
              height: 300,
              child: Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                      initialCenter: trackingArgs.mapCenter,
                      initialZoom: 13.9,
                      interactionOptions: const InteractionOptions(
                        flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                      ),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.family_guard.app',
                      ),
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: trackingArgs.routeHistory,
                            strokeWidth: 5,
                            color: const Color(0xFF45C7CE),
                          ),
                        ],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 34,
                            height: 34,
                            point: trackingArgs.routeHistory.last,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF3AC7C7),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 3),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x6642C8CD),
                                    blurRadius: 0,
                                    spreadRadius: 8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    left: 16,
                    top: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 9),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0D000000),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        trackingArgs.timeLabel,
                        style: GoogleFonts.beVietnamPro(
                          color: const Color(0xFF006A6A),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          height: 1.43,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: InkWell(
                      onTap: onLocateTap,
                      borderRadius: BorderRadius.circular(999),
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: const BoxDecoration(
                          color: Color(0xFF007F84),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x33000000),
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.my_location_rounded, color: Colors.white, size: 28),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeviceInfoCard extends StatelessWidget {
  const _DeviceInfoCard({required this.member});

  final MemberManagementMember member;

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Thông tin thiết bị',
      leadingIcon: Icons.smartphone_outlined,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _DeviceMetricCard(
                  label: 'PIN',
                  icon: Icons.battery_5_bar_rounded,
                  value: '${member.batteryPercent}%',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _DeviceMetricCard(
                  label: 'KẾT NỐI',
                  icon: Icons.wifi_rounded,
                  value: member.presenceLabel,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: _DeviceTextBlock(
                    label: 'Thiết bị',
                    value: member.deviceName,
                    alignRight: false,
                  ),
                ),
                Expanded(
                  child: _DeviceTextBlock(
                    label: 'Lần cuối hoạt động',
                    value: member.lastActive,
                    alignRight: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DeviceMetricCard extends StatelessWidget {
  const _DeviceMetricCard({
    required this.label,
    required this.icon,
    required this.value,
  });

  final String label;
  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F5F7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.beVietnamPro(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF6A747B),
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(icon, color: const Color(0xFF007F84), size: 20),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.beVietnamPro(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1D2229),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DeviceTextBlock extends StatelessWidget {
  const _DeviceTextBlock({
    required this.label,
    required this.value,
    required this.alignRight,
  });

  final String label;
  final String value;
  final bool alignRight;

  @override
  Widget build(BuildContext context) {
    final alignment = alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          label,
          style: GoogleFonts.beVietnamPro(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF5A646B),
          ),
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.beVietnamPro(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1D2229),
          ),
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
        ),
      ],
    );
  }
}

class _InfoRowData {
  const _InfoRowData({required this.label, required this.value});

  final String label;
  final String value;
}

class _ZoneRowData {
  const _ZoneRowData({required this.name, required this.isSafe});

  final String name;
  final bool isSafe;
}
