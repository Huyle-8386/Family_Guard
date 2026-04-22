import 'package:family_guard/core/constants/app_routes.dart';
import 'package:family_guard/core/widgets/app_back_header.dart';
import 'package:family_guard/core/widgets/app_flow_bottom_nav.dart';
import 'package:family_guard/features/chat/presentation/screens/chat_models.dart';
import 'package:family_guard/features/tracking/presentation/screens/member_tracking/member_tracking_models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({
    super.key,
    this.showBottomNav = false,
    this.showBackButton = true,
    this.homeRouteName = AppRoutes.home,
    this.trackingRouteName = AppRoutes.tracking,
    this.thirdTabRouteName = AppRoutes.chatList,
    this.settingsRouteName = AppRoutes.settings,
  });

  final bool showBottomNav;
  final bool showBackButton;
  final String homeRouteName;
  final String trackingRouteName;
  final String thirdTabRouteName;
  final String settingsRouteName;

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  String _query = '';

  List<ChatThreadArgs> get _filteredThreads {
    if (_query.trim().isEmpty) {
      return ChatThreadArgs.demoThreads;
    }

    final normalized = _query.trim().toLowerCase();
    return ChatThreadArgs.demoThreads.where((thread) {
      return thread.memberName.toLowerCase().contains(normalized) ||
          thread.previewText.toLowerCase().contains(normalized) ||
          thread.roleLabel.toLowerCase().contains(normalized);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final todayThreads = _filteredThreads
        .where((thread) => thread.section == ChatThreadSection.today)
        .toList();
    final yesterdayThreads = _filteredThreads
        .where((thread) => thread.section == ChatThreadSection.yesterday)
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Tạo cuộc trò chuyện mới sẽ được cập nhật sau.'),
            ),
          );
        },
        backgroundColor: const Color(0xFF19A7A8),
        foregroundColor: Colors.white,
        elevation: 8,
        shape: const CircleBorder(),
        child: const Icon(Icons.add_rounded, size: 34),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ChatListHeader(
                        showBackButton: widget.showBackButton,
                        onBack: () => Navigator.maybePop(context),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28),
                        child: _SearchField(
                          onChanged: (value) => setState(() => _query = value),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.fromLTRB(
                            28,
                            0,
                            28,
                            widget.showBottomNav ? 128 : 120,
                          ),
                          children: [
                            if (todayThreads.isNotEmpty) ...[
                              const _SectionLabel(text: 'HÔM NAY'),
                              const SizedBox(height: 22),
                              ...todayThreads.map(
                                (thread) => Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: _ChatTile(
                                    thread: thread,
                                    onTap: () => Navigator.pushNamed(
                                      context,
                                      AppRoutes.chatConversation,
                                      arguments: thread,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            if (yesterdayThreads.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              const _SectionLabel(text: 'HÔM QUA'),
                              const SizedBox(height: 22),
                              ...yesterdayThreads.map(
                                (thread) => Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: _ChatTile(
                                    thread: thread,
                                    onTap: () => Navigator.pushNamed(
                                      context,
                                      AppRoutes.chatConversation,
                                      arguments: thread,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            if (_filteredThreads.isEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 96),
                                child: Center(
                                  child: Text(
                                    'Không tìm thấy đoạn chat phù hợp.',
                                    style: GoogleFonts.beVietnamPro(
                                      color: const Color(0xFF64748B),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
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
              ),
            ),
            if (widget.showBottomNav)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: AppFlowBottomNav(
                  current: AppNavTab.notifications,
                  homeRouteName: widget.homeRouteName,
                  trackingRouteName: widget.trackingRouteName,
                  settingsRouteName: widget.settingsRouteName,
                  thirdTab: AppBottomMenuThirdTab.chat,
                  thirdTabRouteName: widget.thirdTabRouteName,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ChatListHeader extends StatelessWidget {
  const _ChatListHeader({
    required this.onBack,
    required this.showBackButton,
  });

  final VoidCallback onBack;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBackHeaderBar(
      title: 'Tin nhắn',
      onBack: showBackButton ? onBack : null,
      showLeading: showBackButton,
      trailing: const SizedBox(width: 24),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFE6E8EA),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, color: Color(0xFF3D4949), size: 21),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm tin nhắn',
                hintStyle: GoogleFonts.beVietnamPro(
                  color: const Color(0x993D4949),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                filled: false,
                fillColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                isCollapsed: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: GoogleFonts.beVietnamPro(
                color: const Color(0xFF191C1E),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.beVietnamPro(
        color: const Color(0x993D4949),
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.4,
      ),
    );
  }
}

class _ChatTile extends StatelessWidget {
  const _ChatTile({required this.thread, required this.onTap});

  final ChatThreadArgs thread;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = thread.hasUnread
        ? Colors.white
        : const Color(0xFFF2F4F6);

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(32),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(32),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            boxShadow: thread.hasUnread
                ? const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipOval(
                    child: Image.network(
                      thread.avatarUrl,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 56,
                        height: 56,
                        color: const Color(0xFFD8E2E2),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.person_rounded,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ),
                  if (thread.isOnline)
                    Positioned(
                      right: -1,
                      bottom: -1,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: const Color(0xFF006A6A),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
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
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            thread.memberName,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.beVietnamPro(
                              color: const Color(0xFF191C1E),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              height: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        _RoleBadge(label: thread.roleLabel, role: thread.role),
                        const Spacer(),
                        Text(
                          thread.lastActivityLabel,
                          style: GoogleFonts.beVietnamPro(
                            color: thread.hasUnread
                                ? const Color(0xFF006A6A)
                                : const Color(0x993D4949),
                            fontSize: 12,
                            fontWeight: thread.hasUnread
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            thread.previewText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.beVietnamPro(
                              color: const Color(0xCC3D4949),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.43,
                            ),
                          ),
                        ),
                        if (thread.hasUnread) ...[
                          const SizedBox(width: 12),
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Color(0xFF19A7A8),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleBadge extends StatelessWidget {
  const _RoleBadge({required this.label, required this.role});

  final String label;
  final MemberRole role;

  @override
  Widget build(BuildContext context) {
    final Color bgColor;
    final Color textColor;

    switch (role) {
      case MemberRole.child:
        bgColor = const Color(0xFFB8E9EA);
        textColor = const Color(0xFF3C6A6B);
        break;
      case MemberRole.adult:
        bgColor = const Color(0x3319A7A8);
        textColor = const Color(0xFF006A6A);
        break;
      case MemberRole.senior:
        bgColor = const Color(0xFFBBEBEC);
        textColor = const Color(0xFF1D4E4F);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: GoogleFonts.beVietnamPro(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
          height: 1.5,
        ),
      ),
    );
  }
}


