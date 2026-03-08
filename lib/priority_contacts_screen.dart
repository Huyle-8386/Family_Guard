import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PriorityContactsScreen extends StatefulWidget {
  const PriorityContactsScreen({super.key});

  @override
  State<PriorityContactsScreen> createState() => _PriorityContactsScreenState();
}

class _PriorityContactsScreenState extends State<PriorityContactsScreen> {
  final List<_PriorityContact> _contacts = [
    const _PriorityContact(
      name: 'Mẹ',
      subtitle: 'Lần cuối được ghi nhận: 5 phút trước · Tại nhà',
      avatarUrl: 'http://localhost:3845/assets/031d7b7bbeebfb8515afb8f1f848c77c4dc8cabc.png',
      autoCall: true,
      emergencyMessage: true,
      liveLocation: false,
    ),
    const _PriorityContact(
      name: 'Bố',
      subtitle: 'Trạng thái: Đang theo dõi',
      avatarUrl: 'http://localhost:3845/assets/6298d61b5af57fe690d4e522ba3e35c8a920281f.png',
      autoCall: true,
      emergencyMessage: true,
      liveLocation: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F8F8),
        body: SafeArea(
          child: Column(
            children: [
              const _PriorityTopBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Nhóm liên hệ khẩn cấp',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF0F172A),
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          height: 1.15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Quản lý những người sẽ được thông báo khi có tình huống khẩn cấp.',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF64748B),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: 22),
                      ...List.generate(_contacts.length, (index) {
                        final contact = _contacts[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: index == _contacts.length - 1 ? 0 : 18),
                          child: _PriorityContactCard(
                            contact: contact,
                            onChanged: (updated) {
                              setState(() => _contacts[index] = updated);
                            },
                          ),
                        );
                      }),
                      const SizedBox(height: 24),
                      const _PriorityEmptyState(),
                      const SizedBox(height: 24),
                      _AddContactButton(onTap: () {}),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const _PriorityBottomNav(),
      ),
    );
  }
}

class _PriorityTopBar extends StatelessWidget {
  const _PriorityTopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 73,
      color: const Color(0xFF75EFEF),
      foregroundDecoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0x1A299497), width: 1)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 9),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned.fill(
            child: SizedBox(),
          ),
          Align(
            alignment: const Alignment(0, 0.1),
            child: Text(
              'Danh bạ ưu tiên',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                color: const Color(0xFF045658),
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
                height: 1,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: const Icon(Icons.chevron_left_rounded, size: 26, color: Color(0xFF0F172A)),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(width: 48, height: 48),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings, size: 20, color: Color(0xFF0F172A)),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(width: 48, height: 48),
            ),
          ),
        ],
      ),
    );
  }
}

class _PriorityContactCard extends StatelessWidget {
  const _PriorityContactCard({required this.contact, required this.onChanged});

  final _PriorityContact contact;
  final ValueChanged<_PriorityContact> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(48),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: const [
          BoxShadow(color: Color(0x0D000000), blurRadius: 2, offset: Offset(0, 1)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: const Color(0x3300A8AD),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF00A8AD), width: 2),
                ),
                child: ClipOval(
                  child: Image.network(
                    contact.avatarUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFFE2E8F0),
                      alignment: Alignment.center,
                      child: Text(
                        contact.name.characters.first,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.name,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF0F172A),
                        fontSize: 36 / 2,
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      contact.subtitle,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF00A8AD),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFF8FAFC),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit_rounded, size: 16, color: Color(0xFF94A3B8)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _SettingToggleRow(
            icon: Icons.add_ic_call_outlined,
            label: 'Tự động gọi',
            value: contact.autoCall,
            onChanged: (v) => onChanged(contact.copyWith(autoCall: v)),
          ),
          const SizedBox(height: 16),
          _SettingToggleRow(
            icon: Icons.chat_bubble_outline_rounded,
            label: 'Tin nhắn khẩn cấp',
            value: contact.emergencyMessage,
            onChanged: (v) => onChanged(contact.copyWith(emergencyMessage: v)),
          ),
          const SizedBox(height: 16),
          _SettingToggleRow(
            icon: Icons.location_on_outlined,
            label: 'Vị trí trực tiếp',
            value: contact.liveLocation,
            onChanged: (v) => onChanged(contact.copyWith(liveLocation: v)),
          ),
        ],
      ),
    );
  }
}

