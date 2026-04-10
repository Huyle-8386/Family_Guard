import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:family_guard/core/utils/responsive/responsive.dart';
import 'package:family_guard/core/routes/app_routes.dart';
import 'package:family_guard/features/safe_zone/data/datasources/safe_zone_service.dart';
import 'package:family_guard/core/theme/app_colors.dart';
import 'package:family_guard/core/widgets/app_back_header.dart';

/// ============================================================
/// SAFE ZONE EDIT SCREEN - Chá»‰nh sá»­a vÃ¹ng an toÃ n
/// ÄÆ°á»£c dá»‹ch vÃ  sá»­a lá»—i tá»« Figma Dev Mode export
/// ============================================================
class SafeZoneEditScreen extends StatefulWidget {
  const SafeZoneEditScreen({super.key});

  @override
  State<SafeZoneEditScreen> createState() => _SafeZoneEditScreenState();
}

class _SafeZoneEditScreenState extends State<SafeZoneEditScreen> {
  bool _isActive = true;
  double _radius = 500; // metres (100 â†’ 2000)

  String get _radiusLabel {
    if (_radius >= 1000) {
      return '${(_radius / 1000).toStringAsFixed(1)}km';
    }
    return '${_radius.toInt()}m';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBackHeaderBar(
        title: 'Vùng an toàn',
        trailing: TextButton(
          onPressed: () => Navigator.of(context).maybePop(),
          child: Text(
            'Lưu',
            style: TextStyle(
              color: const Color(0xFF00ACB2),
              fontSize: ResponsiveHelper.sp(context, 16),
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // â”€â”€ Ná»n map + zone circle â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          _buildMapArea(),

          // â”€â”€ Search bar â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          _buildSearchBar(),

          // â”€â”€ AppBar trong suá»‘t â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

          // â”€â”€ Bottom panel â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildBottomPanel(),
          ),
        ],
      ),
    );
  }

  // â”€â”€ Map area (ná»n xanh xÃ¡m + hÃ¬nh trÃ²n zone) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildMapArea() {
    // Use the first zone as default â€” in real usage, pass the zone id as argument
    final service = SafeZoneProvider.of(context);
    final zones = service.zones;
    final zone = zones.isNotEmpty ? zones.first : null;
    final center = zone != null
        ? LatLng(zone.latitude, zone.longitude)
        : const LatLng(10.7769, 106.7009);

    return SizedBox(
      width: double.infinity,
      height: 530,
      child: Stack(
        children: [
          // Real flutter_map
          Positioned.fill(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: center,
                initialZoom: 15,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.figma_app',
                ),
                CircleLayer(
                  circles: [
                    CircleMarker(
                      point: center,
                      radius: _radius / 10,
                      color: const Color(0x4C00ACB2),
                      borderColor: const Color(0xFF00ACB2),
                      borderStrokeWidth: 2,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // VÃ²ng trÃ²n vÃ¹ng an toÃ n
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Zone circle
                Container(
                  width: 256,
                  height: 256,
                  decoration: ShapeDecoration(
                    color: const Color(0x4C00ACB2),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 2, color: Color(0xFF00ACB2)),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                ),

                // Location pin á»Ÿ giá»¯a
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFF00ACB2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.location_on_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    Container(
                      width: 4,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF00ACB2),
                      ),
                    ),
                  ],
                ),

                // Badge "500m" bÃªn dÆ°á»›i circle
                Positioned(
                  bottom: 36,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: ShapeDecoration(
                      color: Colors.white.withValues(alpha: 0.90),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0x3300ACB2)),
                        borderRadius: BorderRadius.circular(9999),
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
                    child: Text(
                      _radiusLabel,
                      style: TextStyle(
                        color: Color(0xFF00ACB2),
                        fontSize: ResponsiveHelper.sp(context, 12),
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w700,
                        height: 1.33,
                      ),
                    ),
                  ),
                ),

