import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:family_guard/lib/core/utils/responsive/responsive.dart';
import 'package:family_guard/lib/core/routes/app_routes.dart';
import 'package:family_guard/lib/core/theme/app_colors.dart';

/// ============================================================
/// SAFE ZONE CONFIG SCREEN - Cáº¥u hÃ¬nh vÃ¹ng an toÃ n
/// ÄÆ°á»£c dá»‹ch vÃ  sá»­a lá»—i tá»« Figma Dev Mode export (class Frame1)
///
/// Lá»—i Figma Ä‘Ã£ sá»­a:
/// - `children: [,]` rá»—ng (icon back, icon rá»i/vÃ o/lÃ¢u, icon +) â†’ Icon thá»±c táº¿
/// - `BoxShadow(...) BoxShadow(...)` thiáº¿u `,` (3 chá»—) â†’ thÃªm dáº¥u `,`
/// - `Expanded` trong Column khÃ´ng cÃ³ chiá»u cao â†’ xÃ³a, dÃ¹ng ClipOval + CustomPainter
/// - `child: Stack()` rá»—ng (2 chá»— checkbox) â†’ Icon(Icons.check_rounded)
/// - `NetworkImage("https://placehold.co/...")` â†’ CustomPainter avatar
/// - Bottom bar táº¡i `top: 908` (ngoÃ i mÃ n hÃ¬nh) â†’ Positioned(bottom:0)
/// - AppBar dÃ¹ng Container trong Stack â†’ Scaffold.appBar thá»±c sá»±
/// - `spacing:` property Figma trÃªn Column/Row â†’ SizedBox
/// - Chip bÃ¡n kÃ­nh dÃ¹ng Positioned absolute tá»a Ä‘á»™ cá»©ng â†’ SingleChildScrollView + Row
/// - `class Frame1` â†’ SafeZoneConfigScreen
/// ============================================================

class SafeZoneConfigScreen extends StatefulWidget {
  const SafeZoneConfigScreen({super.key});

  @override
  State<SafeZoneConfigScreen> createState() => _SafeZoneConfigScreenState();
}

class _SafeZoneConfigScreenState extends State<SafeZoneConfigScreen> {
  // â”€â”€ BÃ¡n kÃ­nh Ä‘Ã£ chá»n â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  int _selectedRadius = 0; // 0=50m, 1=100m, 2=200m, 3=500m
  final List<String> _radiusOptions = ['50m', '100m', '200m', '500m'];

  // â”€â”€ Toggle thÃ´ng bÃ¡o thÃ´ng minh â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  bool _leaveAlert = true;
  bool _enterAlert = true;
  bool _stayLongAlert = false;

