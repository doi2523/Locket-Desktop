import 'package:flutter/material.dart';
import '../../../../core/theme/zalo_theme.dart';

class NotificationSettingsView extends StatefulWidget {
  const NotificationSettingsView({super.key});

  @override
  State<NotificationSettingsView> createState() => _NotificationSettingsViewState();
}

class _NotificationSettingsViewState extends State<NotificationSettingsView> {
  bool _enableAllNotifications = true;
  bool _newMomentNotification = true;
  bool _newReactionNotification = true;
  bool _chatNotification = true;
  bool _playSound = true;
  int _soundThemeIndex = 0; // 0: Locket Pop, 1: Zalo Classic, 2: Ting Ting

  final List<String> _soundThemes = [
    'Locket Pop 🫧 (Tươi vui, ngắn gọn)',
    'Zalo Classic 🔔 (Tiếng chuông quen thuộc)',
    'Ting Ting ✨ (Dịu nhẹ, tinh tế)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZaloColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Thông báo & Âm thanh',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ZaloColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Tùy chỉnh thông báo đẩy khi bạn bè gửi ảnh mới hoặc phản hồi reaction khoảnh khắc của bạn',
              style: TextStyle(fontSize: 13.5, color: ZaloColors.textSecondary),
            ),
            const SizedBox(height: 24),

            // Master Switch
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ZaloColors.radiusLg),
                border: Border.all(color: ZaloColors.border.withValues(alpha: 0.8)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: SwitchListTile(
                value: _enableAllNotifications,
                contentPadding: EdgeInsets.zero,
                activeThumbColor: const Color(0xFFD97706),
                onChanged: (val) => setState(() => _enableAllNotifications = val),
                title: const Text(
                  'Cho phép nhận thông báo từ Locket Dio',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                subtitle: const Text(
                  'Bật để không bao giờ bỏ lỡ khoảnh khắc từ những người bạn thân',
                  style: TextStyle(fontSize: 12.5),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Detailed notification channels
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ZaloColors.radiusLg),
                border: Border.all(color: ZaloColors.border.withValues(alpha: 0.8)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Các loại thông báo',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    value: _enableAllNotifications && _newMomentNotification,
                    contentPadding: EdgeInsets.zero,
                    activeThumbColor: const Color(0xFFD97706),
                    onChanged: _enableAllNotifications ? (val) => setState(() => _newMomentNotification = val) : null,
                    title: const Text('Khoảnh khắc mới từ bạn bè', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    subtitle: const Text('Nhận thông báo ngay khi có người gửi ảnh lên widget', style: TextStyle(fontSize: 12.5)),
                  ),
                  const Divider(height: 24),
                  SwitchListTile(
                    value: _enableAllNotifications && _newReactionNotification,
                    contentPadding: EdgeInsets.zero,
                    activeThumbColor: const Color(0xFFD97706),
                    onChanged: _enableAllNotifications ? (val) => setState(() => _newReactionNotification = val) : null,
                    title: const Text('Biểu cảm & Reaction (❤️, 🔥, 🥺)', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    subtitle: const Text('Thông báo khi ai đó thả tim vào ảnh của bạn', style: TextStyle(fontSize: 12.5)),
                  ),
                  const Divider(height: 24),
                  SwitchListTile(
                    value: _enableAllNotifications && _chatNotification,
                    contentPadding: EdgeInsets.zero,
                    activeThumbColor: const Color(0xFFD97706),
                    onChanged: _enableAllNotifications ? (val) => setState(() => _chatNotification = val) : null,
                    title: const Text('Tin nhắn trò chuyện', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    subtitle: const Text('Tin nhắn riêng tư trong hộp thoại chat', style: TextStyle(fontSize: 12.5)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Sound Themes
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ZaloColors.radiusLg),
                border: Border.all(color: ZaloColors.border.withValues(alpha: 0.8)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SwitchListTile(
                    value: _playSound,
                    contentPadding: EdgeInsets.zero,
                    activeThumbColor: const Color(0xFFD97706),
                    onChanged: (val) => setState(() => _playSound = val),
                    title: const Text('Âm thanh thông báo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    subtitle: const Text('Phát âm thanh khi có tin nhắn hoặc moment mới', style: TextStyle(fontSize: 12.5)),
                  ),
                  if (_playSound) ...[
                    const Divider(height: 24),
                    const Text('Kiểu chuông âm thanh', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5)),
                    const SizedBox(height: 12),
                    ...List.generate(_soundThemes.length, (idx) {
                      final isSelected = _soundThemeIndex == idx;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? ZaloColors.locketYellowLight.withValues(alpha: 0.4) : const Color(0xFFF9FAFB),
                          borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
                          border: Border.all(
                            color: isSelected ? ZaloColors.locketYellow : ZaloColors.border.withValues(alpha: 0.7),
                          ),
                        ),
                        child: InkWell(
                          onTap: () => setState(() => _soundThemeIndex = idx),
                          borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            child: Row(
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected ? const Color(0xFFD97706) : ZaloColors.textMuted,
                                      width: 2,
                                    ),
                                  ),
                                  child: isSelected
                                      ? Center(
                                          child: Container(
                                            width: 10,
                                            height: 10,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFFD97706),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  _soundThemes[idx],
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
