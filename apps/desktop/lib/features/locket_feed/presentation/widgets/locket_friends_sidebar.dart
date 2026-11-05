import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/zalo_theme.dart';
import '../../../../shared/mock/mock_data.dart';
import '../../../../shared/models/chat_models.dart';

class LocketFriendsSidebar extends StatelessWidget {
  final ChatUser? selectedUser; // null = Chọn "Tất cả"
  final ValueChanged<ChatUser?> onUserSelected;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final List<ChatUser> friends;

  const LocketFriendsSidebar({
    super.key,
    required this.selectedUser,
    required this.onUserSelected,
    required this.searchController,
    required this.onSearchChanged,
    required this.friends,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = MockData.currentUser;
    final isAllSelected = selectedUser == null;
    final isMeSelected = selectedUser?.id == currentUser.id;
    final allMomentsCount = MockData.allMomentsWithAuthors.length;

    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: ZaloColors.surface,
        border: Border(
          right: BorderSide(
            color: ZaloColors.border.withValues(alpha: 0.8),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header Bar
          Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: ZaloColors.border.withValues(alpha: 0.8),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ZaloColors.locketYellowLight,
                    borderRadius: BorderRadius.circular(ZaloColors.radiusSm),
                  ),
                  child: const FaIcon(
                    FontAwesomeIcons.boltLightning,
                    size: 16,
                    color: Color(0xFFD97706),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Khoảnh khắc Locket',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: ZaloColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          // 2. Search Box
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: TextField(
              controller: searchController,
              onChanged: onSearchChanged,
              style: const TextStyle(fontSize: 13.5),
              decoration: InputDecoration(
                hintText: 'Tìm kiếm bạn bè...',
                hintStyle: const TextStyle(color: ZaloColors.textMuted, fontSize: 13),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 14, right: 10),
                  child: FaIcon(FontAwesomeIcons.magnifyingGlass, size: 13, color: ZaloColors.textMuted),
                ),
                prefixIconConstraints: const BoxConstraints(minWidth: 38),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const FaIcon(FontAwesomeIcons.circleXmark, size: 14, color: ZaloColors.textMuted),
                        onPressed: () {
                          searchController.clear();
                          onSearchChanged('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFFF3F4F6),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
              ),
            ),
          ),

          // 3. Mục "Tất cả" (All Moments)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
            child: Container(
              decoration: BoxDecoration(
                color: isAllSelected
                    ? ZaloColors.locketYellowLight.withValues(alpha: 0.6)
                    : const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
                border: Border.all(
                  color: isAllSelected ? ZaloColors.locketYellow : ZaloColors.border.withValues(alpha: 0.6),
                  width: isAllSelected ? 2 : 1,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onUserSelected(null),
                  borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: isAllSelected ? ZaloColors.locketYellow : const Color(0xFF1E1E1E),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.globe,
                              size: 18,
                              color: isAllSelected ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Tất cả khoảnh khắc',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: isAllSelected ? FontWeight.bold : FontWeight.w600,
                                      color: isAllSelected ? Colors.black : ZaloColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF10B981).withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Text(
                                      'TẤT CẢ',
                                      style: TextStyle(
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF059669),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Tổng hợp từ mọi người • $allMomentsCount ảnh',
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  color: ZaloColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isAllSelected)
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD97706),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 4. Mục "Bản thân" (CurrentUser)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
            child: Container(
              decoration: BoxDecoration(
                color: isMeSelected
                    ? ZaloColors.locketYellowLight.withValues(alpha: 0.6)
                    : const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
                border: Border.all(
                  color: isMeSelected ? ZaloColors.locketYellow : ZaloColors.border.withValues(alpha: 0.6),
                  width: isMeSelected ? 2 : 1,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onUserSelected(currentUser),
                  borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
                  child: Padding(
                    padding: const EdgeInsets.all(11),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: ZaloColors.locketYellow, width: 2),
                              ),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(currentUser.avatarUrl),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF1E1E1E),
                                  shape: BoxShape.circle,
                                ),
                                child: const FaIcon(
                                  FontAwesomeIcons.plus,
                                  size: 8,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    currentUser.name,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: isMeSelected ? FontWeight.bold : FontWeight.w600,
                                      color: isMeSelected ? Colors.black : ZaloColors.textPrimary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: ZaloColors.locketYellow,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'Bạn',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              const Text(
                                'Khoảnh khắc của tôi • 5 ảnh',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: ZaloColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isMeSelected)
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD97706),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 6),

          // Label Bạn bè
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
            child: Text(
              'BẠN BÈ (${friends.length})',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: ZaloColors.textMuted,
                letterSpacing: 0.6,
              ),
            ),
          ),

          // 5. Friends List
          Expanded(
            child: friends.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FaIcon(FontAwesomeIcons.magnifyingGlass, size: 28, color: ZaloColors.textMuted),
                          SizedBox(height: 10),
                          Text(
                            'Không tìm thấy bạn bè nào',
                            style: TextStyle(color: ZaloColors.textSecondary, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    itemCount: friends.length,
                    itemBuilder: (context, index) {
                      final friend = friends[index];
                      final isSelected = selectedUser?.id == friend.id;
                      final momentsCount = MockData.getMomentsForUser(friend.id).length;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ZaloColors.locketYellowLight.withValues(alpha: 0.5)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
                          border: isSelected
                              ? Border.all(color: ZaloColors.locketYellow)
                              : null,
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => onUserSelected(friend),
                            borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
                            hoverColor: ZaloColors.locketYellowLight.withValues(alpha: 0.2),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              child: Row(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: ZaloColors.locketYellow.withValues(alpha: 0.8),
                                            width: 2,
                                          ),
                                        ),
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundImage: NetworkImage(friend.avatarUrl),
                                        ),
                                      ),
                                      if (friend.isOnline)
                                        Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF10B981),
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
                                      children: [
                                        Text(
                                          friend.name,
                                          style: TextStyle(
                                            fontSize: 13.5,
                                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                            color: isSelected ? Colors.black : ZaloColors.textPrimary,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '$momentsCount khoảnh khắc • ${friend.isOnline ? 'Online' : friend.lastActive}',
                                          style: const TextStyle(
                                            fontSize: 11.5,
                                            color: ZaloColors.textSecondary,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isSelected)
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFD97706),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
