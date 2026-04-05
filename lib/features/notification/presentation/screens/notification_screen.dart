import 'package:family_guard/core/constants/app_routes.dart';
import 'package:family_guard/core/widgets/app_bottom_menu.dart';
import 'package:family_guard/features/alerts/presentation/screens/child_emergency_alert_screen.dart';
import 'package:family_guard/features/alerts/presentation/screens/senior_fall_alert_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  _NotificationFilter selectedFilter = _NotificationFilter.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F8F7),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const _Header(),
                const SizedBox(height: 10),
                _FilterBar(
                  selectedFilter: selectedFilter,
                  onSelected: (filter) =>
                      setState(() => selectedFilter = filter),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 110),
                    children: _buildNotificationItems(context),
                  ),
                ),
              ],
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AppBottomMenu(current: AppNavTab.notifications),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildNotificationItems(BuildContext context) {
    switch (selectedFilter) {
      case _NotificationFilter.emergency:
        return [
          const _DateDivider(label: 'Hôm nay'),
          const SizedBox(height: 12),
          _EmergencyCard(
            onDetailTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const SeniorFallAlertScreen(),
              ),
            ),
          ),
          const SizedBox(height: 14),
          _WarningCard(
            onCheckTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const ChildEmergencyAlertScreen(),
              ),
            ),
          ),
        ];
      case _NotificationFilter.activity:
        return const [
          _DateDivider(label: 'Hôm nay'),
          SizedBox(height: 12),
          _SafeZoneCard(),
        ];
      case _NotificationFilter.mood:
        return [
          const _DateDivider(label: 'Hôm nay'),
          const SizedBox(height: 12),
          _MoodCard(
            onCheckTap: () =>
                Navigator.pushNamed(context, AppRoutes.emotionJournal),
          ),
        ];
      case _NotificationFilter.all:
        return [
          const _DateDivider(label: 'Hôm nay'),
          const SizedBox(height: 12),
          _EmergencyCard(
            onDetailTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const SeniorFallAlertScreen(),
              ),
            ),
          ),
          const SizedBox(height: 14),
          _WarningCard(
            onCheckTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const ChildEmergencyAlertScreen(),
              ),
            ),
          ),
          const SizedBox(height: 14),
          const _SafeZoneCard(),
          const SizedBox(height: 14),
          _MoodCard(
            onCheckTap: () =>
                Navigator.pushNamed(context, AppRoutes.emotionJournal),
          ),
          const SizedBox(height: 12),
          const _DateDivider(label: 'Hôm qua'),
          const SizedBox(height: 12),
          const _OlderNotificationCard(),
        ];
    }
  }
}

