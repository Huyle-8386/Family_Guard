import 'package:flutter/material.dart';
import 'package:family_guard/core/widgets/buttons/app_button.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberSelectionScreen extends StatefulWidget {
  const MemberSelectionScreen({super.key});

  @override
  State<MemberSelectionScreen> createState() => _MemberSelectionScreenState();
}

class _MemberSelectionScreenState extends State<MemberSelectionScreen> {
  int selectedIndex = 0;

  final members = const [
    _MemberData(
      name: 'Mẹ',
      statusText: 'Trực tuyến',
      statusColor: Color(0xFF22C55E),
      avatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&q=80',
    ),
    _MemberData(
      name: 'Bố',
      statusText: 'Hoạt động 5p trước',
      statusColor: Color(0xFF22C55E),
      avatarUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200&q=80',
    ),
    _MemberData(
      name: 'Ông Nội',
      statusText: 'Ngoại tuyến 2h',
      statusColor: Color(0xFF94A3B8),
      avatarUrl: 'https://images.unsplash.com/photo-1504593811423-6dd665756598?w=200&q=80',
    ),
    _MemberData(
      name: 'Bé Chíp',
      statusText: 'Trực tuyến',
      statusColor: Color(0xFF22C55E),
      avatarUrl: 'https://images.unsplash.com/photo-1519345182560-3f2917c472ef?w=200&q=80',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F8F7),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _Header(onClose: () => Navigator.maybePop(context)),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 160),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vui lòng chọn thành viên bạn muốn tạo hỏi thăm',
                          style: GoogleFonts.beVietnamPro(
                            color: const Color(0xFF64748B),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 20 / 16,
                          ),
                        ),
                        const SizedBox(height: 16),
                        GridView.builder(
                          itemCount: members.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 16,
                            childAspectRatio: 179 / 184,
                          ),
                          itemBuilder: (context, index) {
                            final member = members[index];
                            return _MemberCard(
                              data: member,
                              isSelected: index == selectedIndex,
                              onTap: () => setState(() => selectedIndex = index),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 26, 20, 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x00F5F8F8),
                      Color(0xF2F5F8F8),
                      Color(0xFFF5F8F8),
                    ],
                    stops: [0, 0.5, 1],
                  ),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: AppPrimaryButton(
                    label: 'Xác nhận',
                    onPressed: () {},
                    borderRadius: 999,
                    height: 56,
                    backgroundColor: const Color(0xFF00ADB2),
                    textStyle: GoogleFonts.beVietnamPro(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 28 / 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 73,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xE6F5F8F8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 12,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Chọn thành viên',
            style: GoogleFonts.publicSans(
              color: const Color(0xFF00ADB2),
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.6,
              height: 32 / 24,
            ),
          ),
          InkWell(
            onTap: onClose,
            borderRadius: BorderRadius.circular(999),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: const Icon(Icons.close, size: 20, color: Color(0xFF64748B)),
            ),
          ),
        ],
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({
    required this.data,
    required this.isSelected,
    required this.onTap,
  });

  final _MemberData data;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isSelected ? const Color(0xFF00ADB2) : const Color(0xFF87E4DB),
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? const Color(0x4D00ACB1)
                      : const Color(0x0D000000),
                  blurRadius: isSelected ? 15 : 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? const Color(0x3300ADB2)
                                : const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: ClipOval(
                          child: Image.network(
                            data.avatarUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: const Color(0xFFE2E8F0),
                              alignment: Alignment.center,
                              child: const Icon(Icons.person, color: Color(0xFF64748B)),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 4,
                        bottom: 4,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: data.statusColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    data.name,
                    style: GoogleFonts.publicSans(
                      color: const Color(0xFF0F172A),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 28 / 18,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: data.statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          data.statusText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.beVietnamPro(
                            color: data.statusColor == const Color(0xFF94A3B8)
                                ? const Color(0xFF94A3B8)
                                : const Color(0xFF64748B),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            height: 16 / 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isSelected)
            Positioned(
              right: -1,
              top: -1,
              child: Container(
                width: 18,
                height: 16,
                decoration: const BoxDecoration(
                  color: Color(0xFF00ADB2),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: const Icon(Icons.check, size: 11, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}

class _MemberData {
  const _MemberData({
    required this.name,
    required this.statusText,
    required this.statusColor,
    required this.avatarUrl,
  });

  final String name;
  final String statusText;
  final Color statusColor;
  final String avatarUrl;
}
