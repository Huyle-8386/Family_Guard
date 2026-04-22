import 'dart:ui';

import 'package:family_guard/features/calling/presentation/screens/call_flow_models.dart';
import 'package:family_guard/features/calling/presentation/widgets/call_bottom_sheets.dart';
import 'package:family_guard/features/chat/presentation/screens/chat_models.dart';
import 'package:family_guard/features/chat/presentation/widgets/share_location_dialog.dart';
import 'package:family_guard/core/widgets/app_back_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatConversationScreen extends StatefulWidget {
  const ChatConversationScreen({super.key, required this.thread});

  final ChatThreadArgs thread;

  static ChatThreadArgs fromRoute(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    return routeArgs is ChatThreadArgs ? routeArgs : ChatThreadArgs.fallback;
  }

  @override
  State<ChatConversationScreen> createState() => _ChatConversationScreenState();
}

class _ChatConversationScreenState extends State<ChatConversationScreen> {
  final TextEditingController _composerController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late List<ChatMessage> _messages;

  @override
  void initState() {
    super.initState();
    _messages = List<ChatMessage>.from(widget.thread.messages);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    _composerController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F8F7),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: Column(
              children: [
                _ConversationHeader(
                  thread: widget.thread,
                  onBack: () => Navigator.maybePop(context),
                  onCallTap: () => showRoleCallOptionsSheet(
                    context,
                    target: CallTargetArgs(
                      name: widget.thread.memberName,
                      avatarUrl: widget.thread.avatarUrl,
                      role: widget.thread.role,
                      presenceLabel: widget.thread.presenceLabel,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: message.type == ChatMessageType.systemNotice
                              ? 24
                              : 18,
                        ),
                        child: _MessageItem(message: message),
                      );
                    },
                  ),
                ),
                _ComposerBar(
                  controller: _composerController,
                  onSend: _handleSend,
                  onShareLocation: _handleShareLocation,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleShareLocation() async {
    final accepted = await showShareLocationDialog(context);
    if (accepted != true || !mounted) {
      return;
    }

    setState(() {
      _messages = [
        ..._messages,
        ChatMessage.location(timeLabel: _formatNow(), isOutgoingLocation: true),
      ];
    });
    _scrollToBottom();
  }

  void _handleSend() {
    final text = _composerController.text.trim();
    if (text.isEmpty) {
      return;
    }

    setState(() {
      _messages = [
        ..._messages,
        ChatMessage.outgoing(text: text, timeLabel: _formatNow()),
      ];
      _composerController.clear();
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) {
        return;
      }
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
      );
    });
  }

  String _formatNow() {
    final now = TimeOfDay.now();
    final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}

class _ConversationHeader extends StatelessWidget {
  const _ConversationHeader({
    required this.thread,
    required this.onBack,
    required this.onCallTap,
  });

  final ChatThreadArgs thread;
  final VoidCallback onBack;
  final VoidCallback onCallTap;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: AppBackHeaderBar(
          title: thread.memberName,
          onBack: onBack,
          backgroundColor: Colors.transparent,
          trailing: IconButton(
            onPressed: onCallTap,
            splashRadius: 20,
            icon: const Icon(
              Icons.call_outlined,
              color: Color(0xFF3D4949),
              size: 22,
            ),
          ),
          trailingAreaWidth: 44,
        ),
      ),
    );
  }
}

class _MessageItem extends StatelessWidget {
  const _MessageItem({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    switch (message.type) {
      case ChatMessageType.incomingText:
        return _TextBubble(
          text: message.text,
          timeLabel: message.timeLabel,
          isOutgoing: false,
        );
      case ChatMessageType.outgoingText:
        return _TextBubble(
          text: message.text,
          timeLabel: message.timeLabel,
          isOutgoing: true,
        );
      case ChatMessageType.systemNotice:
        return _SystemBubble(text: message.text);
      case ChatMessageType.locationCard:
        return _LocationBubble(
          timeLabel: message.timeLabel,
          title: message.text,
          isOutgoing: message.isOutgoingLocation,
        );
    }
  }
}

class _TextBubble extends StatelessWidget {
  const _TextBubble({
    required this.text,
    required this.timeLabel,
    required this.isOutgoing,
  });

