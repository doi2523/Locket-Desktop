import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/zalo_theme.dart';
import '../../../../shared/models/chat_models.dart';

class SentRequestsView extends StatefulWidget {
  final List<FriendRequest> requests;
  final ValueChanged<FriendRequest>? onCancel;

  const SentRequestsView({
    super.key,
    required this.requests,
    this.onCancel,
  });

  @override
  State<SentRequestsView> createState() => _SentRequestsViewState();
}

class _SentRequestsViewState extends State<SentRequestsView> {
  late List<FriendRequest> _currentRequests;

  @override
  void initState() {
    super.initState();
    _currentRequests = List.from(widget.requests);
  }

  @override
  void didUpdateWidget(covariant SentRequestsView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.requests != widget.requests) {
      _currentRequests = List.from(widget.requests);
    }
  }

  void _cancel(FriendRequest req) {
    setState(() {
      _currentRequests.removeWhere((r) => r.id == req.id);
    });
    widget.onCancel?.call(req);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã thu hồi lời mời kết bạn gửi tới ${req.user.name}'),
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
                FontAwesomeIcons.paperPlane,
                size: 15,
                color: Color(0xFF10B981),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Lời mời kết bạn đã gửi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ZaloColors.textPrimary,
                    ),
                  ),
                  Text(
                    '${_currentRequests.length} lời mời đang chờ đối phương chấp nhận',
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

        // 2. Sent Requests List
        Expanded(
          child: _currentRequests.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(FontAwesomeIcons.inbox, size: 36, color: ZaloColors.textMuted),
                      SizedBox(height: 12),
                      Text(
                        'Bạn chưa gửi lời mời kết bạn nào',
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
                      child: Row(
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
                                const SizedBox(height: 2),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF3F4F6),
                                    borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                                  ),
                                  child: const Text(
                                    'Đang chờ xác nhận',
                                    style: TextStyle(fontSize: 11, color: ZaloColors.textSecondary),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Cancel Request Button
                          OutlinedButton(
                            onPressed: () => _cancel(req),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: ZaloColors.textSecondary,
                              side: BorderSide(color: Colors.black.withValues(alpha: 0.16)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            ),
                            child: const Text('Thu hồi lời mời', style: TextStyle(fontSize: 12.5)),
                          ),
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
