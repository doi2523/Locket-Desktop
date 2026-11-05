import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/zalo_theme.dart';

class PrivacySecurityView extends StatefulWidget {
  const PrivacySecurityView({super.key});

  @override
  State<PrivacySecurityView> createState() => _PrivacySecurityViewState();
}

class _PrivacySecurityViewState extends State<PrivacySecurityView> {
  int _visibilityOption = 0; // 0: Tất cả bạn bè, 1: Bạn thân (Close Friends), 2: Tùy chỉnh
  bool _showOnlineStatus = true;
  bool _allowFriendRequests = true;
  bool _enablePinLock = false;
  bool _biometricUnlock = true;

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
              'Quyền riêng tư & Bảo mật',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ZaloColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Kiểm soát ai có thể nhìn thấy khoảnh khắc của bạn và thiết lập bảo vệ ứng dụng',
              style: TextStyle(fontSize: 13.5, color: ZaloColors.textSecondary),
            ),
            const SizedBox(height: 24),

            // 1. Moment Privacy
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
                    'Ai có thể nhận khoảnh khắc của bạn?',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 14),
                  _buildRadioOption(
                    title: 'Tất cả bạn bè trên Locket',
                    subtitle: 'Mọi người trong danh sách Bạn bè đều nhận được qua widget',
                    value: 0,
                  ),
                  const SizedBox(height: 8),
                  _buildRadioOption(
                    title: 'Chỉ danh sách Bạn Thân (Close Friends ⭐)',
                    subtitle: 'Chỉ gửi tới những người bạn đặc biệt được bạn gắn sao',
                    value: 1,
                  ),
                  const SizedBox(height: 8),
                  _buildRadioOption(
                    title: 'Tùy chọn từng người trước khi gửi',
                    subtitle: 'Hiện hộp chọn người nhận mỗi khi chụp xong ảnh',
                    value: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 2. Activity & Presence
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
                    'Trạng thái hoạt động & Kết nối',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    value: _showOnlineStatus,
                    contentPadding: EdgeInsets.zero,
                    activeThumbColor: const Color(0xFFD97706),
                    onChanged: (val) => setState(() => _showOnlineStatus = val),
                    title: const Text('Hiển thị trạng thái Online', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    subtitle: const Text('Cho phép bạn bè biết khi bạn đang trực tuyến trên Locket', style: TextStyle(fontSize: 12.5)),
                  ),
                  const Divider(height: 24),
                  SwitchListTile(
                    value: _allowFriendRequests,
                    contentPadding: EdgeInsets.zero,
                    activeThumbColor: const Color(0xFFD97706),
                    onChanged: (val) => setState(() => _allowFriendRequests = val),
                    title: const Text('Cho phép nhận lời mời kết bạn từ người lạ', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    subtitle: const Text('Người khác có thể tìm thấy bạn qua Locket ID hoặc số điện thoại', style: TextStyle(fontSize: 12.5)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 3. App Lock & Security
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
                    'Bảo mật ứng dụng',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    value: _enablePinLock,
                    contentPadding: EdgeInsets.zero,
                    activeThumbColor: const Color(0xFFD97706),
                    onChanged: (val) => setState(() => _enablePinLock = val),
                    title: const Text('Khóa ứng dụng bằng mã PIN', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    subtitle: const Text('Yêu cầu nhập mã 4 số khi mở ứng dụng Locket', style: TextStyle(fontSize: 12.5)),
                  ),
                  if (_enablePinLock) ...[
                    const Divider(height: 24),
                    SwitchListTile(
                      value: _biometricUnlock,
                      contentPadding: EdgeInsets.zero,
                      activeThumbColor: const Color(0xFFD97706),
                      onChanged: (val) => setState(() => _biometricUnlock = val),
                      title: const Text('Mở khóa bằng sinh trắc học (FaceID / TouchID / Windows Hello)', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                      subtitle: const Text('Mở khóa nhanh chóng không cần gõ mã PIN', style: TextStyle(fontSize: 12.5)),
                    ),
                  ],
                  const Divider(height: 24),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const FaIcon(FontAwesomeIcons.userSlash, size: 16, color: Color(0xFFEF4444)),
                    title: const Text('Danh sách người dùng đã chặn (0)', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    trailing: const FaIcon(FontAwesomeIcons.chevronRight, size: 12, color: ZaloColors.textMuted),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption({
    required String title,
    required String subtitle,
    required int value,
  }) {
    final isSelected = _visibilityOption == value;

    return Container(
      decoration: BoxDecoration(
        color: isSelected ? ZaloColors.locketYellowLight.withValues(alpha: 0.4) : const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
        border: Border.all(
          color: isSelected ? ZaloColors.locketYellow : ZaloColors.border.withValues(alpha: 0.7),
        ),
      ),
      child: InkWell(
        onTap: () => setState(() => _visibilityOption = value),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 12, color: ZaloColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
