import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/zalo_theme.dart';
import '../../../../shared/mock/mock_data.dart';

enum SettingsCategory {
  account,
  theme,
  widget,
  privacy,
  notifications,
  storage,
}

class SettingsSidebar extends StatelessWidget {
  final SettingsCategory selectedCategory;
  final ValueChanged<SettingsCategory> onCategorySelected;
  final VoidCallback onLogout;
  final VoidCallback onDeleteAccount;

  const SettingsSidebar({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.onLogout,
    required this.onDeleteAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: ZaloColors.surface,
        border: Border(
          right: BorderSide(
            color: ZaloColors.border.withValues(alpha: 0.8),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: ZaloColors.border.withValues(alpha: 0.8),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ZaloColors.locketYellowLight,
                    borderRadius: BorderRadius.circular(ZaloColors.radiusSm),
                  ),
                  child: const FaIcon(
                    FontAwesomeIcons.gear,
                    size: 16,
                    color: Color(0xFFD97706),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Cài đặt',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ZaloColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          // User Mini Profile Card
          Padding(
            padding: const EdgeInsets.all(16),
            child: InkWell(
              onTap: () => onCategorySelected(SettingsCategory.account),
              borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: selectedCategory == SettingsCategory.account
                      ? ZaloColors.locketYellowLight.withValues(alpha: 0.4)
                      : const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
                  border: Border.all(
                    color: selectedCategory == SettingsCategory.account
                        ? ZaloColors.locketYellow
                        : ZaloColors.border.withValues(alpha: 0.6),
                  ),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(MockData.currentUser.avatarUrl),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 11,
                            height: 11,
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            MockData.currentUser.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: ZaloColors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            '@dio.developer.2026',
                            style: TextStyle(
                              fontSize: 11.5,
                              color: ZaloColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: 11,
                      color: ZaloColors.textMuted,
                    ),
                  ],
                ),
              ),
            ),
          ),

          const Divider(height: 1),

          // Menu Categories List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: [
                _buildMenuItem(
                  category: SettingsCategory.account,
                  icon: FontAwesomeIcons.solidUser,
                  title: 'Tài khoản & Hồ sơ',
                  subtitle: 'Tên, avatar, ID Locket',
                ),
                _buildMenuItem(
                  category: SettingsCategory.theme,
                  icon: FontAwesomeIcons.palette,
                  title: 'Chủ đề & Giao diện',
                  subtitle: 'Màu sắc, dark mode, font',
                ),
                _buildMenuItem(
                  category: SettingsCategory.widget,
                  icon: FontAwesomeIcons.cubesStacked,
                  title: 'Cài đặt Widget',
                  subtitle: 'Khung viền, tần suất refresh',
                ),
                _buildMenuItem(
                  category: SettingsCategory.privacy,
                  icon: FontAwesomeIcons.shieldHalved,
                  title: 'Quyền riêng tư & Bảo mật',
                  subtitle: 'Ai thấy khoảnh khắc, mã PIN',
                ),
                _buildMenuItem(
                  category: SettingsCategory.notifications,
                  icon: FontAwesomeIcons.solidBell,
                  title: 'Thông báo & Âm thanh',
                  subtitle: 'Chuông Zalo pop, tin nhắn mới',
                ),
                _buildMenuItem(
                  category: SettingsCategory.storage,
                  icon: FontAwesomeIcons.hardDrive,
                  title: 'Dữ liệu & Bộ nhớ',
                  subtitle: 'Xóa cache, tự động lưu ảnh',
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Danger Zone Actions (Đăng xuất / Xóa tài khoản)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Column(
              children: [
                InkWell(
                  onTap: onLogout,
                  borderRadius: BorderRadius.circular(ZaloColors.radiusSm),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                    child: Row(
                      children: const [
                        FaIcon(
                          FontAwesomeIcons.arrowRightFromBracket,
                          size: 15,
                          color: Color(0xFFEF4444),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Đăng xuất',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFEF4444),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                InkWell(
                  onTap: onDeleteAccount,
                  borderRadius: BorderRadius.circular(ZaloColors.radiusSm),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: const [
                        FaIcon(
                          FontAwesomeIcons.trashCan,
                          size: 14,
                          color: ZaloColors.textSecondary,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Xóa tài khoản',
                          style: TextStyle(
                            fontSize: 13,
                            color: ZaloColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required SettingsCategory category,
    required FaIconData icon,
    required String title,
    required String subtitle,
  }) {
    final isSelected = selectedCategory == category;

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      child: Material(
        color: isSelected
            ? ZaloColors.locketYellowLight.withValues(alpha: 0.5)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
        child: InkWell(
          onTap: () => onCategorySelected(category),
          borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
          hoverColor: ZaloColors.locketYellowLight.withValues(alpha: 0.2),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? ZaloColors.locketYellow : const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(ZaloColors.radiusSm),
                  ),
                  child: FaIcon(
                    icon,
                    size: 15,
                    color: isSelected ? Colors.black : ZaloColors.textSecondary,
                  ),
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
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                          color: isSelected ? Colors.black : ZaloColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: ZaloColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (isSelected)
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD97706),
                      shape: BoxShape.circle,
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
