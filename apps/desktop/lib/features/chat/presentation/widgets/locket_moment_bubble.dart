import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/zalo_theme.dart';
import '../../../../shared/models/chat_models.dart';

class LocketMomentBubble extends StatelessWidget {
  final ChatMessage message;
  final VoidCallback? onTap;

  const LocketMomentBubble({
    super.key,
    required this.message,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ZaloColors.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header badge
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: ZaloColors.locketYellow,
                    borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(FontAwesomeIcons.boltLightning, size: 11, color: Colors.black),
                      SizedBox(width: 4),
                      Text(
                        'Locket Moment',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                const Text('💛', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          // Moment Image with Hero
          if (message.mediaUrl != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(16),
                child: Hero(
                  tag: 'moment_bubble_${message.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            message.mediaUrl!,
                            fit: BoxFit.cover,
                          ),
                          if (message.caption != null)
                            Positioned(
                              bottom: 12,
                              left: 12,
                              right: 12,
                              child: Center(
                                child: Container(
                                  constraints: const BoxConstraints(maxWidth: 240),
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.72),
                                    borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                                  ),
                                  child: Text(
                                    message.caption!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 10),
          // Reactions Row
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['❤️', '🔥', '😂', '😮', '⚡'].map((emoji) {
                return InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(emoji, style: const TextStyle(fontSize: 18)),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
