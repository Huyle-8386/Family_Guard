import 'package:flutter/material.dart';
import 'package:family_guard/core/widgets/inputs/app_text_input.dart';
import 'package:google_fonts/google_fonts.dart';

enum _AddMemberTab { phone, email }

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({super.key});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  static const _familyImageUrl =
      'http://localhost:3845/assets/47a4f0b26df618cd1bc2e8ffce7a0c53bcd0b741.png';

  final _controller = TextEditingController();
  _AddMemberTab _tab = _AddMemberTab.phone;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Header(titleColor: _AddMemberPalette.title),
              const SizedBox(height: 24),
              _SearchCard(
                tab: _tab,
                controller: _controller,
                onTabChanged: (tab) => setState(() => _tab = tab),
              ),
              const SizedBox(height: 32),
              _FamilyIllustration(
                imageUrl: _familyImageUrl,
                titleColor: _AddMemberPalette.title,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddMemberPalette {
  static const primary = Color(0xFF87E4DB);
  static const softPrimary = Color(0x1A87E4DB);
  static const segmentOuter = Color(0x3387E4DB);
  static const hint = Color(0xFFD8E0E2);
  static const title = Colors.black;
}

class _Header extends StatelessWidget {
  const _Header({required this.titleColor});

  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: Icon(Icons.arrow_back_ios_new, color: titleColor, size: 24),
          padding: const EdgeInsets.only(right: 12),
          constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
        ),
        Expanded(
          child: Text(
            'Thêm thành viên',
            textAlign: TextAlign.center,
            style: GoogleFonts.sarala(
              color: titleColor,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              height: 0.9,
            ),
          ),
        ),
        const SizedBox(width: 36),
      ],
    );
  }
}

class _SearchCard extends StatelessWidget {
  const _SearchCard({
    required this.tab,
    required this.controller,
    required this.onTabChanged,
  });

  final _AddMemberTab tab;
  final TextEditingController controller;
  final ValueChanged<_AddMemberTab> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
      decoration: BoxDecoration(
        color: _AddMemberPalette.softPrimary,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          _SegmentSwitcher(tab: tab, onTabChanged: onTabChanged),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0x80F0F0F0)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.centerLeft,
                  child: AppTextInput(
                    controller: controller,
                    filled: false,
                    contentPadding: EdgeInsets.zero,
                    enabledBorderColor: Colors.transparent,
                    focusedBorderColor: Colors.transparent,
                    hintText: tab == _AddMemberTab.phone
                        ? 'Nhập số điện thoại người thân'
                        : 'Nhập email người thân',
                    hintStyle: GoogleFonts.inter(
                      color: _AddMemberPalette.hint,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
                    textStyle: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    keyboardType: tab == _AddMemberTab.phone
                        ? TextInputType.phone
                        : TextInputType.emailAddress,
                    textInputAction: TextInputAction.search,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(8),
                child: Ink(
                  height: 40,
                  width: 66,
                  decoration: BoxDecoration(
                    color: _AddMemberPalette.primary,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0x80F0F0F0)),
                  ),
                  child: const Icon(Icons.search, size: 26, color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SegmentSwitcher extends StatelessWidget {
  const _SegmentSwitcher({required this.tab, required this.onTabChanged});

  final _AddMemberTab tab;
  final ValueChanged<_AddMemberTab> onTabChanged;

  @override
  Widget build(BuildContext context) {
    const activeFactor = 0.63; // ~63% active width
    const inactiveFactor = 1 - activeFactor;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 37,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            color: _AddMemberPalette.segmentOuter,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                alignment: tab == _AddMemberTab.phone
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: FractionallySizedBox(
                  widthFactor: activeFactor,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _AddMemberPalette.primary,
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: tab == _AddMemberTab.phone ? 65 : (inactiveFactor * 100).round(),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onTabChanged(_AddMemberTab.phone),
                      child: const _SegmentLabel(text: 'Số điện thoại'),
                    ),
                  ),
                  Expanded(
                    flex: tab == _AddMemberTab.email ? 65 : (inactiveFactor * 100).round(),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onTabChanged(_AddMemberTab.email),
                      child: const _SegmentLabel(text: 'Email'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SegmentLabel extends StatelessWidget {
  const _SegmentLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _FamilyIllustration extends StatelessWidget {
  const _FamilyIllustration({
    required this.imageUrl,
    required this.titleColor,
  });

  final String imageUrl;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.asset(
            "assets/images/image_family.png",
            width: 320,
            height: 320,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const SizedBox.shrink(),
          ),
        ),
        Text(
          'Tìm kiếm thành viên trong\ngia đình của bạn',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: titleColor,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}