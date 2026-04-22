import 'package:flutter/material.dart';
import 'package:family_guard/core/widgets/app_back_header.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPriorityContactScreen extends StatefulWidget {
  const AddPriorityContactScreen({super.key});

  @override
  State<AddPriorityContactScreen> createState() => _AddPriorityContactScreenState();
}

class _AddPriorityContactScreenState extends State<AddPriorityContactScreen> {
  bool autoCall = true;
  bool emergencySms = true;
  bool liveLocation = false;
  _PriorityLevel level = _PriorityLevel.high;

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.interTextTheme(Theme.of(context).textTheme);

    return Theme(
      data: Theme.of(context).copyWith(textTheme: textTheme),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F8F8),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  const _Header(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 122),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _InfoFormCard(),
                          const SizedBox(height: 24),
                          const _SectionTitle('QUYỀN & CẢNH BÁO'),
                          const SizedBox(height: 12),
                          _PermissionTile(
                            icon: Icons.add_ic_call_outlined,
                            title: 'Tự động gọi',
                            value: autoCall,
                            onChanged: (v) => setState(() => autoCall = v),
                          ),
                          const SizedBox(height: 12),
                          _PermissionTile(
                            icon: Icons.chat_bubble_outline,
                            title: 'Tin nhắn khẩn cấp',
                            value: emergencySms,
                            onChanged: (v) => setState(() => emergencySms = v),
                          ),
                          const SizedBox(height: 12),
                          _PermissionTile(
                            icon: Icons.location_on_outlined,
                            title: 'Vị trí trực tiếp',
                            value: liveLocation,
                            onChanged: (v) => setState(() => liveLocation = v),
                          ),
                          const SizedBox(height: 24),
                          const _SectionTitle('MỨC ĐỘ ƯU TIÊN'),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _PriorityButton(
                                  icon: Icons.verified,
                                  label: 'Ưu tiên cao',
                                  selected: level == _PriorityLevel.high,
                                  onTap: () => setState(() => level = _PriorityLevel.high),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _PriorityButton(
                                  icon: Icons.circle_outlined,
                                  label: 'Bình thường',
                                  selected: level == _PriorityLevel.normal,
                                  onTap: () => setState(() => level = _PriorityLevel.normal),
                                ),
                              ),
                            ],
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
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
                  ),
                  child: SizedBox(
                    height: 56,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.maybePop(context),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFF00ACB1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      icon: const Icon(Icons.save_outlined, color: Colors.white, size: 18),
                      label: Text(
                        'Save Contact',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 24 / 1.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return const AppBackHeaderBar(
      title: 'Thêm liên hệ ưu tiên',
      trailing: SizedBox(width: 40),
    );
  }
}

class _InfoFormCard extends StatelessWidget {
  const _InfoFormCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF87E4DB), width: 2),
        boxShadow: const [
          BoxShadow(color: Color(0x0D000000), blurRadius: 2, offset: Offset(0, 1)),
        ],
      ),
      child: Column(
        children: const [
          _AddPhotoBlock(),
          SizedBox(height: 32),
          _LabeledInput(label: 'HỌ VÀ TÊN', hint: 'Tên'),
          SizedBox(height: 16),
          _LabeledInput(label: 'SỐ ĐIỆN THOẠI', hint: '+84 (555) 000-0000'),
          SizedBox(height: 16),
          _LabeledInput(label: 'QUAN HỆ', hint: 'Bố, Mẹ,...'),
        ],
      ),
    );
  }
}

class _AddPhotoBlock extends StatelessWidget {
  const _AddPhotoBlock();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 96,
          height: 96,
          child: Stack(
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: const Color(0x3387E4DB),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF00ACB1),
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: const Icon(Icons.add_a_photo_outlined, color: Color(0xFF00ACB1), size: 32),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: const Color(0xFF00ACB1),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.add, size: 12, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'THÊM ẢNH',
          style: GoogleFonts.inter(
            color: const Color(0xFF126C6E),
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
      ],
    );
  }
}

class _LabeledInput extends StatelessWidget {
  const _LabeledInput({required this.label, required this.hint});

  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF94A3B8),
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Text(
            hint,
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: const Color(0xFF04A8AE),
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _PermissionTile extends StatelessWidget {
  const _PermissionTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: const [
          BoxShadow(color: Color(0x0D000000), blurRadius: 2, offset: Offset(0, 1)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0x1A87E4DB),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: const Color(0xFF00ACB1)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                color: const Color(0xFF0F172A),
                fontSize: 28 / 2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _MiniSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _MiniSwitch extends StatelessWidget {
  const _MiniSwitch({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        width: 44,
        height: 24,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: value ? const Color(0xFF00ACB1) : const Color(0xFFE2E8F0),
          borderRadius: BorderRadius.circular(999),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 160),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: value ? Colors.white : const Color(0xFFD1D5DB)),
            ),
          ),
        ),
      ),
    );
  }
}

class _PriorityButton extends StatelessWidget {
  const _PriorityButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: selected ? const Color(0x0D00ACB1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? const Color(0xFF00ACB1) : const Color(0xFFE2E8F0),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: selected ? 13 : 12,
              color: selected ? const Color(0xFF00ACB1) : const Color(0xFF64748B),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                color: selected ? const Color(0xFF00ACB1) : const Color(0xFF64748B),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _PriorityLevel { high, normal }

