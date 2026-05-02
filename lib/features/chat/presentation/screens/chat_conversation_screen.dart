import 'package:family_guard/core/di/app_dependencies.dart';
import 'package:family_guard/core/widgets/app_back_header.dart';
import 'package:family_guard/features/chat/presentation/screens/chat_models.dart';
import 'package:flutter/material.dart';

class ChatConversationScreen extends StatefulWidget {
  const ChatConversationScreen({super.key, required this.thread});

  final ChatThreadArgs thread;

  static ChatThreadArgs fromRoute(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    if (routeArgs is ChatThreadArgs) {
      return routeArgs;
    }
    if (routeArgs is String && routeArgs.trim().isNotEmpty) {
      return ChatThreadArgs(
        id: routeArgs.trim(),
        memberName: 'Thành viên gia đình',
        avatarUrl: '',
        role: ChatThreadArgs.fallback.role,
        presenceLabel: 'Trực tuyến',
        previewText: '',
        lastActivityLabel: '',
        section: ChatThreadSection.today,
        messages: const [],
      );
    }
    return ChatThreadArgs.fallback;
  }

  @override
  State<ChatConversationScreen> createState() => _ChatConversationScreenState();
}

class _ChatConversationScreenState extends State<ChatConversationScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _loading = true;
  bool _sending = false;
  List<ChatMessage> _messages = const [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
    AppDependencies.instance.chatService.updatePresence(widget.thread.id);
  }

  @override
  void dispose() {
    AppDependencies.instance.chatService.updatePresence(null);
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMessages() async {
    try {
      final session = await AppDependencies.instance.getSavedSessionUseCase();
      final myUid = session?.userId ?? '';
      final data = await AppDependencies.instance.chatService.getMessages(
        myUid: myUid,
        peerUid: widget.thread.id,
      );
      if (!mounted) return;
      setState(() => _messages = data);
      _scrollToBottom();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không tải được nội dung trò chuyện')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _sending) {
      return;
    }

    setState(() => _sending = true);
    try {
      await AppDependencies.instance.chatService.sendMessage(
        peerUid: widget.thread.id,
        content: text,
      );
      _controller.clear();
      await _loadMessages();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không gửi được tin nhắn')),
      );
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBackHeaderBar(
              title: widget.thread.memberName,
              onBack: () => Navigator.maybePop(context),
            ),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        final outgoing = message.type == ChatMessageType.outgoingText;
                        return Align(
                          alignment: outgoing
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: outgoing ? Colors.teal : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.text,
                                  style: TextStyle(
                                    color: outgoing ? Colors.white : Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  message.timeLabel,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: outgoing
                                        ? Colors.white70
                                        : Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Soạn tin nhắn...',
                        border: OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: _sending ? null : _send,
                    icon: _sending
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
