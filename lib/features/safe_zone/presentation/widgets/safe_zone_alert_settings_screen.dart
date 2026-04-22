import 'package:flutter/material.dart';
import 'package:family_guard/core/utils/responsive/responsive.dart';
import 'package:family_guard/core/routes/app_routes.dart';
import 'package:family_guard/core/theme/app_colors.dart';
import 'package:family_guard/core/widgets/app_back_header.dart';

/// ============================================================
/// SAFE ZONE ALERT SETTINGS SCREEN - CÃ i Ä‘áº·t cáº£nh bÃ¡o vÃ¹ng an toÃ n
/// ÄÆ°á»£c dá»‹ch vÃ  sá»­a lá»—i tá»« Figma Dev Mode export (class CITCNhBO)
///
/// Lá»—i Figma Ä‘Ã£ sá»­a:
/// - `Expanded` trong `Stack` â†’ loáº¡i bá», dÃ¹ng CustomPainter cho avatar
/// - `BoxShadow(...)BoxShadow(...)` thiáº¿u dáº¥u `,` â†’ thÃªm dáº¥u `,`
/// - `children: [,]` rá»—ng â†’ thÃªm `Icon(...)` thá»±c táº¿
/// - `child: Stack()` rá»—ng â†’ loáº¡i bá», thay báº±ng Icon
/// - `class CITCNhBO` xung Ä‘á»™t tÃªn â†’ Ä‘á»•i thÃ nh SafeZoneAlertSettingsScreen
/// - `NetworkImage("https://placehold.co/44x44")` â†’ dÃ¹ng CustomPainter avatar
/// - `spacing:` property khÃ´ng há»£p lá»‡ trong Column/Row (chá»‰ Flutter 3.7+)
/// ============================================================

class SafeZoneAlertSettingsScreen extends StatefulWidget {
  const SafeZoneAlertSettingsScreen({super.key});

  @override
  State<SafeZoneAlertSettingsScreen> createState() =>
      _SafeZoneAlertSettingsScreenState();
}

