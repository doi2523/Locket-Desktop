import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/zalo_theme.dart';
import '../../../../shared/models/chat_models.dart';

class ChatDetailHeader extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback? onBackMobile;
  final int selectedTab;
  final ValueChanged<int> onTabChanged;

  const ChatDetailHeader({
    super.key,
    required this.conversation,
    this.onBackMobile,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: ZaloColors.border, width: 0.5),
        ),
      ),
      child: Row(
        children: [
          if (onBackMobile != null)
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.chevronLeft, size: 16),
              onPressed: onBackMobile,
            ),
          Stack(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(conversation.user.avatarUrl),
              ),
              if (conversation.user.isOnline)
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
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  conversation.user.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: ZaloColors.textPrimary,
                  ),
                ),
                Text(
                  conversation.user.isOnline
                      ? 'Đang hoạt động'
                      : 'Hoạt động ${conversation.user.lastActive}',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: conversation.user.isOnline
                        ? ZaloColors.online
                        : ZaloColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Sliding Segmented Control (Hiệu ứng trượt vùng chọn mượt mà)
          _buildSlidingSegmentedControl(),
          const SizedBox(width: 8),
          // 3-dots Menu Button (Compact & Transparent)
          PopupMenuButton<String>(
            tooltip: 'Tùy chọn',
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
            ),
            elevation: 8,
            borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
            onSelected: (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đã chọn: $value')),
              );
            },
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.ellipsisVertical,
                  size: 14,
                  color: ZaloColors.textSecondary,
                ),
              ),
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'Xem thông tin trang cá nhân',
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.solidUser, size: 13, color: ZaloColors.textSecondary),
                    SizedBox(width: 12),
                    Text('Trang cá nhân', style: TextStyle(fontSize: 13)),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'Tìm kiếm tin nhắn',
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.magnifyingGlass, size: 13, color: ZaloColors.textSecondary),
                    SizedBox(width: 12),
                    Text('Tìm kiếm tin nhắn', style: TextStyle(fontSize: 13)),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'Tắt thông báo hội thoại',
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.solidBellSlash, size: 13, color: ZaloColors.textSecondary),
                    SizedBox(width: 12),
                    Text('Tắt thông báo', style: TextStyle(fontSize: 13)),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: 'Xóa lịch sử chat',
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.trashCan, size: 13, color: ZaloColors.badgeRed),
                    SizedBox(width: 12),
                    Text('Xóa lịch sử chat', style: TextStyle(fontSize: 13, color: ZaloColors.badgeRed)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSlidingSegmentedControl() {
    const double width = 196.0;
    const double height = 34.0;
    const double pillWidth = (width - 6) / 2; // ~95px

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: ZaloColors.background,
        borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
        border: Border.all(color: ZaloColors.border.withValues(alpha: 0.6)),
      ),
      padding: const EdgeInsets.all(3),
      child: Stack(
        children: [
          // 1. Sliding Background Capsule (Vùng chọn trượt)
          AnimatedAlign(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            alignment: selectedTab == 0
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Container(
              width: pillWidth,
              height: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E), // sleek dark indicator
                borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.14),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          // 2. Interactive Text Labels on top
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => onTabChanged(0),
                  borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        fontSize: 12.2,
                        fontWeight: selectedTab == 0
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: selectedTab == 0
                            ? Colors.white
                            : ZaloColors.textSecondary,
                      ),
                      child: const Text('Tin nhắn'),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => onTabChanged(1),
                  borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        fontSize: 12.2,
                        fontWeight: selectedTab == 1
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: selectedTab == 1
                            ? Colors.white
                            : ZaloColors.textSecondary,
                      ),
                      child: const Text('Khoảnh khắc'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
