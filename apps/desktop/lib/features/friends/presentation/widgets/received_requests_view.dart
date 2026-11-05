import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/zalo_theme.dart';
import '../../../../shared/models/chat_models.dart';

class ReceivedRequestsView extends StatefulWidget {
  final List<FriendRequest> requests;
  final ValueChanged<FriendRequest>? onAccept;
  final ValueChanged<FriendRequest>? onDecline;

  const ReceivedRequestsView({
    super.key,
    required this.requests,
    this.onAccept,
    this.onDecline,
  });

  @override
  State<ReceivedRequestsView> createState() => _ReceivedRequestsViewState();
}

class _ReceivedRequestsViewState extends State<ReceivedRequestsView> {
  late List<FriendRequest> _currentRequests;

  @override
  void initState() {
    super.initState();
    _currentRequests = List.from(widget.requests);
  }

  @override
  void didUpdateWidget(covariant ReceivedRequestsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.requests != widget.requests) {
      _currentRequests = List.from(widget.requests);
    }
  }

  void _accept(FriendRequest req) {
    setState(() {
      _currentRequests.removeWhere((r) => r.id == req.id);
    });
    widget.onAccept?.call(req);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã chấp nhận lời mời từ ${req.user.name} 🎉'),
        backgroundColor: const Color(0xFF10B981),
      ),
    );
  }

  void _decline(FriendRequest req) {
    setState(() {
      _currentRequests.removeWhere((r) => r.id == req.id);
    });
    widget.onDecline?.call(req);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã từ chối lời mời từ ${req.user.name}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                FontAwesomeIcons.envelopeOpenText,
                size: 16,
                color: Color(0xFFD97706),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Lời mời kết bạn đã nhận',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ZaloColors.textPrimary,
                    ),
                  ),
                  Text(
                    '${_currentRequests.length} lời mời đang chờ bạn phản hồi',
                    style: const TextStyle(
                      fontSize: 12,
                      color: ZaloColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // 2. Requests List
        Expanded(
          child: _currentRequests.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(FontAwesomeIcons.circleCheck, size: 36, color: Color(0xFF10B981)),
                      SizedBox(height: 12),
                      Text(
                        'Bạn không có lời mời kết bạn nào chưa xử lý',
                        style: TextStyle(color: ZaloColors.textSecondary, fontSize: 14),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: _currentRequests.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final req = _currentRequests[index];
                    return Container(
                      padding: const EdgeInsets.all(18),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundImage: NetworkImage(req.user.avatarUrl),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      req.user.name,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: ZaloColors.textPrimary,
                                      ),
                                    ),
                                    if (req.mutualFriends != null) ...[
                                      const SizedBox(height: 2),
                                      Text(
                                        req.mutualFriends!,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: ZaloColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              // Action Buttons
                              Row(
                                children: [
                                  FilledButton(
                                    onPressed: () => _accept(req),
                                    style: FilledButton.styleFrom(
                                      backgroundColor: ZaloColors.locketYellow,
                                      foregroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                                    ),
                                    child: const Text(
                                      'Đồng ý',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  OutlinedButton(
                                    onPressed: () => _decline(req),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: ZaloColors.textSecondary,
                                      side: BorderSide(color: Colors.black.withValues(alpha: 0.16)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                                    ),
                                    child: const Text('Từ chối', style: TextStyle(fontSize: 13)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Greeting message if present
                          if (req.message != null) ...[
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF9FAFB),
                                borderRadius: BorderRadius.circular(ZaloColors.radiusSm),
                                border: Border.all(color: ZaloColors.border.withValues(alpha: 0.5)),
                              ),
                              child: Row(
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.quoteLeft,
                                    size: 11,
                                    color: ZaloColors.textMuted,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      req.message!,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: ZaloColors.textPrimary,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
