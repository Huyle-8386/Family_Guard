import 'package:family_guard/core/constants/app_routes.dart';
import 'package:family_guard/core/widgets/app_back_header.dart';
import 'package:family_guard/features/member_management/presentation/models/member_management_demo_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThanhVienScreen extends StatelessWidget {
  const ThanhVienScreen({super.key});

  static final List<_MemberItem> _members = [
    _MemberItem(member: memberManagementMemberById('child-xoi')),
    _MemberItem(member: memberManagementMemberById('senior-ba-noi')),
    _MemberItem(member: memberManagementMemberById('adult-bo-xoi')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F8F7),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const _TopAppBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 13, 24, 24),
                children: [
                  _SearchField(
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRoutes.memberSelection,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Thanh vien trong gia dinh',
                    style: GoogleFonts.beVietnamPro(
                      fontSize: 20,
                      height: 28 / 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 14),
                  ..._members.expand(
                    (member) => [
                      _MemberCard(
                        member: member,
                        onTap: () => Navigator.pushNamed(
                          context,
                          AppRoutes.memberDetails,
                          arguments: member.member,
                        ),
                      ),
                      const SizedBox(height: 14),
                    ],
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

class _TopAppBar extends StatelessWidget {
  const _TopAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBackHeaderBar(
      title: 'Danh sách thành viên',
      titleFontSize: 20,
      trailing: InkWell(
        onTap: () => Navigator.pushNamed(context, AppRoutes.addMember),
        borderRadius: BorderRadius.circular(999),
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF2DBCC2),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 24),
        ),
      ),
      trailingAreaWidth: 44,
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFE3E9E9),
      borderRadius: BorderRadius.circular(32),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(32),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 18),
          child: Row(
            children: [
              const Icon(Icons.search, size: 20, color: Color(0xFF6B7280)),
              const SizedBox(width: 10),
              Text(
                'Tim kiem thanh vien',
                style: GoogleFonts.beVietnamPro(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF6B7280),
                  height: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({required this.member, required this.onTap});

  final _MemberItem member;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(32),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(32),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Avatar(avatarUrl: member.member.avatarUrl),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          member.member.name,
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF171D1D),
                            height: 28 / 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              _resolveStatusIcon(member.member.status),
                              size: 14,
                              color: const Color(0xFF3C4949),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                member.member.status,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.beVietnamPro(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF3C4949),
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
                      Row(
                        children: [
                          const Icon(
                            Icons.battery_full,
                            size: 15,
                            color: Color(0xFF3C4949),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${member.member.batteryPercent}%',
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF3C4949),
                              height: 16 / 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Icon(
                        Icons.chevron_right,
                        color: Color(0xFFB8C5C5),
                        size: 18,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1, thickness: 1, color: Color(0xFFEFF5F4)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 15,
                          color: Color(0xFF3C4949),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            member.member.address,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.beVietnamPro(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF3C4949),
                              height: 16 / 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECFDF5),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xFF10B981),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Vung An Toan',
                          style: GoogleFonts.beVietnamPro(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF047857),
                            height: 1.5,
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
      ),
    );
  }

  IconData _resolveStatusIcon(String status) {
    final lower = status.toLowerCase();
    if (lower.contains('truong')) {
      return Icons.school_outlined;
    }
    if (lower.contains('nha')) {
      return Icons.home_outlined;
    }
    if (lower.contains('dao')) {
      return Icons.park_outlined;
    }
    return Icons.work_outline;
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.avatarUrl});

  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 56,
          height: 56,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: const Color(0xFFEFF5F4), width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: Image.network(
              avatarUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xFFE2E8F0),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.person,
                  size: 24,
                  color: Color(0xFF64748B),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: -1,
          bottom: -1,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: const Color(0xFF01ADB2),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class _MemberItem {
  const _MemberItem({required this.member});

  final MemberManagementMember member;
}



