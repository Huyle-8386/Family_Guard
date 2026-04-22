import 'package:flutter/material.dart';
import 'package:family_guard/core/utils/responsive/responsive.dart';
import 'package:family_guard/core/routes/app_routes.dart';
import 'package:family_guard/core/theme/app_colors.dart';
import 'package:family_guard/core/widgets/app_back_header.dart';

/// ============================================================
/// SAFE ZONE INFO SCREEN - ThÃ´ng tin vÃ¹ng an toÃ n
/// ÄÆ°á»£c dá»‹ch vÃ  sá»­a lá»—i tá»« Figma Dev Mode export (class ThNgTinVNgAnToN)
///
/// Lá»—i Figma Ä‘Ã£ sá»­a:
/// - `children: [,]` rá»—ng (8 chá»—: icon back, icon loáº¡i vÃ¹ng x4, icon clock, ...)
///   â†’ thÃªm `Icon(...)` thá»±c táº¿
/// - `BoxShadow(...)BoxShadow(...)` thiáº¿u dáº¥u `,` (5 chá»—)
///   â†’ thÃªm dáº¥u `,`
/// - `Expanded` náº±m trong cá»™t gá»‘c ngoÃ i Scaffold â†’ xÃ³a, dÃ¹ng SingleChildScrollView
/// - Bottom bar `top: 874` (ngoÃ i mÃ n hÃ¬nh) â†’ Positioned bottom cá»‘ Ä‘á»‹nh
/// - AppBar dÃ¹ng Positioned â†’ chuyá»ƒn thÃ nh Scaffold.appBar thá»±c sá»±
/// - `spacing:` property trÃªn Column/Row (Figma syntax) â†’ SizedBox
/// - Grid loáº¡i vÃ¹ng dÃ¹ng Positioned absolute â†’ GridView 2x2 linh hoáº¡t
/// - `class ThNgTinVNgAnToN` tÃªn lá»™n xá»™n â†’ SafeZoneInfoScreen
/// ============================================================

class SafeZoneInfoScreen extends StatefulWidget {
  const SafeZoneInfoScreen({super.key});

  @override
  State<SafeZoneInfoScreen> createState() => _SafeZoneInfoScreenState();
}