enum _NotificationFilter { all, emergency, activity, mood }

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      padding: const EdgeInsets.fromLTRB(24, 8, 20, 16),
      decoration: const BoxDecoration(
        color: Color(0xFFF0F8F7),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Thông báo',
            style: GoogleFonts.inter(
              color: const Color(0xFF0F172A),
              fontSize: 30,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.75,
              height: 1,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, AppRoutes.settings),
            icon: const Icon(
              Icons.settings,
              color: Color(0xFF334155),
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({required this.selectedFilter, required this.onSelected});

  final _NotificationFilter selectedFilter;
  final ValueChanged<_NotificationFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    const filters = [
      _FilterItem(
        label: 'Tất cả',
        icon: Icons.check,
        filter: _NotificationFilter.all,
        activeColor: Color(0xFF17E8E8),
        borderColor: Color(0xFF17E8E8),
        iconColor: Color(0xFF0F172A),
      ),
      _FilterItem(
        label: 'Khẩn cấp',
        icon: Icons.warning_amber_rounded,
        filter: _NotificationFilter.emergency,
        activeColor: Color(0xFFFEE2E2),
        borderColor: Color(0xFFFECACA),
        iconColor: Color(0xFFEF4444),
      ),
      _FilterItem(
        label: 'Hoạt động',
        icon: Icons.show_chart_rounded,
        filter: _NotificationFilter.activity,
        activeColor: Color(0xFFE2F6F8),
        borderColor: Color(0xFFE2E8F0),
        iconColor: Color(0xFF64748B),
      ),
      _FilterItem(
        label: 'Mood',
        icon: Icons.sentiment_satisfied_alt_outlined,
        filter: _NotificationFilter.mood,
        activeColor: Color(0xFFFEFCE8),
        borderColor: Color(0xFFFEF08A),
        iconColor: Color(0xFFA16207),
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(filters.length, (index) {
          final filter = filters[index];
          final isActive = selectedFilter == filter.filter;
          final bgColor = isActive ? filter.activeColor : Colors.white;
          final borderColor = isActive
              ? Colors.transparent
              : filter.borderColor;

          return Padding(
            padding: EdgeInsets.only(
              right: index == filters.length - 1 ? 0 : 11,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(999),
              onTap: () => onSelected(filter.filter),
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: borderColor),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(filter.icon, size: 18, color: filter.iconColor),
                    const SizedBox(width: 6),
                    Text(
                      filter.label,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF334155),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _FilterItem {
  const _FilterItem({
    required this.label,
    required this.icon,
    required this.filter,
    required this.activeColor,
    required this.borderColor,
    required this.iconColor,
  });

  final String label;
  final IconData icon;
  final _NotificationFilter filter;
  final Color activeColor;
  final Color borderColor;
  final Color iconColor;
}

class _DateDivider extends StatelessWidget {
  const _DateDivider({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: Color(0xFFE2E8F0), thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            label.toUpperCase(),
            style: GoogleFonts.inter(
              color: const Color(0xFF94A3B8),
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.6,
            ),
          ),
        ),
        const Expanded(child: Divider(color: Color(0xFFE2E8F0), thickness: 1)),
      ],
    );
  }
}

class _EmergencyCard extends StatelessWidget {
  const _EmergencyCard({required this.onDetailTap});

  final VoidCallback onDetailTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFFFEE2E2)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -6,
            top: -12,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: const Color(0xFF17E8E8),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(color: Color(0x9917E8E8), blurRadius: 8),
                ],
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.accessibility_new_rounded,
                  color: Color(0xFFEF4444),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Phát hiện té ngã',
                          style: GoogleFonts.inter(
                            color: const Color(0xFFEF4444),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '10:32 AM',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF64748B),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Điện thoại của bà phát hiện một cú ngã\nmạnh trong phòng khách. Bà đã xác\nnhận rằng bà vẫn ổn.',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF475569),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: onDetailTap,
                            borderRadius: BorderRadius.circular(24),
                            child: Container(
                              height: 35,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEF4444),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Chi tiết',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xFFF1F5F9),
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Bỏ qua',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF334155),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WarningCard extends StatelessWidget {
  const _WarningCard({required this.onCheckTap});

  final VoidCallback onCheckTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFFFEE2E2)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.error_outline_rounded,
              color: Color(0xFFFF6B6B),
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cảnh báo',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFEF4444),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '2:10 PM',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF64748B),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Xôi đã phát đi cảnh báo khẩn cấp. Hãy\nkiểm tra ngay!!!',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 14,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: onCheckTap,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Kiểm tra',
                        style: GoogleFonts.inter(
                          color: const Color(0xFFEF4444),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 14,
                        color: Color(0xFFEF4444),
                      ),
                    ],
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

class _SafeZoneCard extends StatelessWidget {
  const _SafeZoneCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -6,
            top: -12,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: const Color(0xFF17E8E8),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(color: Color(0x9917E8E8), blurRadius: 8),
                ],
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0x1A17E8E8),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.location_on_outlined,
                  color: Color(0xFF00ACB1),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rời khỏi khu vực an toàn',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF0F172A),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '11:45 AM',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF64748B),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Xôi đã rời khỏi khu vực an toàn "Trường\nhọc".\nHiện đang di chuyển với tốc độ 15 km/\ngiờ.',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF475569),
                        fontSize: 14,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 96,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Stack(
                        children: [
                          const Center(
                            child: Icon(
                              Icons.map_outlined,
                              size: 28,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                          Positioned(
                            right: 8,
                            bottom: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'Xem vị trí',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF0F172A),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MoodCard extends StatelessWidget {
  const _MoodCard({required this.onCheckTap});

  final VoidCallback onCheckTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: const Color(0xFFFEFCE8),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFFFEF9C3)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.show_chart_rounded,
              color: Color(0xFFA16207),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Thông báo tâm trạng',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF0F172A),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '2:10 PM',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF64748B),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Xôi cho biết anh cảm thấy "lo lắng" suốt\n3 ngày liên tiếp.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 14,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: onCheckTap,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Kiểm tra',
                        style: GoogleFonts.inter(
                          color: const Color(0xFFA16207),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 10,
                        color: Color(0xFFA16207),
                      ),
                    ],
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

class _OlderNotificationCard extends StatelessWidget {
  const _OlderNotificationCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.battery_1_bar_rounded,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pin yếu',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF0F172A),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Hôm qua',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF64748B),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Pin điện thoại của Xôi còn dưới 15%.',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF475569),
                    fontSize: 14,
                    height: 1.45,
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