class _SafeZoneAlertSettingsScreenState
    extends State<SafeZoneAlertSettingsScreen> {
  // â”€â”€ Tráº¡ng thÃ¡i toggle cáº£nh bÃ¡o â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  bool _leaveZoneEnabled = true;  // Khi rá»i vÃ¹ng - báº­t
  bool _enterZoneEnabled = false; // Khi vÃ o vÃ¹ng - táº¯t

  // â”€â”€ HÃ¬nh thá»©c thÃ´ng bÃ¡o â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  bool _pushEnabled = true;
  bool _smsEnabled = true;
  bool _callEnabled = false;

  // â”€â”€ Äá»™ kháº©n cáº¥p â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  // 0 = Ngay láº­p tá»©c, 1 = Sau 5 phÃºt
  int _urgencyLevel = 0;

  // â”€â”€ Danh sÃ¡ch ngÆ°á»i nháº­n â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  final List<_AlertRecipient> _recipients = [
    _AlertRecipient(name: 'Bà Lan', role: 'Người thân chính', initials: 'BL', color: const Color(0xFF00ACB2)),
    _AlertRecipient(name: 'Ông Hùng', role: 'Người bảo hộ', initials: 'ÔH', color: const Color(0xFF3B82F6)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // â”€â”€ Ná»™i dung cuá»™n â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 160),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-0.42, 0.16),
                  end: Alignment(1.42, 0.84),
                  colors: [AppColors.background, AppColors.kPrimaryLight],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // â”€â”€ AppBar â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                  _buildAppBar(context),

                  const SizedBox(height: 8),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.horizontalPadding(context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // â”€â”€ Card: Khi rá»i vÃ¹ng â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        _buildLeaveZoneCard(),

                        const SizedBox(height: 16),

                        // â”€â”€ Card: Khi vÃ o vÃ¹ng (dimmed) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        _buildEnterZoneCard(),

                        const SizedBox(height: 24),

                        // â”€â”€ Section: NgÆ°á»i nháº­n cáº£nh bÃ¡o â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                        _buildRecipientsSection(),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // â”€â”€ Bottom action bar cá»‘ Ä‘á»‹nh â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomBar(context),
          ),
        ],
      ),
    );
  }

  // â”€â”€ AppBar â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildAppBar(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: AppBackHeaderBar(
        title: 'Cài đặt cảnh báo',
        onBack: () => Navigator.of(context).maybePop(),
      ),
    );
  }

  // â”€â”€ Card: Khi rá»i vÃ¹ng (active) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildLeaveZoneCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0x3300ACB2)),
          borderRadius: BorderRadius.circular(20),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x1400ACB2),
            blurRadius: 20,
            offset: Offset(0, 4),
            spreadRadius: -2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Toggle header
          _buildAlertHeader(
            icon: Icons.logout_rounded,
            iconBgColor: const Color(0xFFFEF9C3),
            iconColor: const Color(0xFFD97706),
            title: 'Khi rời vùng',
            isEnabled: _leaveZoneEnabled,
            onToggle: (v) => setState(() => _leaveZoneEnabled = v),
          ),

          // Ná»™i dung cÃ i Ä‘áº·t (chá»‰ hiá»‡n khi enabled)
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: _leaveZoneEnabled
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFF8FAFC), thickness: 1),
                const SizedBox(height: 16),

                // HÃ¬nh thá»©c thÃ´ng bÃ¡o
                _buildSectionLabel('HÌNH THỨC THÔNG BÁO'),
                const SizedBox(height: 12),
                _buildCheckOption(
                  label: 'Thông báo Push',
                  value: _pushEnabled,
                  onChanged: (v) => setState(() => _pushEnabled = v!),
                ),
                const SizedBox(height: 4),
                _buildCheckOption(
                  label: 'Gửi SMS',
                  value: _smsEnabled,
                  onChanged: (v) => setState(() => _smsEnabled = v!),
                ),
                const SizedBox(height: 4),
                _buildCheckOption(
                  label: 'Gọi điện',
                  value: _callEnabled,
                  onChanged: (v) => setState(() => _callEnabled = v!),
                ),

                const SizedBox(height: 20),

                // Äá»™ kháº©n cáº¥p
                _buildSectionLabel('ĐỘ KHẨN CẤP'),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildRadioOption(
                      label: 'Ngay lập tức',
                      value: 0,
                      groupValue: _urgencyLevel,
                      onChanged: (v) => setState(() => _urgencyLevel = v!),
                    ),
                    const SizedBox(width: 20),
                    _buildRadioOption(
                      label: 'Sau 5 phút',
                      value: 1,
                      groupValue: _urgencyLevel,
                      onChanged: (v) => setState(() => _urgencyLevel = v!),
                    ),
                  ],
                ),
              ],
            ),
            secondChild: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  // â”€â”€ Card: Khi vÃ o vÃ¹ng (dimmed/inactive) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildEnterZoneCard() {
    return Opacity(
      opacity: _enterZoneEnabled ? 1.0 : 0.80,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: ShapeDecoration(
          color: _enterZoneEnabled
              ? Colors.white
              : Colors.white.withValues(alpha: 0.60),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0x1900ACB2)),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: _buildAlertHeader(
          icon: Icons.login_rounded,
          iconBgColor: const Color(0xFFDBEAFE),
          iconColor: const Color(0xFF3B82F6),
          title: 'Khi vào vùng',
          isEnabled: _enterZoneEnabled,
          onToggle: (v) => setState(() => _enterZoneEnabled = v),
        ),
      ),
    );
  }

  // â”€â”€ Shared: Alert header vá»›i toggle â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildAlertHeader({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required bool isEnabled,
    required ValueChanged<bool> onToggle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: Color(0xFF004D40),
                fontSize: ResponsiveHelper.sp(context, 18),
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w700,
                height: 1.56,
              ),
            ),
          ],
        ),
        // Toggle switch
        GestureDetector(
          onTap: () => onToggle(!isEnabled),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 44,
            height: 24,
            decoration: BoxDecoration(
              color: isEnabled
                  ? const Color(0xFF00ACB2)
                  : const Color(0xFFCBD5E1),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              alignment:
                  isEnabled ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 16,
                height: 16,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // â”€â”€ Label section tiÃªu Ä‘á» nhá» â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        color: Color(0xFF004D40),
        fontSize: ResponsiveHelper.sp(context, 14),
        fontFamily: 'Lexend',
        fontWeight: FontWeight.w400,
        height: 1.43,
        letterSpacing: 0.70,
      ),
    );
  }

  // â”€â”€ Checkbox option â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildCheckOption({
    required String label,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Row(
          children: [
            // Custom checkbox
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 22,
              height: 22,
              decoration: ShapeDecoration(
                color: value ? const Color(0xFF00ACB2) : Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: value
                        ? const Color(0xFF00ACB2)
                        : const Color(0x4C00ACB2),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: value
                  ? const Icon(Icons.check_rounded,
                      color: Colors.white, size: 14)
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: Color(0xFF475569),
                fontSize: ResponsiveHelper.sp(context, 16),
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // â”€â”€ Radio option â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildRadioOption({
    required String label,
    required int value,
    required int groupValue,
    required ValueChanged<int?> onChanged,
  }) {
    final isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 22,
            height: 22,
            decoration: ShapeDecoration(
              color: isSelected ? const Color(0xFF00ACB2) : Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: isSelected
                      ? const Color(0xFF00ACB2)
                      : const Color(0x4C00ACB2),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: isSelected
                ? const Icon(Icons.check_rounded,
                    color: Colors.white, size: 14)
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: Color(0xFF475569),
              fontSize: ResponsiveHelper.sp(context, 14),
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w400,
              height: 1.43,
            ),
          ),
        ],
      ),
    );
  }

  // â”€â”€ Section: NgÆ°á»i nháº­n cáº£nh bÃ¡o â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildRecipientsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TiÃªu Ä‘á» section
        Text(
          'Người thân',
          style: TextStyle(
            color: Color(0xFF004D40),
            fontSize: ResponsiveHelper.sp(context, 18),
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w700,
            height: 1.56,
          ),
        ),

        const SizedBox(height: 16),

        // Card danh sÃ¡ch ngÆ°á»i nháº­n
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0x1900ACB2)),
              borderRadius: BorderRadius.circular(20),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x1400ACB2),
                blurRadius: 20,
                offset: Offset(0, 4),
                spreadRadius: -2,
              ),
            ],
          ),
          child: Column(
            children: [
              // Danh sÃ¡ch ngÆ°á»i nháº­n
              ..._recipients.map((recipient) => Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: _buildRecipientRow(recipient),
                  )),

              const SizedBox(height: 8),

              // NÃºt thÃªm ngÆ°á»i nháº­n
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tính năng thêm người nhận sẽ được cập nhật'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF00ACB2),
                  side: const BorderSide(width: 2, color: Color(0x4C00ACB2)),
                ),
                icon: const Icon(Icons.add_circle_outline_rounded, size: 20),
                label: const Text('Thêm người nhận'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // â”€â”€ Row ngÆ°á»i nháº­n â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildRecipientRow(_AlertRecipient recipient) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Row(
        children: [
          // Avatar (dÃ¹ng CustomPainter thay NetworkImage)
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 2, color: const Color(0x3300ACB2)),
            ),
            child: ClipOval(
              child: CustomPaint(
                painter: _AvatarPainter(
                  initials: recipient.initials,
                  color: recipient.color,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // TÃªn + vai trÃ²
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  recipient.name,
                  style: TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: ResponsiveHelper.sp(context, 16),
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                  ),
                ),
                Text(
                  recipient.role,
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: ResponsiveHelper.sp(context, 12),
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                ),
              ],
            ),
          ),

          // NÃºt check (Ä‘Ã£ chá»n = teal)
          Container(
            width: 26,
            height: 26,
            decoration: const ShapeDecoration(
              color: Color(0xFF00ACB2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(9999)),
              ),
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }

  // â”€â”€ Bottom bar â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).padding.bottom + 24,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.80),
        border: const Border(
          top: BorderSide(width: 1, color: Color(0xFFF1F5F9)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Link "Xem trÆ°á»›c thÃ´ng bÃ¡o"
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.notificationPreview),
            child: Text(
              'Xem trước thông báo',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF00ACB2),
                fontSize: ResponsiveHelper.sp(context, 14),
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w400,
                height: 1.43,
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFF00ACB2),
              ),
            ),
          ),

          // NÃºt "LÆ°u cÃ i Ä‘áº·t"
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).maybePop();
            },
            child: const Text('Lưu cài đặt'),
          ),
        ],
      ),
    );
  }
}

// â”€â”€ Data model â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class _AlertRecipient {
  final String name;
  final String role;
  final String initials;
  final Color color;
  const _AlertRecipient({
    required this.name,
    required this.role,
    required this.initials,
    required this.color,
  });
}

// â”€â”€ CustomPainter váº½ avatar vá»›i initials â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class _AvatarPainter extends CustomPainter {
  final String initials;
  final Color color;

  const _AvatarPainter({required this.initials, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // Background circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      Paint()..color = color.withValues(alpha: 0.15),
    );

    // Text initials
    final tp = TextPainter(
      text: TextSpan(
        text: initials,
        style: TextStyle(
          color: color,
          fontSize: size.width * 0.35,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    tp.paint(
      canvas,
      Offset(
        (size.width - tp.width) / 2,
        (size.height - tp.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant _AvatarPainter old) =>
      old.initials != initials || old.color != color;
}