class _SafeZoneInfoScreenState extends State<SafeZoneInfoScreen>
    with SingleTickerProviderStateMixin {
  // Controllers
  final _nameCtrl = TextEditingController(text: 'Nhà của tôi');

  // BÃ¡n kÃ­nh Ä‘Ã£ chá»n
  int _selectedRadius = 2; // index trong danh sÃ¡ch _radiusOptions
  final List<String> _radiusOptions = ['50m', '100m', '500m', '1km', '2km'];

  // Loáº¡i vÃ¹ng Ä‘Ã£ chá»n (0=NhÃ , 1=TrÆ°á»ng há»c, 2=Bá»‡nh viá»‡n, 3=TÃ¹y chá»‰nh)
  int _selectedZoneType = 0;

  // Toggle hoáº¡t Ä‘á»™ng theo giá»
  bool _timeBasedEnabled = true;

  // Animation controller cho toggle
  late AnimationController _toggleCtrl;

  @override
  void initState() {
    super.initState();
    _toggleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: _timeBasedEnabled ? 1.0 : 0.0,
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _toggleCtrl.dispose();
    super.dispose();
  }

  void _toggleTimeBased() {
    setState(() => _timeBasedEnabled = !_timeBasedEnabled);
    _timeBasedEnabled ? _toggleCtrl.forward() : _toggleCtrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // â”€â”€ Ná»™i dung cuá»™n â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          SingleChildScrollView(
            padding: EdgeInsets.only(
                left: 16, right: 16, top: 24, bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // â”€â”€ TÃŠN VÃ™NG â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                _buildSectionLabel('TÊN VÙNG'),
                const SizedBox(height: 12),
                _buildNameField(),

                const SizedBox(height: 32),

                // â”€â”€ Äá»ŠA CHá»ˆ â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                _buildSectionLabel('ĐỊA CHỈ'),
                const SizedBox(height: 12),
                _buildAddressField(),

                const SizedBox(height: 32),

                // â”€â”€ BÃN KÃNH â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                _buildRadiusHeader(),
                const SizedBox(height: 16),
                _buildRadiusChips(),

                const SizedBox(height: 32),

                // â”€â”€ LOáº I VÃ™NG â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                _buildSectionLabel('LOẠI VÙNG'),
                const SizedBox(height: 16),
                _buildZoneTypeGrid(),

                const SizedBox(height: 32),

                // â”€â”€ HOáº T Äá»˜NG THEO GIá»œ â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                _buildTimeBasedCard(),
              ],
            ),
          ),

          // â”€â”€ Bottom bar cá»‘ Ä‘á»‹nh â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
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
  PreferredSizeWidget _buildAppBar() {
    return const AppBackHeaderBar(
      title: 'Thông tin vùng an toàn',
    );
  }

  // â”€â”€ Section label â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildSectionLabel(String label) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        label,
        style: TextStyle(
          color: Color(0xCC00ACB2),
          fontSize: ResponsiveHelper.sp(context, 14),
          fontFamily: 'Lexend',
          fontWeight: FontWeight.w400,
          height: 1.43,
          letterSpacing: 0.70,
        ),
      ),
    );
  }

  // â”€â”€ Field: TÃªn vÃ¹ng (editable) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildNameField() {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color(0x1900ACB2),
            blurRadius: 0,
            offset: Offset(0, 0),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon bÃªn trÃ¡i
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Icon(
              Icons.edit_location_alt_rounded,
              color: Color(0xFF00ACB2),
              size: 22,
            ),
          ),
          // TextField
          Expanded(
            child: TextField(
              controller: _nameCtrl,
              style: TextStyle(
                color: Color(0xFF0C1D1A),
                fontSize: ResponsiveHelper.sp(context, 16),
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                border: InputBorder.none,
                hintText: 'Nhập tên vùng...',
                hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // â”€â”€ Field: Äá»‹a chá»‰ (readonly) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildAddressField() {
    return Container(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
      decoration: ShapeDecoration(
        color: const Color(0x7FF3F4F6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.location_on_rounded,
              color: Color(0xFF6B7280),
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '123 Đường Lê Lợi, Quận 1, TP. Hồ Chí Minh',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: ResponsiveHelper.sp(context, 16),
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // â”€â”€ Radius header (label + badge "TÃ¹y chá»‰nh") â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildRadiusHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'BÁN KÍNH',
            style: TextStyle(
              color: Color(0xCC00ACB2),
              fontSize: ResponsiveHelper.sp(context, 14),
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w400,
              height: 1.43,
              letterSpacing: 0.70,
            ),
          ),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: ShapeDecoration(
              color: const Color(0x1900ACB2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
            child: Text(
              'Tùy chỉnh',
              style: TextStyle(
                color: Color(0xFF00ACB2),
                fontSize: ResponsiveHelper.sp(context, 12),
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w700,
                height: 1.33,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // â”€â”€ Radius chips (Wrap layout, fix Positioned absolute tá»« Figma) â”€â”€
  Widget _buildRadiusChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(_radiusOptions.length, (i) {
        final isSelected = i == _selectedRadius;
        return GestureDetector(
          onTap: () => setState(() => _selectedRadius = i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: isSelected ? 2 : 1,
                  color: isSelected
                      ? const Color(0xFF00ACB2)
                      : const Color(0x0C00ACB2),
                ),
                borderRadius: BorderRadius.circular(9999),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x0C000000),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Color(0x0C00ACB2),
                  blurRadius: 0,
                  offset: Offset(0, 0),
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Text(
              _radiusOptions[i],
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFF00ACB2)
                    : const Color(0xFF4B5563),
                fontSize: ResponsiveHelper.sp(context, 14),
                fontFamily: 'Lexend',
                fontWeight:
                    isSelected ? FontWeight.w700 : FontWeight.w500,
                height: 1.43,
              ),
            ),
          ),
        );
      }),
    );
  }

  // â”€â”€ Zone type grid 2x2 (fix Positioned absolute tá»« Figma) â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildZoneTypeGrid() {
    final zoneTypes = [
      _ZoneType(
        label: 'Nhà',
        icon: Icons.home_rounded,
        iconBg: const Color(0xFFEFF6FF),
        iconColor: const Color(0xFF3B82F6),
      ),
      _ZoneType(
        label: 'Trường học',
        icon: Icons.school_rounded,
        iconBg: const Color(0xFFFFFBEB),
        iconColor: const Color(0xFFD97706),
      ),
      _ZoneType(
        label: 'Bệnh viện',
        icon: Icons.local_hospital_rounded,
        iconBg: const Color(0xFFFFF1F2),
        iconColor: const Color(0xFFF43F5E),
      ),
      _ZoneType(
        label: 'Tùy chỉnh',
        icon: Icons.tune_rounded,
        iconBg: const Color(0xFFF8FAFC),
        iconColor: const Color(0xFF64748B),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.3,
      ),
      itemCount: zoneTypes.length,
      itemBuilder: (_, i) {
        final z = zoneTypes[i];
        final isSelected = i == _selectedZoneType;
        return GestureDetector(
          onTap: () => setState(() => _selectedZoneType = i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: EdgeInsets.all(16),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 2,
                  color: isSelected
                      ? const Color(0xFF00ACB2)
                      : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(24),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? z.iconBg
                        : z.iconBg.withValues(alpha: 0.70),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    z.icon,
                    color: isSelected
                        ? z.iconColor
                        : z.iconColor.withValues(alpha: 0.60),
                    size: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  z.label,
                  style: TextStyle(
                    color: isSelected
                        ? const Color(0xFF0C1D1A)
                        : const Color(0xFF6B7280),
                    fontSize: ResponsiveHelper.sp(context, 14),
                    fontFamily: 'Lexend',
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.w400,
                    height: 1.43,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // â”€â”€ Card: Hoáº¡t Ä‘á»™ng theo giá» â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildTimeBasedCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0x0C00ACB2)),
          borderRadius: BorderRadius.circular(24),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Toggle row
          Row(
            children: [
              // Icon clock
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0x1900ACB2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.schedule_rounded,
                  color: Color(0xFF00ACB2),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hoạt động theo giờ',
                      style: TextStyle(
                        color: Color(0xFF0C1D1A),
                        fontSize: ResponsiveHelper.sp(context, 16),
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w700,
                        height: 1.50,
                      ),
                    ),
                    Text(
                      'Chỉ thông báo trong khung giờ này',
                      style: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: ResponsiveHelper.sp(context, 12),
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                    ),
                  ],
                ),
              ),
              // Animated toggle switch
              GestureDetector(
                onTap: _toggleTimeBased,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 48,
                  height: 24,
                  decoration: BoxDecoration(
                    color: _timeBasedEnabled
                        ? const Color(0xFF00ACB2)
                        : const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    alignment: _timeBasedEnabled
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      width: 20,
                      height: 20,
                      margin:
                          EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border:
                            Border.all(width: 1, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Khung giá» hiá»‡n táº¡i (chá»‰ hiá»‡n khi báº­t)
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: _timeBasedEnabled
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Column(
              children: [
                const SizedBox(height: 16),
                const Divider(
                    color: Color(0xFFF9FAFB), thickness: 1),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Khung giờ hiện tại',
                      style: TextStyle(
                        color: Color(0xFF4B5563),
                        fontSize: ResponsiveHelper.sp(context, 14),
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w500,
                        height: 1.43,
                      ),
                    ),
                    // Badge thá»i gian
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.safeZoneTimeRules);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: ShapeDecoration(
                          color: const Color(0x0C00ACB2),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '08:00 - 18:00',
                              style: TextStyle(
                                color: Color(0xFF00ACB2),
                                fontSize: ResponsiveHelper.sp(context, 16),
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w700,
                                height: 1.50,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: Color(0xFF00ACB2),
                              size: 20,
                            ),
                          ],
                        ),
                      ),
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

  // â”€â”€ Bottom bar cá»‘ Ä‘á»‹nh â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.90),
        border: const Border(
          top: BorderSide(width: 1, color: Color(0x1900ACB2)),
        ),
      ),
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pushNamed(AppRoutes.safeZoneActive),
        child: const Text('Lưu cấu hình'),
      ),
    );
  }
}

// â”€â”€ Data model cho loáº¡i vÃ¹ng â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class _ZoneType {
  final String label;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  const _ZoneType({
    required this.label,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
  });
}


