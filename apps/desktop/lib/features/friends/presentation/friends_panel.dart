import 'package:flutter/material.dart';
import '../../../core/theme/zalo_theme.dart';
import '../../../shared/mock/mock_data.dart';
import '../../../shared/models/chat_models.dart';
import 'widgets/friends_list_view.dart';
import 'widgets/friends_sidebar.dart';
import 'widgets/received_requests_view.dart';
import 'widgets/sent_requests_view.dart';

class FriendsPanel extends StatefulWidget {
  final ValueChanged<Conversation> onStartChat;

  const FriendsPanel({super.key, required this.onStartChat});

  @override
  State<FriendsPanel> createState() => _FriendsPanelState();
}

class _FriendsPanelState extends State<FriendsPanel> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedSidebarTab = 0; // 0: Bạn bè (mặc định), 1: Lời mời đã nhận, 2: Lời mời đã gửi
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final friends = MockData.conversations;
    final received = MockData.receivedFriendRequests;
    final sent = MockData.sentFriendRequests;

    return Container(
      color: ZaloColors.background,
      child: Row(
        children: [
          // 1. Left Sidebar Navigation (~320px)
          FriendsSidebar(
            selectedTab: _selectedSidebarTab,
            onTabSelected: (tab) => setState(() => _selectedSidebarTab = tab),
            friendsCount: friends.length,
            receivedCount: received.length,
            sentCount: sent.length,
            searchController: _searchController,
            onSearchChanged: (query) => setState(() => _searchQuery = query),
          ),

          // 2. Right Content View (Expanded)
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              child: _buildSelectedView(friends, received, sent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedView(
    List<Conversation> friends,
    List<FriendRequest> received,
    List<FriendRequest> sent,
  ) {
    switch (_selectedSidebarTab) {
      case 0:
        return FriendsListView(
          key: const ValueKey('friends_list_view'),
          conversations: friends,
          onStartChat: widget.onStartChat,
          searchQuery: _searchQuery,
        );
      case 1:
        return ReceivedRequestsView(
          key: const ValueKey('received_requests_view'),
          requests: received,
        );
      case 2:
        return SentRequestsView(
          key: const ValueKey('sent_requests_view'),
          requests: sent,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
