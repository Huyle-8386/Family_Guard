import 'package:family_guard/core/routes/app_routes.dart';
import 'package:family_guard/core/utils/responsive/responsive.dart';
import 'package:family_guard/core/widgets/app_back_header.dart';
import 'package:flutter/material.dart';

class ReminderListScreen extends StatefulWidget {
  const ReminderListScreen({super.key});

  @override
  State<ReminderListScreen> createState() => _ReminderListScreenState();
}

class _ReminderListScreenState extends State<ReminderListScreen> {
  final List<ReminderItem> _reminders = [
    ReminderItem(
      id: '1',
      title: 'U\u1ED1ng thu\u1ED1c huy\u1EBFt \u00E1p',
      time: '08:00 - M\u1ED7i ng\u00E0y',
      iconColor: const Color(0x33FF85A1),
      icon: Icons.medication,
      isActive: true,
    ),
    ReminderItem(
      id: '2',
      title: '\u0102n s\u00E1ng',
      time: '07:00 - M\u1ED7i ng\u00E0y',
      iconColor: const Color(0x33FFD166),
      icon: Icons.restaurant,
      isActive: true,
    ),
    ReminderItem(
      id: '3',
      title: '\u0110o huy\u1EBFt \u00E1p',
      time: '09:00, 16:00 - M\u1ED7i ng\u00E0y',
      iconColor: const Color(0x33118AB2),
      icon: Icons.favorite,
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveHelper.horizontalPadding(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF0FFF8), Colors.white],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppBackHeaderBar(title: 'L\u1ECBch nh\u1EAFc \u0111\u00E3 t\u1EA1o'),
                _buildMemberCard(hPad),
                Padding(
                  padding: EdgeInsets.fromLTRB(hPad, 8, hPad, 0),
                  child: Text(
                    'L\u1ECBch nh\u1EAFc \u0111\u00E3 t\u1EA1o',
                    style: TextStyle(
                      color: const Color(0xFF0C1D1A),
                      fontSize: ResponsiveHelper.sp(context, 24),
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                      height: 1.33,
                      letterSpacing: -0.6,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(hPad, 16, hPad, 24),
                  child: Column(
                    children: [
                      ..._reminders.map(
                        (reminder) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _buildReminderCard(reminder),
                        ),
                      ),
                      _buildAddButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMemberCard(double hPad) {
    return Padding(
      padding: EdgeInsets.fromLTRB(hPad, 12, hPad, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0x2600ACB2)),
            borderRadius: BorderRadius.circular(24),
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
          children: [
            Stack(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    image: const DecorationImage(
                      image: NetworkImage('https://i.pravatar.cc/150?img=47'),
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 2, color: Color(0x3300ACB2)),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF22C55E),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'B\u00E0 Lan',
                    style: TextStyle(
                      color: const Color(0xFF0F172A),
                      fontSize: ResponsiveHelper.sp(context, 18),
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                      height: 1.56,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.home_rounded,
                        size: 14,
                        color: Color(0xFF00ACB2),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '\u0110ang \u1EDF nh\u00E0',
                        style: TextStyle(
                          color: const Color(0xFF00ACB2),
                          fontSize: ResponsiveHelper.sp(context, 14),
                          fontFamily: 'Lexend',
                          fontWeight: FontWeight.w500,
                          height: 1.43,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 12,
                      color: Color(0xFF94A3B8),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Qu\u1EADn 7',
                      style: TextStyle(
                        color: const Color(0xFF94A3B8),
                        fontSize: ResponsiveHelper.sp(context, 12),
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.battery_charging_full_rounded,
                      size: 12,
                      color: Color(0xFF64748B),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '85%',
                      style: TextStyle(
                        color: const Color(0xFF64748B),
                        fontSize: ResponsiveHelper.sp(context, 12),
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w700,
                        height: 1.33,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderCard(ReminderItem reminder) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, AppRoutes.reminderDetail),
      onLongPress: () => _showReminderActions(reminder),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0x2600ACB2)),
            borderRadius: BorderRadius.circular(24),
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
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: ShapeDecoration(
                color: reminder.iconColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
              child: Icon(
                reminder.icon,
                color: _getIconColor(reminder.iconColor),
                size: ResponsiveHelper.sp(context, 24),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    reminder.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ResponsiveHelper.sp(context, 16),
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                  Text(
                    reminder.time,
                    style: TextStyle(
                      color: const Color(0xFF64748B),
                      fontSize: ResponsiveHelper.sp(context, 14),
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  reminder.isActive = !reminder.isActive;
                });
              },
              child: _buildToggleSwitch(reminder.isActive),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleSwitch(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 48,
      height: 28,
      padding: EdgeInsets.only(
        left: isActive ? 22 : 2,
        right: isActive ? 2 : 22,
        top: 2,
        bottom: 2,
      ),
      decoration: ShapeDecoration(
        color: isActive ? const Color(0xFF00ACB2) : const Color(0xFFE2E8F0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9999),
        ),
      ),
      child: Container(
        width: 24,
        height: 24,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0C000000),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return OutlinedButton.icon(
      onPressed: () => Navigator.pushNamed(context, AppRoutes.createReminder),
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF00ACB2),
        side: const BorderSide(width: 2, color: Color(0x4C00ACB2)),
      ),
      icon: const Icon(Icons.add_circle_outline, size: 24),
      label: const Text('Th\u00EAm nh\u1EAFc nh\u1EDF m\u1EDBi'),
    );
  }

  Color _getIconColor(Color bgColor) {
    if (bgColor == const Color(0x33FF85A1)) return const Color(0xFFFF85A1);
    if (bgColor == const Color(0x33FFD166)) return const Color(0xFFFFD166);
    if (bgColor == const Color(0x33118AB2)) return const Color(0xFF118AB2);
    return const Color(0xFF00ACB2);
  }

  void _showReminderActions(ReminderItem reminder) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              reminder.title,
              style: const TextStyle(
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Color(0xFF0C1D1A),
              ),
            ),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(
                Icons.edit_outlined,
                color: Color(0xFF00ACB2),
              ),
              title: const Text(
                'Ch\u1EC9nh s\u1EEDa l\u1ECBch nh\u1EAFc',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.reminderListEditable);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.delete_outline,
                color: Color(0xFFEF4444),
              ),
              title: const Text(
                'X\u00F3a l\u1ECBch nh\u1EAFc',
                style: TextStyle(
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFEF4444),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.reminderListDelete);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class ReminderItem {
  ReminderItem({
    required this.id,
    required this.title,
    required this.time,
    required this.iconColor,
    required this.icon,
    required this.isActive,
  });

  final String id;
  final String title;
  final String time;
  final Color iconColor;
  final IconData icon;
  bool isActive;
}
