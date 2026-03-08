import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCCEFF0),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 36, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _TopBackHeader(),
                  SizedBox(height: 16),
                  _AvatarEditor(),
                  SizedBox(height: 24),
                  _InfoCard(),
                  SizedBox(height: 24),
                  _EmergencyContactSection(),
                  SizedBox(height: 20),
                  _MetaInfo(),
                  SizedBox(height: 16),
                  _ActionButtons(),
                  SizedBox(height: 16),
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

class _TopBackHeader extends StatelessWidget {
  const _TopBackHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                  style: GoogleFonts.beVietnamPro(
                    color: const Color(0xFF17E8E8),
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Thông Tin Cá Nhân',
          style: GoogleFonts.beVietnamPro(
            color: const Color(0xFF111818),
            fontSize: 48,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.85,
            height: 1,
          ),
        ),
      ],
    );
  }
}

class _AvatarEditor extends StatelessWidget {
  const _AvatarEditor();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 112,
                height: 112,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://images.unsplash.com/photo-1560250097-0b93528c311a?w=300&q=80',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(color: const Color(0xFFE5E7EB)),
                  ),
                ),
              ),
              Positioned(
                right: 8,
                bottom: 8,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          Text(
            'Thay đổi ảnh',
            style: GoogleFonts.beVietnamPro(
              color: const Color(0xFF17E8E8),
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: const [
          _DataRow(label: 'Họ & Tên', value: 'Trần Như Kha'),
          _RowDivider(),
          _DataRow(label: 'Email', value: 'alex.johnson@email.com', faded: true),
          _RowDivider(),
          _DataRow(label: 'Điện thoại', value: '0123 456 789'),
          _RowDivider(),
          _RoleRow(),
        ],
      ),
    );
  }
}

class _EmergencyContactSection extends StatelessWidget {
  const _EmergencyContactSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'LIÊN HỆ KHẨN CẤP',
            style: GoogleFonts.beVietnamPro(
              color: const Color(0xFF638888),
              fontSize: 13,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.325,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            children: const [
              _DataRow(label: 'Tên', value: 'Trần Như Kha'),
              _RowDivider(),
              _DropdownRow(label: 'Quan hệ', value: 'Vợ/Chồng'),
              _RowDivider(),
              _DataRow(label: 'Điện thoại', value: '0123 456 789'),
            ],
          ),
        ),
      ],
    );
  }
}

class _MetaInfo extends StatelessWidget {
  const _MetaInfo();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            'Tài khoản tạo ngày 27/10/2025',
            textAlign: TextAlign.center,
            style: GoogleFonts.beVietnamPro(
              color: const Color(0xFF638888),
              fontSize: 13,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
          Text(
            'Đã liên kết với 4 thành viên',
            textAlign: TextAlign.center,
            style: GoogleFonts.beVietnamPro(
              color: const Color(0xFF638888),
              fontSize: 13,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF17E8E8),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            'Lưu thay đổi',
            style: GoogleFonts.beVietnamPro(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w700,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Hủy',
            style: GoogleFonts.beVietnamPro(
              color: const Color(0xFFFF6B6B),
              fontSize: 17,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow({
    required this.label,
    required this.value,
    this.faded = false,
  });

  final String label;
  final String value;
  final bool faded;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 17),
      child: Row(
        children: [
          SizedBox(
            width: 106,
            child: Text(
              label,
              style: GoogleFonts.beVietnamPro(
                color: const Color(0xFF111818),
                fontSize: 17,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.beVietnamPro(
                color: faded ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
                fontSize: 17,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DropdownRow extends StatelessWidget {
  const _DropdownRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 17),
      child: Row(
        children: [
          SizedBox(
            width: 106,
            child: Text(
              label,
              style: GoogleFonts.beVietnamPro(
                color: const Color(0xFF111818),
                fontSize: 17,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  value,
                  style: GoogleFonts.beVietnamPro(
                    color: const Color(0xFF6B7280),
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.expand_more_rounded, color: Color(0xFF6B7280), size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleRow extends StatelessWidget {
  const _RoleRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          SizedBox(
            width: 106,
            child: Text(
              'Vai trò',
              style: GoogleFonts.beVietnamPro(
                color: const Color(0xFF111818),
                fontSize: 17,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'Người chăm sóc',
              style: GoogleFonts.beVietnamPro(
                color: const Color(0xFF4B5563),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 1, thickness: 1, color: Color(0xFFF3F4F6));
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      padding: const EdgeInsets.fromLTRB(9, 9, 9, 9),
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