  final String text;
  final String timeLabel;
  final bool isOutgoing;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isOutgoing
        ? const Color(0xFF19A7A8)
        : const Color(0xFFF2F4F6);
    final textColor = isOutgoing ? Colors.white : const Color(0xFF191C1E);

    return Align(
      alignment: isOutgoing ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.68,
        ),
        child: Column(
          crossAxisAlignment: isOutgoing
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isOutgoing ? 16 : 2),
                  bottomRight: Radius.circular(isOutgoing ? 2 : 16),
                ),
                boxShadow: isOutgoing
                    ? const [
                        BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ]
                    : null,
              ),
              child: Text(
                text,
                style: GoogleFonts.beVietnamPro(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                timeLabel,
                style: GoogleFonts.beVietnamPro(
                  color: const Color(0xFF3D4949),
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SystemBubble extends StatelessWidget {
  const _SystemBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0x80E6E8EA),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.beVietnamPro(
            color: const Color(0xFF3D4949),
            fontSize: 12,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}

class _LocationBubble extends StatelessWidget {
  const _LocationBubble({
    required this.timeLabel,
    required this.title,
    required this.isOutgoing,
  });

  final String timeLabel;
  final String title;
  final bool isOutgoing;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isOutgoing ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 280),
        child: Column(
          crossAxisAlignment: isOutgoing
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: const Color(0x1ABCC9C9)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Column(
                  children: [
                    Container(
                      height: 160,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF5FD2B5), Color(0xFF1AA6D9)],
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: CustomPaint(painter: _MapPatternPainter()),
                          ),
                          Center(
                            child: Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.9),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.location_on_rounded,
                                color: Color(0xFF006A6A),
                                size: 34,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: const Color(0xFFF2F4F6),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: Color(0xFF006A6A),
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              isOutgoing
                                  ? 'Bạn đã chia sẻ vị trí hiện tại'
                                  : title,
                              style: GoogleFonts.beVietnamPro(
                                color: const Color(0xFF191C1E),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right_rounded,
                            color: Color(0xFF64748B),
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                timeLabel,
                style: GoogleFonts.beVietnamPro(
                  color: const Color(0xFF3D4949),
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ComposerBar extends StatelessWidget {
  const _ComposerBar({
    required this.controller,
    required this.onSend,
    required this.onShareLocation,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final Future<void> Function() onShareLocation;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          color: Colors.white.withValues(alpha: 0.82),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 17),
          child: Row(
            children: [
              IconButton(
                onPressed: () => onShareLocation(),
                splashRadius: 20,
                icon: const Icon(
                  Icons.my_location_rounded,
                  color: Color(0xFF3D4949),
                  size: 24,
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Container(
                  height: 64,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6E8EA),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Center(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'Soạn tin nhắn....',
                        hintStyle: GoogleFonts.beVietnamPro(
                          color: const Color(0x993D4949),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                      ),
                      style: GoogleFonts.beVietnamPro(
                        color: const Color(0xFF191C1E),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => onSend(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: onSend,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Color(0xFF02ADB2),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x33006A6A),
                        blurRadius: 15,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MapPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    final thinPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.14)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final majorRoad = Path()
      ..moveTo(size.width * 0.08, size.height * 0.25)
      ..quadraticBezierTo(
        size.width * 0.35,
        size.height * 0.05,
        size.width * 0.9,
        size.height * 0.18,
      )
      ..quadraticBezierTo(
        size.width * 0.62,
        size.height * 0.45,
        size.width * 0.84,
        size.height * 0.88,
      );
    canvas.drawPath(majorRoad, roadPaint);

    final minorRoad = Path()
      ..moveTo(size.width * 0.15, size.height * 0.72)
      ..quadraticBezierTo(
        size.width * 0.42,
        size.height * 0.52,
        size.width * 0.78,
        size.height * 0.66,
      );
    canvas.drawPath(minorRoad, thinPaint);

    canvas.drawCircle(
      Offset(size.width * 0.25, size.height * 0.34),
      24,
      Paint()..color = Colors.white.withValues(alpha: 0.12),
    );
    canvas.drawCircle(
      Offset(size.width * 0.72, size.height * 0.7),
      36,
      Paint()..color = Colors.white.withValues(alpha: 0.1),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
