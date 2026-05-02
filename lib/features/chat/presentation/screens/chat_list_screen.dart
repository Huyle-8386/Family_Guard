import 'package:family_guard/core/constants/app_routes.dart';
import 'package:family_guard/core/di/app_dependencies.dart';
import 'package:family_guard/core/widgets/app_back_header.dart';
import 'package:family_guard/core/widgets/app_flow_bottom_nav.dart';
import 'package:family_guard/features/chat/presentation/screens/chat_models.dart';
import 'package:flutter/material.dart';

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
  bool _loading = true;
  String _query = '';
  List<ChatThreadArgs> _threads = const [];

  @override
  void initState() {
    super.initState();
    _loadThreads();
  }

  List<ChatThreadArgs> get _filtered {
    if (_query.trim().isEmpty) return _threads;
    final keyword = _query.trim().toLowerCase();
    return _threads.where((thread) {
      return thread.memberName.toLowerCase().contains(keyword) ||
          thread.previewText.toLowerCase().contains(keyword);
    }).toList();
  }

  Future<void> _loadThreads() async {
    setState(() => _loading = true);
    try {
      final data = await AppDependencies.instance.chatService.getThreads();
      if (!mounted) return;
      setState(() => _threads = data);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không tải được danh sách tin nhắn')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                AppBackHeaderBar(
                  title: 'Tin nhắn',
                  showLeading: widget.showBackButton,
                  onBack: widget.showBackButton
                      ? () => Navigator.maybePop(context)
                      : null,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Tìm kiếm tin nhắn',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => setState(() => _query = value),
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _loadThreads,
                    child: _loading
                        ? const Center(child: CircularProgressIndicator())
                        : _filtered.isEmpty
                        ? ListView(
                            children: const [
                              SizedBox(height: 140),
                              Center(
                                child: Text(
                                  'Chưa có cuộc trò chuyện nào',
                                ),
                              ),
                            ],
                          )
                        : ListView.separated(
                            padding: EdgeInsets.only(
                              bottom: widget.showBottomNav ? 96 : 16,
                            ),
                            itemBuilder: (context, index) {
                              final thread = _filtered[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  child: Text(
                                    thread.memberName.isNotEmpty
                                        ? thread.memberName[0].toUpperCase()
                                        : '?',
                                  ),
                                ),
                                title: Text(thread.memberName),
                                subtitle: Text(
                                  thread.previewText,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: thread.hasUnread
                                    ? const Icon(
                                        Icons.brightness_1,
                                        size: 10,
                                        color: Colors.teal,
                                      )
                                    : Text(thread.lastActivityLabel),
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  AppRoutes.chatConversation,
                                  arguments: thread,
                                ),
                              );
                            },
                            separatorBuilder: (_, _) => const Divider(height: 1),
                            itemCount: _filtered.length,
                          ),
                  ),
                ),
              ],
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
