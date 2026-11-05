import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/zalo_theme.dart';
import '../../../shared/mock/mock_data.dart';
import '../../../shared/models/chat_models.dart';

class ChatListPanel extends StatefulWidget {
  final Conversation? selectedConversation;
  final ValueChanged<Conversation> onSelectConversation;

  const ChatListPanel({
    super.key,
    required this.selectedConversation,
    required this.onSelectConversation,
  });

  @override
  State<ChatListPanel> createState() => _ChatListPanelState();
}

class _ChatListPanelState extends State<ChatListPanel> {
  int _selectedFilterTab = 0; // 0: Tất cả, 1: Chưa đọc
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final filteredConversations = MockData.conversations.where((conv) {
      if (_selectedFilterTab == 1 && conv.unreadCount == 0) {
        return false;
      }
      if (_searchController.text.isNotEmpty) {
        return conv.user.name
            .toLowerCase()
            .contains(_searchController.text.toLowerCase());
      }
      return true;
    }).toList();

    return Container(
      width: 330,
      decoration: const BoxDecoration(
        color: ZaloColors.surface,
        border: Border(right: BorderSide(color: ZaloColors.border, width: 1)),
      ),
      child: Column(
        children: [
          // Header Search & Actions
          _buildSearchHeader(),
          // Filter Tabs (Pill style)
          _buildFilterTabs(),
          const SizedBox(height: 4),
          const Divider(height: 1),
          // Conversation List (Rounded tiles)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 6),
              itemCount: filteredConversations.length,
              itemBuilder: (context, index) {
                final item = filteredConversations[index];
                final isSelected = widget.selectedConversation?.id == item.id;
                return _buildConversationTile(item, isSelected);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                color: ZaloColors.background,
                borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                border: Border.all(color: ZaloColors.border.withValues(alpha: 0.6)),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(fontSize: 13),
                decoration: const InputDecoration(
                  hintText: 'Tìm kiếm',
                  hintStyle: TextStyle(color: ZaloColors.textMuted, fontSize: 13),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 12, right: 8),
                    child: FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 13,
                      color: ZaloColors.textSecondary,
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 32,
                    minHeight: 36,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.only(right: 12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          _buildCircleActionButton(
            icon: FontAwesomeIcons.userPlus,
            tooltip: 'Thêm bạn bè',
            onTap: () {},
          ),
          const SizedBox(width: 4),
          _buildCircleActionButton(
            icon: FontAwesomeIcons.users,
            tooltip: 'Tạo nhóm chat',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildCircleActionButton({
    required FaIconData icon,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: ZaloColors.background,
            shape: BoxShape.circle,
            border: Border.all(color: ZaloColors.border.withValues(alpha: 0.6)),
          ),
          child: Center(
            child: FaIcon(icon, size: 14, color: ZaloColors.textSecondary),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Row(
        children: [
          _buildPillTab('Tất cả', 0),
          const SizedBox(width: 8),
          _buildPillTab('Chưa đọc', 1),
          const Spacer(),
          IconButton(
            onPressed: () {},
            tooltip: 'Bộ lọc',
            icon: const FaIcon(FontAwesomeIcons.sliders, size: 13, color: ZaloColors.textSecondary),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
          ),
        ],
      ),
    );
  }

  Widget _buildPillTab(String label, int index) {
    final isSelected = _selectedFilterTab == index;
    return InkWell(
      onTap: () => setState(() => _selectedFilterTab = index),
      borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E1E1E) : ZaloColors.background,
          borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? Colors.white : ZaloColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildConversationTile(Conversation conv, bool isSelected) {
    final timeStr = DateFormat('HH:mm').format(conv.lastMessageTime);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: InkWell(
        onTap: () => widget.onSelectConversation(conv),
        borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFEBF3FF) : Colors.transparent,
            borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              // Avatar with Online dot or Locket Yellow
              Stack(
                children: [
                  CircleAvatar(
                    radius: 23,
                    backgroundColor: ZaloColors.primaryLight,
                    backgroundImage: NetworkImage(conv.user.avatarUrl),
                  ),
                  if (conv.user.isOnline)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 12,
                        height: 12,
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
              // Name & Last message
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            conv.user.name,
                            style: TextStyle(
                              fontSize: 13.8,
                              fontWeight: conv.unreadCount > 0 ? FontWeight.bold : FontWeight.w500,
                              color: ZaloColors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          timeStr,
                          style: TextStyle(
                            fontSize: 11,
                            color: conv.unreadCount > 0 ? ZaloColors.primary : ZaloColors.textMuted,
                            fontWeight: conv.unreadCount > 0 ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            conv.lastMessage,
                            style: TextStyle(
                              fontSize: 12.3,
                              color: conv.unreadCount > 0 ? ZaloColors.textPrimary : ZaloColors.textSecondary,
                              fontWeight: conv.unreadCount > 0 ? FontWeight.w600 : FontWeight.normal,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (conv.unreadCount > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: ZaloColors.badgeRed,
                              borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                            ),
                            child: Text(
                              '${conv.unreadCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        if (conv.isPinned && conv.unreadCount == 0)
                          const Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: FaIcon(
                              FontAwesomeIcons.thumbtack,
                              size: 11,
                              color: ZaloColors.textMuted,
                            ),
                          ),
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
