import 'package:family_guard/core/constants/app_colors.dart';
import 'package:family_guard/core/constants/app_routes.dart';
import 'package:family_guard/core/widgets/app_back_header.dart';
import 'package:family_guard/features/member_management/presentation/models/member_management_demo_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum _AddMemberTab { phone, email }

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({
    super.key,
    this.args = const AddMemberFlowArgs(),
  });

  final AddMemberFlowArgs args;

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final _controller = TextEditingController();
  late _AddMemberTab _tab;

  @override
  void initState() {
    super.initState();
    _tab = widget.args.initialMode == AddMemberEntryMode.email
        ? _AddMemberTab.email
        : _AddMemberTab.phone;
    _controller.text = widget.args.prefilledValue;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isEditing => widget.args.isEditing;

  @override
  Widget build(BuildContext context) {
    final title = _isEditing ? 'Chỉnh sửa thành viên' : 'Thêm thành viên';
    final headline = _isEditing
        ? 'Cập nhật liên hệ thành viên'
        : 'Mời thêm thành viên vào gia đình';
    final description = _isEditing
        ? 'Chỉnh lại số điện thoại hoặc email để tiếp tục đồng bộ liên lạc và theo dõi.'
        : 'Nhập số điện thoại hoặc email để tìm và kết nối người thân vào FamilyGuard.';
    final buttonLabel = _isEditing ? 'Lưu thay đổi' : 'Tìm thành viên';

    return Scaffold(
      backgroundColor: const Color(0xFFF3FAF9),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            AppBackHeaderBar(
              title: title,
              titleFontSize: 20,
              padding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _IntroCard(
                      headline: headline,
                      description: description,
                      isEditing: _isEditing,
                    ),
                    const SizedBox(height: 20),
                    _FormCard(
                      tab: _tab,
                      controller: _controller,
                      isEditing: _isEditing,
                      onTabChanged: (tab) => setState(() => _tab = tab),
                      onActionTap: _handlePrimaryAction,
                      buttonLabel: buttonLabel,
                    ),
                    const SizedBox(height: 20),
                    _IllustrationCard(
                      title: _isEditing
                          ? 'Thông tin mới sẽ được dùng cho các lời mời và màn hình quản lý thành viên.'
                          : 'Sau khi tìm thấy, bạn có thể chọn đúng thành viên và tiếp tục vào màn quản lý chi tiết.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handlePrimaryAction() {
    final query = _controller.text.trim();
    if (_isEditing) {
      final member = widget.args.member;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              member == null
                  ? 'Đã lưu thay đổi'
                  : 'Đã lưu thay đổi cho ${member.name}',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      Navigator.maybePop(context);
      return;
    }

    if (query.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              _tab == _AddMemberTab.phone
                  ? 'Nhập số điện thoại để tìm thành viên'
                  : 'Nhập email để tìm thành viên',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      return;
    }

    Navigator.pushNamed(
      context,
      AppRoutes.memberSelection,
      arguments: MemberSelectionArgs(
        query: query,
        mode: _tab == _AddMemberTab.email
            ? AddMemberEntryMode.email
            : AddMemberEntryMode.phone,
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard({
    required this.headline,
    required this.description,
    required this.isEditing,
  });

  final String headline;
  final String description;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFE6F7F7),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              isEditing ? Icons.edit_outlined : Icons.person_add_alt_1_rounded,
              color: AppColors.primary,
              size: 26,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headline,
                  style: GoogleFonts.beVietnamPro(
                    color: const Color(0xFF0F172A),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: GoogleFonts.beVietnamPro(
                    color: const Color(0xFF64748B),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
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

class _FormCard extends StatelessWidget {
  const _FormCard({
    required this.tab,
    required this.controller,
    required this.isEditing,
    required this.onTabChanged,
    required this.onActionTap,
    required this.buttonLabel,
  });

  final _AddMemberTab tab;
  final TextEditingController controller;
  final bool isEditing;
  final ValueChanged<_AddMemberTab> onTabChanged;
  final VoidCallback onActionTap;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    final isPhoneTab = tab == _AddMemberTab.phone;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF4F2),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SegmentSwitcher(tab: tab, onTabChanged: onTabChanged),
          const SizedBox(height: 20),
          Text(
            isPhoneTab ? 'Số điện thoại' : 'Email',
            style: GoogleFonts.beVietnamPro(
              color: const Color(0xFF0F172A),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Icon(
                  isPhoneTab ? Icons.call_outlined : Icons.mail_outline_rounded,
                  color: const Color(0xFF94A3B8),
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: isPhoneTab
                        ? TextInputType.phone
                        : TextInputType.emailAddress,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (_) => onActionTap(),
                    style: GoogleFonts.beVietnamPro(
                      color: const Color(0xFF0F172A),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: isPhoneTab
                          ? 'Nhập số điện thoại người thân'
                          : 'Nhập email người thân',
                      hintStyle: GoogleFonts.beVietnamPro(
                        color: const Color(0xFF94A3B8),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  size: 18,
                  color: Color(0xFF00ADB2),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    isEditing
                        ? 'Thông tin sau khi lưu sẽ cập nhật cho thành viên đang được chỉnh sửa.'
                        : 'Người thân sẽ xuất hiện ở bước tiếp theo để bạn xác nhận và đi tiếp.',
                    style: GoogleFonts.beVietnamPro(
                      color: const Color(0xFF475569),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 54,
            child: ElevatedButton(
              onPressed: onActionTap,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Text(
                buttonLabel,
                style: GoogleFonts.beVietnamPro(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentSwitcher extends StatelessWidget {
  const _SegmentSwitcher({
    required this.tab,
    required this.onTabChanged,
  });

  final _AddMemberTab tab;
  final ValueChanged<_AddMemberTab> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SegmentButton(
              label: 'Số điện thoại',
              isSelected: tab == _AddMemberTab.phone,
              onTap: () => onTabChanged(_AddMemberTab.phone),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _SegmentButton(
              label: 'Email',
              isSelected: tab == _AddMemberTab.email,
              onTap: () => onTabChanged(_AddMemberTab.email),
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.primary : Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.beVietnamPro(
              color: isSelected ? Colors.white : const Color(0xFF475569),
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _IllustrationCard extends StatelessWidget {
  const _IllustrationCard({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            'assets/images/image_family.png',
            width: 240,
            height: 220,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const SizedBox(
              width: 240,
              height: 220,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.beVietnamPro(
              color: const Color(0xFF334155),
              fontSize: 15,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
