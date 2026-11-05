import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/zalo_theme.dart';

class FriendsSidebar extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onTabSelected;
  final int friendsCount;
  final int receivedCount;
  final int sentCount;
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;

  const FriendsSidebar({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
    required this.friendsCount,
    required this.receivedCount,
    required this.sentCount,
    this.searchController,
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: ZaloColors.border, width: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Search Bar Header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: ZaloColors.border, width: 0.5),
              ),
            ),
            child: Container(
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 13,
                    color: ZaloColors.textSecondary,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: onSearchChanged,
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(fontSize: 13.5),
                      decoration: const InputDecoration(
                        hintText: 'Tìm kiếm bạn bè...',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: ZaloColors.textMuted,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. Navigation items
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              children: [
                _buildNavItem(
                  index: 0,
                  title: 'Danh sách bạn bè',
                  icon: FontAwesomeIcons.userGroup,
                  iconColor: const Color(0xFF2563EB),
                  iconBg: const Color(0xFFEFF6FF),
                  count: friendsCount,
                  countBadgeColor: const Color(0xFFE5E7EB),
                  countTextColor: ZaloColors.textSecondary,
                ),
                const SizedBox(height: 6),
                _buildNavItem(
                  index: 1,
                  title: 'Lời mời đã nhận',
                  icon: FontAwesomeIcons.envelopeOpenText,
                  iconColor: const Color(0xFFD97706),
                  iconBg: const Color(0xFFFEF3C7),
                  count: receivedCount,
                  countBadgeColor: ZaloColors.badgeRed,
                  countTextColor: Colors.white,
                  isHighlightCount: receivedCount > 0,
                ),
                const SizedBox(height: 6),
                _buildNavItem(
                  index: 2,
                  title: 'Lời mời đã gửi',
                  icon: FontAwesomeIcons.paperPlane,
                  iconColor: const Color(0xFF10B981),
                  iconBg: const Color(0xFFD1FAE5),
                  count: sentCount,
                  countBadgeColor: const Color(0xFFE5E7EB),
                  countTextColor: ZaloColors.textSecondary,
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: ZaloColors.border),

          // 3. Quick Tip Footer
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: ZaloColors.locketYellowLight.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
                border: Border.all(color: ZaloColors.locketYellow.withValues(alpha: 0.3)),
              ),
              child: const Row(
                children: [
                  FaIcon(FontAwesomeIcons.boltLightning, size: 14, color: Color(0xFFD97706)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Kết bạn trên Locket để cùng chia sẻ khoảnh khắc mỗi ngày!',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF92400E),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String title,
    required FaIconData icon,
    required Color iconColor,
    required Color iconBg,
    required int count,
    required Color countBadgeColor,
    required Color countTextColor,
    bool isHighlightCount = false,
  }) {
    final isSelected = selectedTab == index;

    return InkWell(
      onTap: () => onTabSelected(index),
      borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? ZaloColors.locketYellow.withValues(alpha: 0.16)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
          border: Border.all(
            color: isSelected
                ? ZaloColors.locketYellow.withValues(alpha: 0.6)
                : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: FaIcon(icon, size: 14, color: iconColor),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? const Color(0xFF1E1E1E) : ZaloColors.textPrimary,
                ),
              ),
            ),
            if (count > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isHighlightCount ? ZaloColors.badgeRed : countBadgeColor,
                  borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                    color: isHighlightCount ? Colors.white : countTextColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
