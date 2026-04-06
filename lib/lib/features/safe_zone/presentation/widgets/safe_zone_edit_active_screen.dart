import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:family_guard/lib/core/utils/responsive/responsive.dart';
import 'package:family_guard/lib/core/routes/app_routes.dart';
import 'package:family_guard/lib/features/safe_zone/domain/entities/safe_zone.dart';
import 'package:family_guard/lib/features/safe_zone/data/datasources/safe_zone_service.dart';
import 'package:family_guard/lib/core/theme/app_colors.dart';
import 'package:family_guard/lib/core/widgets/app_dialog.dart';


/// ============================================================
/// SAFE ZONE EDIT ACTIVE SCREEN - Chá»‰nh sá»­a vÃ¹ng an toÃ n Ä‘ang hoáº¡t Ä‘á»™ng
/// ÄÆ°á»£c dá»‹ch vÃ  sá»­a lá»—i tá»« Figma Dev Mode (class ChNhSAVNgAnToNAngHoTNg)
///
/// Lá»—i Figma Ä‘Ã£ sá»­a:
/// - `children: [,]` rá»—ng (icon Sá»¬A, XÃ“A, FAB +) â†’ Icon thá»±c táº¿
/// - `BoxShadow(...)BoxShadow(...)` thiáº¿u `,` â†’ thÃªm `,` (FAB button)
/// - `Expanded(...)` trong `Stack` (card map thumbnail Ã— 3, col TrÆ°á»ng há»c)
///   â†’ StackFit.expand + CustomPaint
/// - `Opacity(child: Expanded(...))` â†’ `Opacity(child: CustomPaint...)`
/// - `NetworkImage("https://placehold.co/...")` Ã— 4 â†’ CustomPainter
/// - FAB `Positioned(left: 322, top: 716)` tuyá»‡t Ä‘á»‘i â†’ `Positioned(right,bottom)`
/// - Swipe-to-reveal: `Container(width: 518)` + `Positioned(left: 160)` Figma
///   (2 action panel Sá»¬A/XÃ“A Ä‘áº±ng sau card) â†’ GestureDetector + AnimatedContainer
/// - `spacing:` Figma property â†’ SizedBox
/// - `class ChNhSAVNgAnToNAngHoTNg` â†’ SafeZoneEditActiveScreen
/// ============================================================

class SafeZoneEditActiveScreen extends StatefulWidget {
  const SafeZoneEditActiveScreen({super.key});

  @override
  State<SafeZoneEditActiveScreen> createState() =>
      _SafeZoneEditActiveScreenState();
}

class _SafeZoneEditActiveScreenState extends State<SafeZoneEditActiveScreen> {

  final List<GlobalKey<_SwipeableCardState>> _cardKeys = [];

  List<SafeZone> get _zones => SafeZoneProvider.of(context).zones;
  int get _activeCount => _zones.where((z) => z.isActive).length;

  void _onEdit(int index) {
    if (index < _cardKeys.length) _cardKeys[index].currentState?.close();
    Navigator.of(context).pushNamed(AppRoutes.safeZoneEdit, arguments: _zones[index].id);
  }

  void _onDelete(int index) {
    if (index < _cardKeys.length) _cardKeys[index].currentState?.close();
    _showDeleteDialog(index);
  }

