import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/zalo_theme.dart';
import '../../../../shared/models/chat_models.dart';
import 'chat_message_bubble.dart';
import 'locket_moment_bubble.dart';

class ChatMessageTimeline extends StatelessWidget {
  final List<ChatMessage> messages;
  final ScrollController scrollController;
  final Function(ChatMessage) onMomentTap;

  const ChatMessageTimeline({
    super.key,
    required this.messages,
    required this.scrollController,
    required this.onMomentTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];
        final timeStr = DateFormat('HH:mm').format(msg.timestamp);

        return Align(
          alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              crossAxisAlignment:
                  msg.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (msg.isLocketMoment)
                  LocketMomentBubble(
                    message: msg,
                    onTap: () => onMomentTap(msg),
                  )
                else
                  ChatMessageBubble(message: msg),
                const SizedBox(height: 4),
                Text(
                  timeStr,
                  style: const TextStyle(fontSize: 10.5, color: ZaloColors.textMuted),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