                // Äiá»ƒm resize á»Ÿ rÃ¬a circle (pháº£i)
                Positioned(
                  right: 4,
                  top: 100,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 2, color: const Color(0xFF00ACB2)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 6,
                          offset: Offset(0, 4),
                          spreadRadius: -4,
                        ),
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 15,
                          offset: Offset(0, 10),
                          spreadRadius: -3,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.open_with_rounded,
                      size: 16,
                      color: Color(0xFF00ACB2),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // NÃºt GPS (gÃ³c dÆ°á»›i pháº£i)
          Positioned(
            right: 16,
            bottom: 80,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 10,
                    offset: Offset(0, 8),
                    spreadRadius: -6,
                  ),
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 25,
                    offset: Offset(0, 20),
                    spreadRadius: -5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.my_location_rounded,
                color: Color(0xFF00ACB2),
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // â”€â”€ Search bar â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildSearchBar() {
    return Positioned(
      left: 16,
      right: 16,
      top: 16,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFF3F4F6)),
            borderRadius: BorderRadius.circular(24),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 6,
              offset: Offset(0, 4),
              spreadRadius: -4,
            ),
            BoxShadow(
              color: Color(0x19000000),
              blurRadius: 15,
              offset: Offset(0, 10),
              spreadRadius: -3,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.search_rounded, color: Color(0xFF9CA3AF), size: 20),
            SizedBox(width: 8),
            Text(
              'Tìm địa điểm mới',
              style: TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: ResponsiveHelper.sp(context, 14),
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // â”€â”€ Overlay AppBar (trong suá»‘t, náº±m trÃªn map) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildOverlayAppBar(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.10),
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.white.withValues(alpha: 0.20),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // NÃºt back
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).maybePop(),
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x0C000000),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: Color(0xFF111827),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'VÃ¹ng an toÃ n',
                  style: TextStyle(
                    color: Color(0xFF111827),
                    fontSize: ResponsiveHelper.sp(context, 18),
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w700,
                    height: 1.56,
                  ),
                ),
              ],
            ),

            // NÃºt "LÆ°u"
            TextButton(
              onPressed: () => Navigator.of(context).maybePop(),
              child: Text(
                'LÆ°u',
                style: TextStyle(
                  color: Color(0xFF00ACB2),
                  fontSize: ResponsiveHelper.sp(context, 16),
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // â”€â”€ Bottom panel â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildBottomPanel() {
    return Container(
      width: double.infinity,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 30,
            offset: Offset(0, -8),
            spreadRadius: 0,
          ),
        ],
      ),
      padding: EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pull handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
          ),

          // TÃªn vÃ¹ng + Ä‘á»‹a chá»‰
          _buildZoneHeader(),

          const SizedBox(height: 24),

          // BÃ¡n kÃ­nh
          _buildRadiusSection(),

          const SizedBox(height: 8),

          // Tráº¡ng thÃ¡i hoáº¡t Ä‘á»™ng
          _buildStatusRow(),

          const SizedBox(height: 24),

          // NÃºt xÃ³a
          _buildDeleteButton(),
        ],
      ),
    );
  }

  // â”€â”€ TÃªn vÃ¹ng + Ä‘á»‹a chá»‰ â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildZoneHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'NhÃ  riÃªng',
              style: TextStyle(
                color: Color(0xFF111827),
                fontSize: ResponsiveHelper.sp(context, 24),
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w700,
                height: 1.33,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0x1900ACB2),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                'Äang hoáº¡t Ä‘á»™ng',
                style: TextStyle(
                  color: Color(0xFF00ACB2),
                  fontSize: ResponsiveHelper.sp(context, 12),
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '123 ÄÆ°á»ng Nguyá»…n Huá»‡, Quáº­n 1, TP. HCM',
          style: TextStyle(
            color: Color(0xFF6B7280),
            fontSize: ResponsiveHelper.sp(context, 14),
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w400,
            height: 1.43,
          ),
        ),
      ],
    );
  }

  // â”€â”€ BÃ¡n kÃ­nh + slider â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildRadiusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'BÃ¡n kÃ­nh vÃ¹ng an toÃ n',
              style: TextStyle(
                color: Color(0xFF374151),
                fontSize: ResponsiveHelper.sp(context, 14),
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w400,
                height: 1.43,
              ),
            ),
            Text(
              _radiusLabel,
              style: TextStyle(
                color: Color(0xFF00ACB2),
                fontSize: ResponsiveHelper.sp(context, 16),
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w700,
                height: 1.50,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Slider track
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 8,
            activeTrackColor: const Color(0xFF00ACB2),
            inactiveTrackColor: const Color(0x3300ACB2),
            thumbColor: const Color(0xFF00ACB2),
            thumbShape:
                const RoundSliderThumbShape(enabledThumbRadius: 12),
            overlayShape:
                const RoundSliderOverlayShape(overlayRadius: 20),
            overlayColor: const Color(0x1900ACB2),
          ),
          child: Slider(
            value: _radius,
            min: 100,
            max: 2000,
            divisions: 38,
            onChanged: (v) => setState(() => _radius = v),
          ),
        ),

        // Min / max label
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '100m',
              style: TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: ResponsiveHelper.sp(context, 10),
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w500,
                height: 1.50,
              ),
            ),
            Text(
              '2000m',
              style: TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: ResponsiveHelper.sp(context, 10),
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w500,
                height: 1.50,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // â”€â”€ Tráº¡ng thÃ¡i hoáº¡t Ä‘á»™ng + toggle â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildStatusRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0x1900ACB2),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.shield_rounded,
                  color: Color(0xFF00ACB2),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Tráº¡ng thÃ¡i hoáº¡t Ä‘á»™ng',
                style: TextStyle(
                  color: Color(0xFF374151),
                  fontSize: ResponsiveHelper.sp(context, 14),
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w400,
                  height: 1.43,
                ),
              ),
            ],
          ),
          // Toggle switch
          GestureDetector(
            onTap: () => setState(() => _isActive = !_isActive),
            child: SizedBox(
              width: 44,
              height: 24,
              child: Stack(
                children: [
                  Container(
                    width: 44,
                    height: 24,
                    decoration: BoxDecoration(
                      color: _isActive
                          ? const Color(0xFF00ACB2)
                          : const Color(0xFFE5E7EB),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    left: _isActive ? 22 : 2,
                    top: 2,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // â”€â”€ NÃºt "XÃ³a vÃ¹ng an toÃ n" â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildDeleteButton() {
    return OutlinedButton.icon(
      onPressed: () => _showDeleteDialog(),
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFFEF4444),
        side: const BorderSide(width: 2, color: Color(0xFFFEE2E2)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        minimumSize: const Size(double.infinity, 56),
      ),
      icon: const Icon(Icons.delete_outline_rounded, size: 20),
      label: const Text('XÃ³a vÃ¹ng an toÃ n'),
    );
  }

  void _showDeleteDialog() {
    Navigator.of(context).pushNamed(AppRoutes.safeZoneDeleteConfirm);
  }
}


