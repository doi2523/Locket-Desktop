import 'package:flutter/material.dart';
import '../../../core/theme/zalo_theme.dart';
import '../../../shared/mock/mock_data.dart';
import '../../../shared/models/chat_models.dart';
import '../data/mock_moments_data.dart';
import 'widgets/chat_detail_header.dart';
import 'widgets/chat_floating_input_bar.dart';
import 'widgets/chat_message_timeline.dart';
import 'widgets/moment_detail_viewer.dart';
import 'widgets/shared_moments_gallery.dart';

class ChatDetailPanel extends StatefulWidget {
  final Conversation conversation;
  final VoidCallback? onBackMobile;

  const ChatDetailPanel({
    super.key,
    required this.conversation,
    this.onBackMobile,
  });

  @override
  State<ChatDetailPanel> createState() => _ChatDetailPanelState();
}

class _ChatDetailPanelState extends State<ChatDetailPanel> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late List<ChatMessage> _messages;
  int _selectedHeaderTab = 0; // 0: Tin nhắn, 1: Khoảnh khắc

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  void didUpdateWidget(covariant ChatDetailPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.conversation.id != widget.conversation.id) {
      _loadMessages();
    }
  }

  void _loadMessages() {
    _messages = List.from(
      MockData.messages[widget.conversation.id] ?? [],
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final newMsg = ChatMessage(
      id: 'm_${DateTime.now().millisecondsSinceEpoch}',
      senderId: MockData.currentUser.id,
      text: text,
      timestamp: DateTime.now(),
      isMe: true,
    );

    setState(() {
      _messages.add(newMsg);
      _messageController.clear();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleMomentTap(ChatMessage msg) {
    final moments = MockMomentsData.sampleFriendMoments;
    final matchedIndex = moments.indexWhere(
      (m) => m['url']!.split('?').first == msg.mediaUrl?.split('?').first,
    );

    MomentDetailViewer.show(
      context,
      moments: moments,
      initialIndex: matchedIndex != -1 ? matchedIndex : 0,
      friendName: widget.conversation.user.name,
      friendAvatarUrl: widget.conversation.user.avatarUrl,
      customHeroTag: 'moment_bubble_${msg.id}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ZaloColors.background,
      child: Column(
        children: [
          // 1. Header with sliding segmented tab & 3-dots menu
          ChatDetailHeader(
            conversation: widget.conversation,
            onBackMobile: widget.onBackMobile,
            selectedTab: _selectedHeaderTab,
            onTabChanged: (index) => setState(() => _selectedHeaderTab = index),
          ),

          // 2. Body: Switch between Messages Timeline & Shared Moments Gallery
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 240),
              child: _selectedHeaderTab == 0
                  ? Stack(
                      children: [
                        // Message list
                        Positioned.fill(
                          child: ChatMessageTimeline(
                            messages: _messages,
                            scrollController: _scrollController,
                            onMomentTap: _handleMomentTap,
                          ),
                        ),
                        // Floating minimal input bar
                        Positioned(
                          left: 24,
                          right: 24,
                          bottom: 20,
                          child: ChatFloatingInputBar(
                            controller: _messageController,
                            onSend: _sendMessage,
                          ),
                        ),
                      ],
                    )
                  : SharedMomentsGallery(
                      key: const ValueKey('shared_moments_gallery'),
                      moments: MockMomentsData.sampleFriendMoments,
                      friendName: widget.conversation.user.name,
                      friendAvatarUrl: widget.conversation.user.avatarUrl,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