  void _showDeleteDialog(int index) {
    AppDialog.show(
      context: context,
      type: AppDialogType.delete,
      title: 'XÃ³a vÃ¹ng an toÃ n',
      content: 'Báº¡n cÃ³ cháº¯c muá»‘n xÃ³a "${_zones[index].name}" khÃ´ng?',
      confirmText: 'XÃ³a',
      icon: Icons.delete_outline_rounded,
      onConfirm: () {
        SafeZoneProvider.read(context).removeZone(_zones[index].id);
        Navigator.pop(context); // edit screen
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery Ä‘á»ƒ tÃ­nh safe area bottom (notch, home indicator)
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: AppColors.background,
      // SafeArea bao ngoÃ i toÃ n bá»™ body Ä‘á»ƒ khÃ´ng bá»‹ status bar / notch overlap
      body: SafeArea(
        bottom: false, // bottom xá»­ lÃ½ thá»§ cÃ´ng qua MediaQuery Ä‘á»ƒ FAB chÃ­nh xÃ¡c
        child: Stack(
          children: [
            SingleChildScrollView(
              // bottom padding = FAB height(56) + khoáº£ng cÃ¡ch(32) + safe area bottom
              padding: EdgeInsets.only(
                top: 0,
                left: 16,
                right: 16,
                bottom: 56 + 32 + 16 + bottomPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // â”€â”€ NÃºt quay láº¡i â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                  const SizedBox(height: 16),
                  _buildBackButton(),

                  // â”€â”€ Profile card â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                  const SizedBox(height: 12),
                  _buildProfileCard(),

                  // â”€â”€ TiÃªu Ä‘á» â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'VÃ¹ng an toÃ n Ä‘ang hoáº¡t Ä‘á»™ng',
                            style: TextStyle(
                              color: const Color(0xFF0C1D1A),
                              fontSize: ResponsiveHelper.sp(context, 18),
                              fontFamily: 'Lexend',
                              fontWeight: FontWeight.w700,
                              height: 1.56,
                            ),
                          ),
                        ),
                        // Hint vuá»‘t
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.kPrimaryLight,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.swipe_left_rounded,
                                  size: 14, color: Color(0xFF00ACB2)),
                              const SizedBox(width: 4),
                              Text(
                                'Vuá»‘t Ä‘á»ƒ sá»­a/xÃ³a',
                                style: TextStyle(
                                  color: const Color(0xFF00ACB2),
                                  fontSize: ResponsiveHelper.sp(context, 11),
                                  fontFamily: 'Lexend',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // â”€â”€ Zone cards (swipeable) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
                  const SizedBox(height: 16),
                  ...List.generate(_zones.length, (i) {
                    while (_cardKeys.length <= i) {
                      _cardKeys.add(GlobalKey<_SwipeableCardState>());
                    }
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: i < _zones.length - 1 ? 16 : 0),
                      child: _SwipeableCard(
                        key: _cardKeys[i],
                        onEdit: () => _onEdit(i),
                        onDelete: () => _onDelete(i),
                        child: _buildZoneCardContent(i),
                      ),
                    );
                  }),
                ],
              ),
            ),

            // â”€â”€ FAB: bottom cÄƒn theo safe area, khÃ´ng bá»‹ home indicator che â”€
            Positioned(
              right: 16,
              bottom: 32 + bottomPadding,
              child: _buildFAB(context),
            ),
          ],
        ),
      ),
    );
  }

  // â”€â”€ NÃºt quay láº¡i â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildBackButton() {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        width: 40,
        height: 40,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(9999)),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x0C000000),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: Color(0xFF00ACB2),
        ),
      ),
    );
  }

  // â”€â”€ Profile card â”€â”€ responsive, khÃ´ng overflow â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0x4CE6F4F2)),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar + badge â€” Stack cáº§n clipBehavior Ä‘á»ƒ badge khÃ´ng trÃ n
          SizedBox(
            width: 68, // 64 avatar + 4px overflow badge
            height: 68,
            child: Stack(
              clipBehavior: Clip.none, // badge dot hiá»ƒn thá»‹ táº¡i bottom-right
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(width: 2, color: const Color(0x3300ACB2)),
                  ),
                  child: ClipOval(
                    child: CustomPaint(painter: _ProfileAvatarPainter()),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00ACB2),
                      shape: BoxShape.circle,
                      border: Border.all(width: 2, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // TÃªn + Ä‘áº¿m vÃ¹ng â€” Expanded + mainAxisSize.min Ä‘á»ƒ khÃ´ng bá»‹ Ã©p cao
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min, // tá»± co theo ná»™i dung
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nguyá»…n VÄƒn A',
                  style: TextStyle(
                    color: const Color(0xFF0C1D1A),
                    fontSize: ResponsiveHelper.sp(context, 20),
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w700,
                    height: 1.40,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.shield_rounded,
                        color: Color(0xFF45A191), size: 16),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        '$_activeCount vÃ¹ng an toÃ n Ä‘ang báº­t',
                        style: TextStyle(
                          color: const Color(0xFF45A191),
                          fontSize: ResponsiveHelper.sp(context, 14),
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w500,
                          height: 1.43,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // NÃºt cÃ i Ä‘áº·t â€” kÃ­ch thÆ°á»›c cá»‘ Ä‘á»‹nh 36Ã—36 (icon 20 + padding 8)
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.safeZoneConfig),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: AppColors.kPrimaryLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.settings_rounded,
                color: Color(0xFF00ACB2),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // â”€â”€ Ná»™i dung zone card - responsive, khÃ´ng overflow â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildZoneCardContent(int index) {
    final zone = _zones[index];
    final radiusLabel = zone.radius >= 1000
        ? '${(zone.radius / 1000).toStringAsFixed(zone.radius % 1000 == 0 ? 0 : 1)}KM'
        : '${zone.radius.round()}M';
    return Padding(
      // Padding ngoÃ i thay Container Ä‘á»ƒ khÃ´ng bá»‹ Ã©p chiá»u cao
      padding: const EdgeInsets.all(12),
      child: Row(
        // mainAxisSize.max + crossAxisAlignment.center
        // â†’ tá»± co ngang theo mÃ n, cÄƒn giá»¯a dá»c khÃ´ng cáº§n fixed height
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Map thumbnail: kÃ­ch thÆ°á»›c cá»‘ Ä‘á»‹nh 80Ã—80 lÃ  há»£p lÃ½ (áº£nh báº£n Ä‘á»“)
          _buildMapThumbnail(zone),

          const SizedBox(width: 16),

          // TÃªn + bÃ¡n kÃ­nh + Ä‘á»‹a chá»‰ â€” Expanded Ä‘á»ƒ chiáº¿m pháº§n cÃ²n láº¡i
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,  // khÃ´ng Ã©p chiá»u cao
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HÃ ng tÃªn + radius badge
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        zone.name,
                        style: TextStyle(
                          color: const Color(0xFF0C1D1A),
                          fontSize: ResponsiveHelper.sp(context, 16),
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w700,
                          height: 1.50,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Badge bÃ¡n kÃ­nh: intrinsic size, khÃ´ng overflow
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryLight,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Text(
                        radiusLabel,
                        style: TextStyle(
                          color: const Color(0xFF00ACB2),
                          fontSize: ResponsiveHelper.sp(context, 10),
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w700,
                          height: 1.50,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  zone.address,
                  style: TextStyle(
                    color: const Color(0xFF6B7280),
                    fontSize: ResponsiveHelper.sp(context, 14),
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w400,
                    height: 1.43,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Toggle â€” Center Ä‘á»ƒ cÄƒn giá»¯a khÃ´ng cáº§n Padding thÃªm left:8
          Center(
            child: GestureDetector(
              onTap: () {
                SafeZoneProvider.read(context).toggleZone(zone.id);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 48,
                height: 28,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: zone.isActive
                      ? const Color(0xFF00ACB2)
                      : const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  alignment: zone.isActive
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x0C000000),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
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

  // â”€â”€ Map thumbnail 80Ã—80 â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildMapThumbnail(SafeZone zone) {
    final center = LatLng(zone.latitude, zone.longitude);
    return Container(
      width: 80,
      height: 80,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: IgnorePointer(
        child: FlutterMap(
          options: MapOptions(
            initialCenter: center,
            initialZoom: 14,
            interactionOptions: const InteractionOptions(flags: InteractiveFlag.none),
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
                  radius: 20,
                  color: const Color(0x3300ACB2),
                  borderColor: const Color(0xFF00ACB2),
                  borderStrokeWidth: 2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // â”€â”€ FAB â”€â”€ fix BoxShadow thiáº¿u `,` â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildFAB(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.safeZoneConfig),
      child: Container(
        width: 56,
        height: 56,
        decoration: const BoxDecoration(
          color: Color(0xFF00ACB2),
          shape: BoxShape.circle,
          boxShadow: [
            // fix: thiáº¿u `,` giá»¯a 2 BoxShadow
            BoxShadow(
              color: Color(0x6600ACB2),
              blurRadius: 6,
              offset: Offset(0, 4),
              spreadRadius: -4,
            ),
            BoxShadow(
              color: Color(0x6600ACB2),
              blurRadius: 15,
              offset: Offset(0, 10),
              spreadRadius: -3,
            ),
          ],
        ),
        // fix: `children: [,]` rá»—ng â†’ Icon thá»±c táº¿
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
      ),
    );
  }
}

// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
// SWIPEABLE CARD WIDGET
// Thay tháº¿: Container(width:518) + Positioned(left:160) Figma tuyá»‡t Ä‘á»‘i
// báº±ng GestureDetector + AnimatedContainer Ä‘á»ƒ swipe-left reveal Sá»¬A/XÃ“A
// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
class _SwipeableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _SwipeableCard({
    required this.child,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  State<_SwipeableCard> createState() => _SwipeableCardState();
}

class _SwipeableCardState extends State<_SwipeableCard>
    with SingleTickerProviderStateMixin {
  /// Chiá»u rá»™ng panel action = 2 Ã— 80px, khá»›p Figma left:160
  static const double _actionWidth = 160.0;

  /// Offset hiá»‡n táº¡i khi Ä‘ang kÃ©o tay (chá»‰ dÃ¹ng khi KHÃ”NG animate)
  double _dragOffset = 0;
  bool _isOpen = false;

  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    // Rebuild má»—i tick animation Ä‘á»ƒ card trÆ°á»£t mÆ°á»£t
    _anim.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void close() {
    _ctrl.reverse();
    setState(() {
      _isOpen = false;
      _dragOffset = 0;
    });
  }

  void _open() {
    _ctrl.forward();
    setState(() {
      _isOpen = true;
      _dragOffset = -_actionWidth;
    });
  }

  void _onHorizontalDragUpdate(DragUpdateDetails d) {
    if (_ctrl.isAnimating) return; // bá» qua drag khi Ä‘ang snap
    final delta = d.primaryDelta ?? 0;
    setState(() {
      _dragOffset = (_dragOffset + delta).clamp(-_actionWidth, 0.0);
    });
  }

  void _onHorizontalDragEnd(DragEndDetails d) {
    if (_ctrl.isAnimating) return;
    final threshold = _actionWidth * 0.4;
    if (_dragOffset.abs() > threshold) {
      _open();
    } else {
      close();
    }
  }

  /// Offset dá»©t khoÃ¡t: animation cÃ³ Ä‘á»™ Æ°u tiÃªn cao hÆ¡n drag
  double get _slideX {
    if (_ctrl.isAnimating) {
      return _isOpen
          ? -_anim.value * _actionWidth          // Ä‘ang má»Ÿ
          : -(1 - _anim.value) * _actionWidth;  // Ä‘ang Ä‘Ã³ng
    }
    return _dragOffset;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      // â”€â”€ IntrinsicHeight: tá»± co theo ná»™i dung thay vÃ¬ fixed 104px â”€â”€
      // KhÃ´ng cÃ³ RenderFlex overflow khi font scale hoáº·c mÃ n nhá»
      child: IntrinsicHeight(
        child: Stack(
          children: [
            // â”€â”€ Action panel (Ä‘áº±ng sau, full height theo IntrinsicHeight) â”€
            Positioned.fill(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Sá»¬A (xanh dÆ°Æ¡ng)
                  GestureDetector(
                    onTap: widget.onEdit,
                    child: SizedBox(
                      width: _actionWidth / 2,
                      child: ColoredBox(
                        color: const Color(0xFF3B82F6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.edit_rounded,
                                color: Colors.white, size: 22),
                            const SizedBox(height: 4),
                            Text(
                              'Sá»¬A',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ResponsiveHelper.sp(context, 12),
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w700,
                                height: 1.33,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // XÃ“A (Ä‘á»)
                  GestureDetector(
                    onTap: widget.onDelete,
                    child: SizedBox(
                      width: _actionWidth / 2,
                      child: ColoredBox(
                        color: const Color(0xFFEF4444),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.delete_rounded,
                                color: Colors.white, size: 22),
                            const SizedBox(height: 4),
                            Text(
                              'XÃ“A',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ResponsiveHelper.sp(context, 12),
                                fontFamily: 'Lexend',
                                fontWeight: FontWeight.w700,
                                height: 1.33,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // â”€â”€ Card tráº¯ng (trÃªn cÃ¹ng, trÆ°á»£t sang trÃ¡i) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            // DÃ¹ng Transform.translate thay Positioned Ä‘á»ƒ khÃ´ng áº£nh
            // hÆ°á»Ÿng layout flow, trÃ¡nh overflow khi card Ä‘ang má»Ÿ
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragUpdate: _onHorizontalDragUpdate,
              onHorizontalDragEnd: _onHorizontalDragEnd,
              onTap: _isOpen ? close : null,
              child: Transform.translate(
                offset: Offset(_slideX, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1400ACB2),
                        blurRadius: 20,
                        offset: Offset(0, 4),
                        spreadRadius: -2,
                      ),
                    ],
                  ),
                  child: widget.child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// â”€â”€ Painters â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class _ProfileAvatarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFB2EFE7), Color(0xFF80DDD1)],
        ).createShader(rect),
    );
    final tp = TextPainter(
      text: const TextSpan(
        text: 'A',
        style: TextStyle(
          color: Color(0xFF00796B),
          fontSize: 28,
          fontWeight: FontWeight.w700,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(
        canvas,
        Offset(
            (size.width - tp.width) / 2, (size.height - tp.height) / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
