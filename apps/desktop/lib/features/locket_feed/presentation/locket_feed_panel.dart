import 'package:flutter/material.dart';
import '../../../core/theme/zalo_theme.dart';
import '../../../shared/mock/mock_data.dart';
import '../../../shared/models/chat_models.dart';
import 'widgets/locket_friends_sidebar.dart';
import 'widgets/locket_user_moments_grid.dart';

class LocketFeedPanel extends StatefulWidget {
  const LocketFeedPanel({super.key});

  @override
  State<LocketFeedPanel> createState() => _LocketFeedPanelState();
}

class _LocketFeedPanelState extends State<LocketFeedPanel> {
  final TextEditingController _searchController = TextEditingController();
  ChatUser? _selectedUser; // null = Mục "Tất cả khoảnh khắc"
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Mặc định chọn mục "Tất cả khoảnh khắc" (null) để xem toàn bộ feed
    _selectedUser = null;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Lấy danh sách bạn bè từ mock conversations
    final allFriends = MockData.conversations.map((c) => c.user).toList();

    // Lọc theo từ khóa tìm kiếm
    final filteredFriends = _searchQuery.isEmpty
        ? allFriends
        : allFriends.where((u) {
            final q = _searchQuery.toLowerCase();
            return u.name.toLowerCase().contains(q);
          }).toList();

    return Container(
      color: ZaloColors.background,
      child: Row(
        children: [
          // 1. Cột trái: Nút tìm kiếm + Tất cả + Bản thân + Danh sách bạn bè (~320px)
          LocketFriendsSidebar(
            selectedUser: _selectedUser,
            onUserSelected: (user) {
              setState(() => _selectedUser = user);
            },
            searchController: _searchController,
            onSearchChanged: (query) {
              setState(() => _searchQuery = query);
            },
            friends: filteredFriends,
          ),

          // 2. Cột phải: Lưới xem ảnh khoảnh khắc (Grid 1:1 như bên Chat)
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: LocketUserMomentsGrid(
                key: ValueKey('locket_grid_${_selectedUser?.id ?? 'all'}'),
                user: _selectedUser,
                onPostMoment: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Tính năng chụp và gửi khoảnh khắc Widget đang hoạt động!'),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
