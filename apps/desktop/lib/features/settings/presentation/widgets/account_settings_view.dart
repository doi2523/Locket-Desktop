import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/zalo_theme.dart';
import '../../../../shared/mock/mock_data.dart';

class AccountSettingsView extends StatefulWidget {
  const AccountSettingsView({super.key});

  @override
  State<AccountSettingsView> createState() => _AccountSettingsViewState();
}

class _AccountSettingsViewState extends State<AccountSettingsView> {
  late final TextEditingController _nameController;
  late final TextEditingController _idController;
  late final TextEditingController _bioController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: MockData.currentUser.name);
    _idController = TextEditingController(text: 'dio.developer.2026');
    _bioController = TextEditingController(text: 'Locket Dio creator • Chia sẻ khoảnh khắc realtime 💛✨');
    _phoneController = TextEditingController(text: '+84 987 654 321');
    _emailController = TextEditingController(text: 'dio.developer@locketdio.com');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _bioController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            FaIcon(FontAwesomeIcons.circleCheck, color: Colors.white, size: 16),
            SizedBox(width: 10),
            Text('Đã cập nhật thông tin hồ sơ thành công!'),
          ],
        ),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ZaloColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title
            const Text(
              'Tài khoản & Hồ sơ cá nhân',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ZaloColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Quản lý thông tin công khai hiển thị trên trang cá nhân và widget bạn bè',
              style: TextStyle(fontSize: 13.5, color: ZaloColors.textSecondary),
            ),
            const SizedBox(height: 24),

            // Avatar Upload Card
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
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 42,
                        backgroundImage: NetworkImage(MockData.currentUser.avatarUrl),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: ZaloColors.locketYellow,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const FaIcon(
                            FontAwesomeIcons.camera,
                            size: 13,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Ảnh đại diện Locket',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Khuyên dùng ảnh chân dung vuông, tỉ lệ 1:1, dung lượng dưới 5MB.',
                          style: TextStyle(fontSize: 12.5, color: ZaloColors.textSecondary),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            FilledButton(
                              onPressed: () {},
                              style: FilledButton.styleFrom(
                                backgroundColor: ZaloColors.locketYellow,
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              ),
                              child: const Text('Đổi ảnh', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                            ),
                            const SizedBox(width: 10),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                foregroundColor: ZaloColors.textSecondary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                                ),
                                side: BorderSide(color: Colors.black.withValues(alpha: 0.16)),
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              ),
                              child: const Text('Xóa ảnh', style: TextStyle(fontSize: 13)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Profile Fields Container
            Container(
              padding: const EdgeInsets.all(22),
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
                  _buildTextField(
                    label: 'Tên hiển thị',
                    controller: _nameController,
                    hint: 'Nhập tên hiển thị của bạn',
                    icon: FontAwesomeIcons.user,
                  ),
                  const SizedBox(height: 18),
                  _buildTextField(
                    label: 'Locket ID (Username độc quyền)',
                    controller: _idController,
                    hint: 'locket.id',
                    prefixText: '@',
                    icon: FontAwesomeIcons.at,
                  ),
                  const SizedBox(height: 18),
                  _buildTextField(
                    label: 'Tiểu sử Bio',
                    controller: _bioController,
                    hint: 'Một dòng ngắn về bạn...',
                    maxLines: 2,
                    icon: FontAwesomeIcons.quoteLeft,
                  ),
                  const SizedBox(height: 18),
                  const Divider(),
                  const SizedBox(height: 18),
                  _buildTextField(
                    label: 'Số điện thoại liên kết',
                    controller: _phoneController,
                    hint: '+84...',
                    icon: FontAwesomeIcons.phone,
                  ),
                  const SizedBox(height: 18),
                  _buildTextField(
                    label: 'Email bảo mật',
                    controller: _emailController,
                    hint: 'email@example.com',
                    icon: FontAwesomeIcons.envelope,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Save Button
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.icon(
                onPressed: _saveChanges,
                style: FilledButton.styleFrom(
                  backgroundColor: ZaloColors.locketYellow,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  elevation: 1,
                ),
                icon: const FaIcon(FontAwesomeIcons.floppyDisk, size: 14),
                label: const Text(
                  'Lưu thay đổi',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required FaIconData icon,
    String? prefixText,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: ZaloColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 14, right: 10),
              child: FaIcon(icon, size: 14, color: ZaloColors.textMuted),
            ),
            prefixIconConstraints: const BoxConstraints(minWidth: 40),
            prefixText: prefixText,
            hintText: hint,
            hintStyle: const TextStyle(color: ZaloColors.textMuted, fontSize: 13.5),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
              borderSide: BorderSide(color: ZaloColors.border.withValues(alpha: 0.8)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
              borderSide: BorderSide(color: ZaloColors.border.withValues(alpha: 0.8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
              borderSide: const BorderSide(color: ZaloColors.locketYellow, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
        ),
      ],
    );
  }
}
