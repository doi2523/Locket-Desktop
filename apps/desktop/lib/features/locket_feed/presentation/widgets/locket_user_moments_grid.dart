import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/zalo_theme.dart';
import '../../../../shared/mock/mock_data.dart';
import '../../../../shared/models/chat_models.dart';
import '../../../chat/presentation/widgets/moment_detail_viewer.dart';

class LocketUserMomentsGrid extends StatelessWidget {
  final ChatUser? user; // null = Chế độ "Tất cả"
  final VoidCallback? onPostMoment;

  const LocketUserMomentsGrid({
    super.key,
    required this.user,
    this.onPostMoment,
  });

  @override
  Widget build(BuildContext context) {
    final isAll = user == null;
    final isMe = user?.id == MockData.currentUser.id;
    final List<Map<String, String>> moments = isAll
        ? MockData.allMomentsWithAuthors
        : MockData.getMomentsForUser(user!.id);

    return Scaffold(
      backgroundColor: ZaloColors.background,
      body: Column(
        children: [
          // 1. User / All Header Banner
          Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: ZaloColors.surface,
              border: Border(
                bottom: BorderSide(
                  color: ZaloColors.border.withValues(alpha: 0.8),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                if (isAll)
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: ZaloColors.locketYellow,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: ZaloColors.locketYellow.withValues(alpha: 0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: FaIcon(FontAwesomeIcons.globe, size: 18, color: Colors.black),
                    ),
                  )
                else
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(user!.avatarUrl),
                      ),
                      if (user!.isOnline)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 9,
                            height: 9,
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 1.5),
                            ),
                          ),
                        ),
                    ],
                  ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              isAll ? 'Tất cả khoảnh khắc' : user!.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ZaloColors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isAll) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFF10B981).withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'TẤT CẢ',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF059669),
                                ),
                              ),
                            ),
                          ] else if (isMe) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: ZaloColors.locketYellow,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'Bạn',
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isAll
                            ? 'Tổng hợp từ bạn và tất cả bạn bè • ${moments.length} ảnh'
                            : '${moments.length} khoảnh khắc được lưu trữ • Lưới ảnh 1:1',
                        style: const TextStyle(
                          fontSize: 12,
                          color: ZaloColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Action Buttons
                FilledButton.icon(
                  onPressed: onPostMoment ?? () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: (isMe || isAll) ? ZaloColors.locketYellow : const Color(0xFF1E1E1E),
                    foregroundColor: (isMe || isAll) ? Colors.black : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                  ),
                  icon: FaIcon((isMe || isAll) ? FontAwesomeIcons.camera : FontAwesomeIcons.solidHeart, size: 13),
                  label: Text(
                    (isMe || isAll) ? 'Chụp Moment' : 'Thả Tim',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          // 2. Moments Grid View (Grid 1:1 như bên Chat)
          Expanded(
            child: moments.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            color: ZaloColors.locketYellowLight,
                            shape: BoxShape.circle,
                          ),
                          child: const FaIcon(
                            FontAwesomeIcons.camera,
                            size: 36,
                            color: Color(0xFFD97706),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          isAll
                              ? 'Chưa có khoảnh khắc nào trong feed'
                              : (isMe
                                  ? 'Bạn chưa đăng khoảnh khắc nào hôm nay'
                                  : '${user?.name} chưa chia sẻ khoảnh khắc nào gần đây'),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: ZaloColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Hãy chụp ảnh và gửi qua Widget để kết nối cùng bạn bè!',
                          style: TextStyle(fontSize: 13, color: ZaloColors.textSecondary),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 260, // Kích thước ô lưới lý tưởng
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1.0, // Chuẩn vuông 1:1 Locket signature
                    ),
                    itemCount: moments.length,
                    itemBuilder: (context, index) {
                      final moment = moments[index];
                      final heroTag = 'locket_feed_${user?.id ?? 'all'}_$index';

                      return _buildMomentGridItem(
                        context: context,
                        moment: moment,
                        index: index,
                        moments: moments,
                        heroTag: heroTag,
                        showAuthorBadge: isAll,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildMomentGridItem({
    required BuildContext context,
    required Map<String, String> moment,
    required int index,
    required List<Map<String, String>> moments,
    required String heroTag,
    required bool showAuthorBadge,
  }) {
    final caption = moment['caption'] ?? '';
    final time = moment['time'] ?? '';
    final music = moment['music'];
    final authorName = moment['authorName'] ?? (user?.name ?? 'Bạn bè');
    final authorAvatarUrl = moment['authorAvatarUrl'] ?? (user?.avatarUrl ?? MockData.currentUser.avatarUrl);

    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: ZaloColors.border.withValues(alpha: 0.6),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              MomentDetailViewer.show(
                context,
                moments: moments,
                initialIndex: index,
                friendName: authorName,
                friendAvatarUrl: authorAvatarUrl,
                customHeroTag: heroTag,
              );
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Image with Hero
                Hero(
                  tag: heroTag,
                  child: Image.network(
                    moment['url']!,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: const Color(0xFF1E1E1E),
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2, color: ZaloColors.locketYellow),
                        ),
                      );
                    },
                  ),
                ),

                // Subtle Top & Bottom Gradients for readable text
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.38),
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.65),
                        ],
                      ),
                    ),
                  ),
                ),

                // Top: Author (if All mode) or Timestamp & Music
                Positioned(
                  top: 10,
                  left: 10,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (showAuthorBadge)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3.5),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.55),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 8,
                                backgroundImage: NetworkImage(authorAvatarUrl),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                authorName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            time,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      Row(
                        children: [
                          if (showAuthorBadge) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.45),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                time.split('-').first.trim(),
                                style: const TextStyle(color: Colors.white70, fontSize: 9.5),
                              ),
                            ),
                            const SizedBox(width: 5),
                          ],
                          if (music != null)
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.5),
                                shape: BoxShape.circle,
                              ),
                              child: const FaIcon(
                                FontAwesomeIcons.music,
                                size: 9,
                                color: ZaloColors.locketYellow,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Bottom: Caption Bubble
                if (caption.isNotEmpty)
                  Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          caption,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
