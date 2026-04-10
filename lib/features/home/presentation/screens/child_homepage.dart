import 'package:family_guard/core/constants/app_routes.dart';
import 'package:family_guard/core/widgets/app_bottom_menu.dart';
import 'package:family_guard/features/calling/presentation/screens/call_flow_models.dart';
import 'package:family_guard/features/tracking/presentation/screens/member_tracking/member_tracking_models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChildHomePage extends StatelessWidget {
  const ChildHomePage({super.key});

  static const _bg = Color(0xFFF5FBFF);
  static const _surface = Colors.white;
  static const _blue = Color(0xFF1FA5FF);
  static const _blueDark = Color(0xFF0E5F9A);
  static const _cyan = Color(0xFF12C4C0);
  static const _yellow = Color(0xFFFFC94A);
  static const _pink = Color(0xFFFF7FA5);
  static const _green = Color(0xFF27C383);
  static const _text = Color(0xFF172B4D);
  static const _muted = Color(0xFF6E7E96);
  static const _danger = Color(0xFFFF5E6A);

  static const _contacts = [
    _ChildContact(
      name: 'M\u1EB9 Lan',
      relation: 'M\u1EB9',
      initial: 'L',
      accent: Color(0xFFFFE8E0),
      chatThreadId: 'me-lan',
      callArgs: InAppCallArgs(
        name: 'Tr\u1EA7n Th\u1ECB Lan',
        avatarUrl:
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=400&auto=format&fit=crop',
        role: MemberRole.adult,
      ),
    ),
    _ChildContact(
      name: 'Ba Minh',
      relation: 'Ba',
      initial: 'M',
      accent: Color(0xFFE3F4FF),
      chatThreadId: 'ba-minh',
      callArgs: InAppCallArgs(
        name: 'Nguy\u1EC5n V\u0103n Minh',
        avatarUrl:
            'https://images.unsplash.com/photo-1599566150163-29194dcaad36?q=80&w=400&auto=format&fit=crop',
        role: MemberRole.adult,
      ),
    ),
    _ChildContact(
      name: 'B\u00E0 n\u1ED9i',
      relation: 'B\u00E0',
      initial: 'H',
      accent: Color(0xFFEAF8F1),
      chatThreadId: 'ba-noi',
      callArgs: InAppCallArgs(
        name: 'L\u00EA Th\u1ECB Hoa',
        avatarUrl:
            'https://images.unsplash.com/photo-1517841905240-472988babdf9?q=80&w=400&auto=format&fit=crop',
        role: MemberRole.senior,
      ),
    ),
  ];

  static const _actions = [
    _ChildAction(
      title: 'SOS',
      subtitle: 'G\u1ECDi ngay cho gia \u0111\u00ECnh',
      icon: Icons.sos_rounded,
      color: _danger,
      isPrimary: true,
    ),
    _ChildAction(
      title: 'Chat nh\u00F3m',
      subtitle: 'N\u00F3i chuy\u1EC7n v\u1EDBi c\u1EA3 nh\u00E0',
      icon: Icons.chat_bubble_rounded,
      color: _blue,
      routeName: AppRoutes.kidChatList,
    ),
    _ChildAction(
      title: 'B\u1EA3n \u0111\u1ED3',
      subtitle: 'Xem v\u1ECB tr\u00ED h\u00F4m nay',
      icon: Icons.map_rounded,
      color: _cyan,
      routeName: AppRoutes.kidLocation,
    ),
    _ChildAction(
      title: 'Nh\u1EAFc nh\u1EDF',
      subtitle: 'L\u1ECBch h\u1ECDc v\u00E0 gi\u1EDD v\u1EC1 nh\u00E0',
      icon: Icons.alarm_rounded,
      color: _yellow,
      routeName: AppRoutes.reminderManagement,
    ),
  ];

  static const _missions = [
    _ChildMission(
      title: 'L\u1EDBp h\u1ECDc th\u00EAm',
      subtitle: '16:00 - 17:30 t\u1EA1i Trung t\u00E2m Sao Vi\u1EC7t',
      badge: '\u0110ang di\u1EC5n ra',
      color: _blue,
      routeName: AppRoutes.reminderManagement,
    ),
    _ChildMission(
      title: 'V\u1EC1 nh\u00E0 tr\u01B0\u1EDBc 18:30',
      subtitle: 'Ba v\u00E0 M\u1EB9 \u0111ang theo d\u00F5i \u0111\u01B0\u1EDDng v\u1EC1',
      badge: 'Quan tr\u1ECDng',
      color: _danger,
      routeName: AppRoutes.safeZone,
    ),
    _ChildMission(
      title: 'S\u1EA1c m\u00E1y khi v\u1EC1',
      subtitle: 'Pin hi\u1EC7n t\u1EA1i c\u00F2n 18%',
      badge: 'Pin y\u1EBFu',
      color: _yellow,
      routeName: AppRoutes.reminderManagement,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned.fill(child: _KidBackground()),
            Positioned.fill(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 128),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHero(context),
                    const SizedBox(height: 20),
                    _buildTodayCard(),
                    const SizedBox(height: 20),
                    _buildSectionTitle('\u0110i\u1EC1u khi\u1EC3n nhanh'),
                    const SizedBox(height: 12),
                    _buildActionsGrid(context),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Ng\u01B0\u1EDDi th\u00E2n c\u1EE7a b\u1EA1n'),
                    const SizedBox(height: 12),
                    _buildContacts(context),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Nhi\u1EC7m v\u1EE5 h\u00F4m nay'),
                    const SizedBox(height: 12),
                    _buildMissions(context),
                  ],
                ),
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AppBottomMenu(
                current: AppNavTab.home,
                homeRouteName: AppRoutes.kidHome,
                trackingRouteName: AppRoutes.kidLocation,
                settingsRouteName: AppRoutes.kidProfile,
                thirdTab: AppBottomMenuThirdTab.chat,
                thirdTabRouteName: AppRoutes.kidChatList,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Color(0x141FA5FF),
            blurRadius: 26,
            offset: Offset(0, 10),
            spreadRadius: -12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFA9E5FF), Color(0xFF5EC8FF)],
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0x331FA5FF), width: 2),
                ),
                alignment: Alignment.center,
                child: Text(
                  'A',
                  style: GoogleFonts.lexend(
                    color: _blueDark,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Xin ch\u00E0o An',
                      style: GoogleFonts.lexend(
                        color: _blueDark,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Nguy\u1EC5n Minh An',
                      style: GoogleFonts.beVietnamPro(
                        color: _muted,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\u0110ang h\u1ECDc th\u00EAm t\u1EA1i Trung t\u00E2m Sao Vi\u1EC7t',
                      style: GoogleFonts.beVietnamPro(
                        color: _text,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              _HeroRoundAction(
                icon: Icons.chat_bubble_rounded,
                color: _blue,
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.kidChatList),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF28B0FF), Color(0xFF0E8DE2)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.school_rounded, color: Colors.white, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Trung t\u00E2m Anh ng\u1EEF Sao Vi\u1EC7t, Qu\u1EADn 7',
                        style: GoogleFonts.beVietnamPro(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: const [
                    Expanded(
                      child: _KidMetric(
                        label: 'Pin',
                        value: '18%',
                        icon: Icons.battery_3_bar_rounded,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _KidMetric(
                        label: 'V\u00F9ng hi\u1EC7n t\u1EA1i',
                        value: 'H\u1ECDc th\u00EAm',
                        icon: Icons.place_rounded,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _KidMetric(
                        label: 'Gia \u0111\u00ECnh',
                        value: '3 online',
                        icon: Icons.groups_rounded,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () =>
                      Navigator.pushNamed(context, AppRoutes.kidLocation),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFFE6F6FF),
                    foregroundColor: _blueDark,
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  icon: const Icon(Icons.map_rounded),
                  label: Text(
                    'Xem b\u1EA3n \u0111\u1ED3',
                    style: GoogleFonts.lexend(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showSosSheet(context),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFFFFECEE),
                    foregroundColor: _danger,
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  icon: const Icon(Icons.sos_rounded),
                  label: Text(
                    'SOS',
                    style: GoogleFonts.lexend(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTodayCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1212C4C0),
            blurRadius: 20,
            offset: Offset(0, 8),
            spreadRadius: -12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6FFFD),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.verified_rounded, color: _cyan),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'H\u00F4m nay b\u1EA1n \u0111ang an to\u00E0n',
                      style: GoogleFonts.lexend(
                        color: _text,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Ba v\u00E0 M\u1EB9 \u0111\u00E3 nh\u1EADn \u0111\u01B0\u1EE3c v\u1ECB tr\u00ED c\u1EE7a b\u1EA1n.',
                      style: GoogleFonts.beVietnamPro(
                        color: _muted,
                        fontSize: 14,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const [
              _StatusChip(
                icon: Icons.schedule_rounded,
                label: 'Tan h\u1ECDc 17:30',
                bgColor: Color(0xFFEAF4FF),
                color: _blueDark,
              ),
              _StatusChip(
                icon: Icons.bolt_rounded,
                label: 'Pin 18%',
                bgColor: Color(0xFFFFF5D9),
                color: Color(0xFFB88100),
              ),
              _StatusChip(
                icon: Icons.home_rounded,
                label: 'Nh\u00E0 tr\u01B0\u1EDBc 18:30',
                bgColor: Color(0xFFEAFBF3),
                color: _green,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionsGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _actions.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.12,
      ),
      itemBuilder: (context, index) {
        final action = _actions[index];
        return InkWell(
          onTap: () => _handleActionTap(context, action),
          borderRadius: BorderRadius.circular(24),
          child: Ink(
            decoration: BoxDecoration(
              color: action.isPrimary
                  ? const Color(0xFFFFF2F4)
                  : _surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: action.isPrimary
                    ? const Color(0xFFFFD4D9)
                    : const Color(0x141FA5FF),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x121FA5FF),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                  spreadRadius: -12,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: action.color.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(action.icon, color: action.color, size: 24),
                  ),
                  const Spacer(),
                  Text(
                    action.title,
                    style: GoogleFonts.lexend(
                      color: _text,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    action.subtitle,
                    style: GoogleFonts.beVietnamPro(
                      color: _muted,
                      fontSize: 13,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContacts(BuildContext context) {
    return Column(
      children: _contacts.map((contact) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _surface,
              borderRadius: BorderRadius.circular(22),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x121FA5FF),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                  spreadRadius: -12,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: contact.accent,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    contact.initial,
                    style: GoogleFonts.lexend(
                      color: _blueDark,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.name,
                        style: GoogleFonts.lexend(
                          color: _text,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        contact.relation,
                        style: GoogleFonts.beVietnamPro(
                          color: _muted,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                _MiniButton(
                  icon: Icons.chat_bubble_rounded,
                  color: _blue,
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.kidChatConversation,
                    arguments: contact.chatThreadId,
                  ),
                ),
                const SizedBox(width: 8),
                _MiniButton(
                  icon: Icons.call_rounded,
                  color: _green,
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.inAppCall,
                    arguments: contact.callArgs,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMissions(BuildContext context) {
    return Column(
      children: _missions.map((mission) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () => Navigator.pushNamed(context, mission.routeName),
            borderRadius: BorderRadius.circular(24),
            child: Ink(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _surface,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x121FA5FF),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                    spreadRadius: -12,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: mission.color.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(Icons.flag_rounded, color: mission.color),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mission.title,
                          style: GoogleFonts.lexend(
                            color: _text,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          mission.subtitle,
                          style: GoogleFonts.beVietnamPro(
                            color: _muted,
                            fontSize: 14,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: mission.color.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      mission.badge,
                      style: GoogleFonts.lexend(
                        color: mission.color,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.lexend(
        color: _blueDark,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  static void _handleActionTap(BuildContext context, _ChildAction action) {
    if (action.isPrimary) {
      _showSosSheet(context);
      return;
    }
    if (action.routeName != null) {
      Navigator.pushNamed(context, action.routeName!);
    }
  }

  static void _showSosSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: _surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6EDF4),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'SOS kh\u1EA9n c\u1EA5p',
                style: GoogleFonts.lexend(
                  color: _text,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'B\u1EA1n c\u00F3 th\u1EC3 g\u1ECDi ngay cho Ba, M\u1EB9 ho\u1EB7c m\u1EDF chat gia \u0111\u00ECnh.',
                style: GoogleFonts.beVietnamPro(
                  color: _muted,
                  fontSize: 15,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 18),
              _BottomActionTile(
                title: 'G\u1ECDi M\u1EB9 Lan',
                subtitle: 'Li\u00EAn l\u1EA1c nhanh nh\u1EA5t',
                icon: Icons.call_rounded,
                color: _green,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    AppRoutes.inAppCall,
                    arguments: _contacts.first.callArgs,
                  );
                },
              ),
              const SizedBox(height: 12),
              _BottomActionTile(
                title: 'G\u1ECDi Ba Minh',
                subtitle: 'Ba s\u1EBD theo d\u00F5i b\u1EA3n \u0111\u1ED3 ngay',
                icon: Icons.support_agent_rounded,
                color: _blue,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    AppRoutes.inAppCall,
                    arguments: _contacts[1].callArgs,
                  );
                },
              ),
              const SizedBox(height: 12),
              _BottomActionTile(
                title: 'M\u1EDF chat gia \u0111\u00ECnh',
                subtitle: 'G\u1EEDi tin nh\u1EAFn cho c\u1EA3 nh\u00E0',
                icon: Icons.chat_bubble_rounded,
                color: _pink,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRoutes.kidChatList);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _KidBackground extends StatelessWidget {
  const _KidBackground();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -70,
            right: -50,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFD8F4FF).withValues(alpha: 0.9),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: -70,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFE9FFF7).withValues(alpha: 0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroRoundAction extends StatelessWidget {
  const _HeroRoundAction({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color),
      ),
    );
  }
}

class _KidMetric extends StatelessWidget {
  const _KidMetric({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.lexend(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.beVietnamPro(
              color: Colors.white.withValues(alpha: 0.88),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color bgColor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.lexend(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniButton extends StatelessWidget {
  const _MiniButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Ink(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }
}

class _BottomActionTile extends StatelessWidget {
  const _BottomActionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Ink(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.lexend(
                      color: ChildHomePage._text,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.beVietnamPro(
                      color: ChildHomePage._muted,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, color: color, size: 16),
          ],
        ),
      ),
    );
  }
}

class _ChildAction {
  const _ChildAction({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.routeName,
    this.isPrimary = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String? routeName;
  final bool isPrimary;
}

class _ChildMission {
  const _ChildMission({
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.color,
    required this.routeName,
  });

  final String title;
  final String subtitle;
  final String badge;
  final Color color;
  final String routeName;
}

class _ChildContact {
  const _ChildContact({
    required this.name,
    required this.relation,
    required this.initial,
    required this.accent,
    required this.chatThreadId,
    required this.callArgs,
  });

  final String name;
  final String relation;
  final String initial;
  final Color accent;
  final String chatThreadId;
  final InAppCallArgs callArgs;
}
