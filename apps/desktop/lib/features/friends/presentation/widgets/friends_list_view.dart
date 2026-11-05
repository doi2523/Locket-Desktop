import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/zalo_theme.dart';
import '../../../../shared/models/chat_models.dart';

class FriendsListView extends StatelessWidget {
  final List<Conversation> conversations;
  final ValueChanged<Conversation> onStartChat;
  final String searchQuery;

  const FriendsListView({
    super.key,
    required this.conversations,
    required this.onStartChat,
    this.searchQuery = '',
  });

  @override
  Widget build(BuildContext context) {
    final filtered = searchQuery.isEmpty
        ? conversations
        : conversations.where((c) {
            return c.user.name.toLowerCase().contains(searchQuery.toLowerCase());
          }).toList();

    return Column(
      children: [
        // 1. Header Bar
        Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: ZaloColors.border, width: 0.5),
            ),
          ),
          child: Row(
            children: [
              const FaIcon(
                FontAwesomeIcons.userGroup,
                size: 16,
                color: Color(0xFF2563EB),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Danh sách bạn bè',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ZaloColors.textPrimary,
                    ),
                  ),
                  Text(
                    '${filtered.length} người bạn trên Locket Dio',
                    style: const TextStyle(
                      fontSize: 12,
                      color: ZaloColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              FilledButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Chức năng thêm bạn bè qua SĐT / ID Locket')),
                  );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF1E1E1E),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                icon: const FaIcon(FontAwesomeIcons.userPlus, size: 12),
                label: const Text(
                  'Thêm bạn mới',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),

        // 2. Friends List
        Expanded(
          child: filtered.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(FontAwesomeIcons.magnifyingGlass, size: 32, color: ZaloColors.textMuted),
                      SizedBox(height: 12),
                      Text(
                        'Không tìm thấy bạn bè nào phù hợp',
                        style: TextStyle(color: ZaloColors.textSecondary, fontSize: 14),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: filtered.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final conv = filtered[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
                        border: Border.all(color: ZaloColors.border.withValues(alpha: 0.8)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Avatar with Online dot
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundImage: NetworkImage(conv.user.avatarUrl),
                              ),
                              if (conv.user.isOnline)
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    width: 11,
                                    height: 11,
                                    decoration: BoxDecoration(
                                      color: ZaloColors.online,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 2),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 14),
                          // Name and Status
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  conv.user.name,
                                  style: const TextStyle(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.bold,
                                    color: ZaloColors.textPrimary,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  conv.user.isOnline
                                      ? 'Đang hoạt động'
                                      : 'Hoạt động ${conv.user.lastActive}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: conv.user.isOnline
                                        ? ZaloColors.online
                                        : ZaloColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Message Button
                          OutlinedButton.icon(
                            onPressed: () => onStartChat(conv),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF1E1E1E),
                              side: BorderSide(color: Colors.black.withValues(alpha: 0.16)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            ),
                            icon: const FaIcon(FontAwesomeIcons.commentDots, size: 12),
                            label: const Text('Nhắn tin', style: TextStyle(fontSize: 12.5)),
                          ),
                          const SizedBox(width: 8),
                          // 3-dots Menu
                          PopupMenuButton<String>(
                            tooltip: 'Tùy chọn',
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
                            ),
                            borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                            onSelected: (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Đã chọn: $value')),
                              );
                            },
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent,
                              ),
                              child: const Center(
                                child: FaIcon(
                                  FontAwesomeIcons.ellipsisVertical,
                                  size: 13,
                                  color: ZaloColors.textSecondary,
                                ),
                              ),
                            ),
                            itemBuilder: (context) => [
                              const PopupMenuItem(
                                value: 'Xem trang cá nhân',
                                child: Text('Xem trang cá nhân', style: TextStyle(fontSize: 13)),
                              ),
                              const PopupMenuItem(
                                value: 'Chia sẻ danh thiếp',
                                child: Text('Chia sẻ danh thiếp', style: TextStyle(fontSize: 13)),
                              ),
                              const PopupMenuDivider(),
                              const PopupMenuItem(
                                value: 'Chặn bạn bè',
                                child: Text('Chặn bạn bè', style: TextStyle(fontSize: 13, color: ZaloColors.badgeRed)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