class _SettingToggleRow extends StatelessWidget {
  const _SettingToggleRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF00A8AD)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF0F172A),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        _CompactSwitch(value: value, onChanged: onChanged),
      ],
    );
  }
}

class _CompactSwitch extends StatelessWidget {
  const _CompactSwitch({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        width: 48,
        height: 28,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: value ? const Color(0xFF00A8AD) : const Color(0xFFE2E8F0),
          borderRadius: BorderRadius.circular(999),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 160),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Color(0x1A000000), blurRadius: 4, offset: Offset(0, 2)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PriorityEmptyState extends StatelessWidget {
  const _PriorityEmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48),
        border: Border.all(
          color: const Color(0x3300A8AD),
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0x1A00A8AD),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.group_add_outlined, size: 24, color: Color(0xFF00A8AD)),
          ),
          const SizedBox(height: 12),
          Text(
            'Add up to 5 priority contacts for instant\nemergency notification.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF475569),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddContactButton extends StatelessWidget {
  const _AddContactButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFF00A8AD),
          borderRadius: BorderRadius.circular(48),
          boxShadow: const [
            BoxShadow(color: Color(0x4D00A8AD), blurRadius: 15, offset: Offset(0, 6)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_circle_outline_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              'Thêm liên hệ',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 28 / 1.55,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriorityBottomNav extends StatelessWidget {
  const _PriorityBottomNav();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      height: 77,
      padding: const EdgeInsets.symmetric(horizontal: 25.5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: const [
          BoxShadow(color: Color(0x26000000), blurRadius: 25, offset: Offset(0, 8)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _BottomNavItem(icon: Icons.grid_view_rounded, selected: true),
          _BottomNavItem(icon: Icons.flag_outlined),
          _BottomNavItem(icon: Icons.notifications_none_rounded, hasDot: true),
          _BottomNavItem(icon: Icons.person_outline_rounded),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({required this.icon, this.selected = false, this.hasDot = false});

  final IconData icon;
  final bool selected;
  final bool hasDot;

  @override
  Widget build(BuildContext context) {
    final iconWidget = Icon(
      icon,
      size: 21,
      color: selected ? Colors.white : const Color(0xFF9CA3AF),
    );

    if (selected) {
      return Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          color: Color(0xFF00ACB1),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Color(0x4D00ACB1), blurRadius: 15, offset: Offset(0, 4)),
          ],
        ),
        child: iconWidget,
      );
    }

    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(child: iconWidget),
          if (hasDot)
            Positioned(
              right: 9,
              top: 9,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFFDC2626),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PriorityContact {
  const _PriorityContact({
    required this.name,
    required this.subtitle,
    required this.avatarUrl,
    required this.autoCall,
    required this.emergencyMessage,
    required this.liveLocation,
  });

  final String name;
  final String subtitle;
  final String avatarUrl;
  final bool autoCall;
  final bool emergencyMessage;
  final bool liveLocation;

  _PriorityContact copyWith({
    String? name,
    String? subtitle,
    String? avatarUrl,
    bool? autoCall,
    bool? emergencyMessage,
    bool? liveLocation,
  }) {
    return _PriorityContact(
      name: name ?? this.name,
      subtitle: subtitle ?? this.subtitle,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      autoCall: autoCall ?? this.autoCall,
      emergencyMessage: emergencyMessage ?? this.emergencyMessage,
      liveLocation: liveLocation ?? this.liveLocation,
    );
  }
}