  // â”€â”€ NgÆ°á»i nháº­n (checked=true) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  final List<_Contact> _contacts = [
    const _Contact(name: 'Bá»‘', initials: 'B', color: Color(0xFF3B82F6), checked: true),
    const _Contact(name: 'Máº¹', initials: 'M', color: Color(0xFFEC4899), checked: true),
    const _Contact(name: 'Anh trai', initials: 'AT', color: Color(0xFF8B5CF6), checked: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          // â”€â”€ Ná»™i dung cuá»™n â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          SingleChildScrollView(
            padding: const EdgeInsets.only(
                top: 16, left: 16, right: 16, bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // â”€â”€ Card: ThÃ´ng tin vÃ¹ng â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                _buildZoneInfoCard(),
                const SizedBox(height: 24),

                // â”€â”€ BÃ¡n kÃ­nh â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                _buildSectionTitle('BÃ¡n kÃ­nh vÃ¹ng an toÃ n'),
                const SizedBox(height: 12),
                _buildRadiusChips(),
                const SizedBox(height: 24),

                // â”€â”€ ThÃ´ng bÃ¡o thÃ´ng minh â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                _buildSectionTitle('ThÃ´ng bÃ¡o thÃ´ng minh'),
                const SizedBox(height: 12),
                _buildSmartAlertsCard(),
                const SizedBox(height: 24),

                // â”€â”€ ThÃ nh viÃªn â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                _buildRecipientsHeader(),
                const SizedBox(height: 12),
                _buildRecipientsCard(),
              ],
            ),
          ),

          // â”€â”€ Bottom bar cá»‘ Ä‘á»‹nh â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
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
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(64),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xCCF0F8F7),
          border: Border(
            bottom: BorderSide(width: 1, color: Color(0x1900ACB2)),
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                // NÃºt back trÃ²n
                GestureDetector(
                  onTap: () => Navigator.of(context).maybePop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: Color(0xFF0C1D1A),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // TiÃªu Ä‘á»
                Expanded(
                  child: Text(
                    'Cáº¥u hÃ¬nh vÃ¹ng an toÃ n',
                    style: TextStyle(
                      color: const Color(0xFF0C1D1A),
                      fontSize: ResponsiveHelper.sp(context, 20),
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                      height: 1.40,
                      letterSpacing: -0.50,
                    ),
                  ),
                ),
                // NÃºt Há»§y
                TextButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  child: Text(
                    'Há»§y',
                    style: TextStyle(
                      color: const Color(0xFF00ACB2),
                      fontSize: ResponsiveHelper.sp(context, 16),
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w500,
                      height: 1.50,
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

  // â”€â”€ Section title â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        title,
        style: TextStyle(
          color: const Color(0xFF0C1D1A),
          fontSize: ResponsiveHelper.sp(context, 16),
          fontFamily: 'Lexend',
          fontWeight: FontWeight.w700,
          height: 1.50,
        ),
      ),
    );
  }

  // â”€â”€ Card: ThÃ´ng tin vÃ¹ng (thumbnail + tÃªn + Ä‘á»‹a chá»‰) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildZoneInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0x0C00ACB2)),
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail báº£n Ä‘á»“ (CustomPainter thay NetworkImage)
          Container(
            width: 64,
            height: 64,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: const Color(0x1900ACB2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IgnorePointer(
              child: FlutterMap(
                options: const MapOptions(
                  initialCenter: LatLng(10.7769, 106.7009),
                  initialZoom: 14,
                  interactionOptions: InteractionOptions(flags: InteractiveFlag.none),
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.figma_app',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 16),

          // TÃªn + Ä‘á»‹a chá»‰
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NhÃ  riÃªng',
                  style: TextStyle(
                    color: const Color(0xFF00ACB2),
                    fontSize: ResponsiveHelper.sp(context, 18),
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w700,
                    height: 1.56,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '123 ÄÆ°á»ng ABC, Quáº­n 1, TP.\nHCM',
                  style: TextStyle(
                    color: const Color(0xFF6B7280),
                    fontSize: ResponsiveHelper.sp(context, 14),
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w400,
                    height: 1.63,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // NÃºt chá»‰nh sá»­a
          GestureDetector(
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.safeZoneInfo),
            child: const Icon(
              Icons.edit_rounded,
              color: Color(0xFF00ACB2),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  // â”€â”€ Chip bÃ¡n kÃ­nh (scroll ngang, fix Positioned absolute) â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildRadiusChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_radiusOptions.length, (i) {
          final isSelected = i == _selectedRadius;
          return Padding(
            padding: EdgeInsets.only(right: i < _radiusOptions.length - 1 ? 8 : 0),
            child: GestureDetector(
              onTap: () => setState(() => _selectedRadius = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: 44,
                padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.horizontalPadding(context)),
                decoration: ShapeDecoration(
                  color: isSelected
                      ? const Color(0xFF00ACB2)
                      : Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: isSelected
                          ? const Color(0xFF00ACB2)
                          : const Color(0x1900ACB2),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadows: isSelected
                      ? const [
                          BoxShadow(
                            color: Color(0x3300ACB2),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                            spreadRadius: -2,
                          ),
                          BoxShadow(
                            color: Color(0x3300ACB2),
                            blurRadius: 6,
                            offset: Offset(0, 4),
                            spreadRadius: -1,
                          ),
                        ]
                      : [],
                ),
                alignment: Alignment.center,
                child: Text(
                  _radiusOptions[i],
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : const Color(0xFF4B5563),
                    fontSize: ResponsiveHelper.sp(context, 16),
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // â”€â”€ Card: ThÃ´ng bÃ¡o thÃ´ng minh (3 toggle rows) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildSmartAlertsCard() {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0x0C00ACB2)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        children: [
          _buildAlertRow(
            icon: Icons.logout_rounded,
            iconBg: const Color(0xFFFEF2F2),
            iconColor: const Color(0xFFEF4444),
            label: 'Rá»i vÃ¹ng',
            value: _leaveAlert,
            onToggle: (v) => setState(() => _leaveAlert = v),
            showDivider: false,
          ),
          _buildAlertRow(
            icon: Icons.login_rounded,
            iconBg: const Color(0xFFEFF6FF),
            iconColor: const Color(0xFF3B82F6),
            label: 'VÃ o vÃ¹ng',
            value: _enterAlert,
            onToggle: (v) => setState(() => _enterAlert = v),
            showDivider: true,
          ),
          _buildAlertRow(
            icon: Icons.timer_rounded,
            iconBg: const Color(0xFFFFFBEB),
            iconColor: const Color(0xFFD97706),
            label: 'á»ž láº¡i quÃ¡ lÃ¢u',
            value: _stayLongAlert,
            onToggle: (v) => setState(() => _stayLongAlert = v),
            showDivider: true,
          ),
        ],
      ),
    );
  }

  Widget _buildAlertRow({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String label,
    required bool value,
    required ValueChanged<bool> onToggle,
    required bool showDivider,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: showDivider
          ? const BoxDecoration(
              border: Border(
                top: BorderSide(width: 1, color: Color(0x0C00ACB2)),
              ),
            )
          : null,
      child: Row(
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          // Label
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: const Color(0xFF0C1D1A),
                fontSize: ResponsiveHelper.sp(context, 16),
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w500,
                height: 1.50,
              ),
            ),
          ),
          // Toggle switch
          GestureDetector(
            onTap: () => onToggle(!value),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 44,
              height: 24,
              decoration: BoxDecoration(
                color: value
                    ? const Color(0xFF00ACB2)
                    : const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                alignment: value
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  width: 20,
                  height: 20,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 1,
                      color: value
                          ? Colors.white
                          : const Color(0xFFD1D5DB),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // â”€â”€ Header ngÆ°á»i nháº­n (title + "+ ThÃªm má»›i") â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildRecipientsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'ThÃ nh viÃªn',
            style: TextStyle(
              color: const Color(0xFF0C1D1A),
              fontSize: ResponsiveHelper.sp(context, 16),
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w700,
              height: 1.50,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.safeZoneSelectMember),
            child: Text(
              '+ ThÃªm má»›i',
              style: TextStyle(
                color: const Color(0xFF00ACB2),
                fontSize: ResponsiveHelper.sp(context, 14),
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w400,
                height: 1.43,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // â”€â”€ Card danh sÃ¡ch ngÆ°á»i nháº­n â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildRecipientsCard() {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0x0C00ACB2)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        children: List.generate(_contacts.length, (i) {
          final c = _contacts[i];
          return GestureDetector(
            onTap: () => setState(() => _contacts[i] =
                _Contact(
                  name: c.name,
                  initials: c.initials,
                  color: c.color,
                  checked: !c.checked,
                )),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: i > 0
                  ? const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            width: 1, color: Color(0x0C00ACB2)),
                      ),
                    )
                  : null,
              child: Row(
                children: [
                  // Avatar vá»›i initials (CustomPainter thay NetworkImage)
                  Container(
                    width: 40,
                    height: 40,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF3F4F6),
                      shape: BoxShape.circle,
                    ),
                    child: CustomPaint(
                      painter: _AvatarPainter(
                        initials: c.initials,
                        color: c.color,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // TÃªn
                  Expanded(
                    child: Text(
                      c.name,
                      style: TextStyle(
                        color: const Color(0xFF0C1D1A),
                        fontSize: ResponsiveHelper.sp(context, 16),
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w500,
                        height: 1.50,
                      ),
                    ),
                  ),
                  // Checkbox
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 22,
                    height: 22,
                    decoration: ShapeDecoration(
                      color: c.checked
                          ? const Color(0xFF00ACB2)
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: c.checked
                              ? const Color(0xFF00ACB2)
                              : const Color(0xFFD1D5DB),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: c.checked
                        ? const Icon(Icons.check_rounded,
                            color: Colors.white, size: 14)
                        : null,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // â”€â”€ Bottom bar: LÆ°u cáº¥u hÃ¬nh â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: const BoxDecoration(
        color: Color(0xF2F0F8F7),
        border: Border(
          top: BorderSide(width: 1, color: Color(0x1900ACB2)),
        ),
      ),
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).maybePop(),
        child: const Text('LÆ°u cáº¥u hÃ¬nh'),
      ),
    );
  }
}

// â”€â”€ Data model â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class _Contact {
  final String name;
  final String initials;
  final Color color;
  final bool checked;
  const _Contact({
    required this.name,
    required this.initials,
    required this.color,
    required this.checked,
  });
}

// â”€â”€ Avatar painter vá»›i initials â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class _AvatarPainter extends CustomPainter {
  final String initials;
  final Color color;
  const _AvatarPainter({required this.initials, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    // Background
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      Paint()..color = color.withValues(alpha: 0.15),
    );
    // Text
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
      Offset((size.width - tp.width) / 2, (size.height - tp.height) / 2),
    );
  }

  @override
  bool shouldRepaint(covariant _AvatarPainter old) =>
      old.initials != initials || old.color != color;
}
