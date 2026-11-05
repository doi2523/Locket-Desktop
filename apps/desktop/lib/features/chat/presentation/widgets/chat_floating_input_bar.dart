import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/zalo_theme.dart';

class ChatFloatingInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatFloatingInputBar({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
        border: Border.all(color: Colors.black.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(18, 6, 8, 6),
      child: Row(
        children: [
          // Clean borderless input field
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: 4,
              minLines: 1,
              onSubmitted: (_) => onSend(),
              style: const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                hintText: 'Nhập tin nhắn tới bạn bè...',
                hintStyle: TextStyle(color: ZaloColors.textMuted, fontSize: 13.5),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Circular floating send button
          InkWell(
            onTap: onSend,
            borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
            child: Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                color: Color(0xFF1E1E1E), // modern dark button
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.paperPlane,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
