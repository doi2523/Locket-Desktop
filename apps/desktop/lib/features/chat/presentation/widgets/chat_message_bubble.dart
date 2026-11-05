import 'package:flutter/material.dart';
import '../../../../core/theme/zalo_theme.dart';
import '../../../../shared/models/chat_models.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
      decoration: BoxDecoration(
        color: message.isMe ? ZaloColors.bubbleOutgoing : ZaloColors.bubbleIncoming,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(18),
          topRight: const Radius.circular(18),
          bottomLeft: Radius.circular(message.isMe ? 18 : 4),
          bottomRight: Radius.circular(message.isMe ? 4 : 18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        message.text,
        style: TextStyle(
          fontSize: 14,
          height: 1.35,
          color: message.isMe ? ZaloColors.bubbleOutgoingText : ZaloColors.textPrimary,
        ),
      ),
    );
  }
}
