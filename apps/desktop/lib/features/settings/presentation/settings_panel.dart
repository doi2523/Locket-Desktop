import 'package:flutter/material.dart';
import '../../../core/theme/zalo_theme.dart';
import 'widgets/account_settings_view.dart';
import 'widgets/danger_zone_dialogs.dart';
import 'widgets/notification_settings_view.dart';
import 'widgets/privacy_security_view.dart';
import 'widgets/settings_sidebar.dart';
import 'widgets/storage_settings_view.dart';
import 'widgets/theme_settings_view.dart';
import 'widgets/widget_settings_view.dart';

class SettingsPanel extends StatefulWidget {
  const SettingsPanel({super.key});

  @override
  State<SettingsPanel> createState() => _SettingsPanelState();
}

class _SettingsPanelState extends State<SettingsPanel> {
  SettingsCategory _selectedCategory = SettingsCategory.account;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ZaloColors.background,
      child: Row(
        children: [
          // 1. Left Sidebar Navigation (~320px)
          SettingsSidebar(
            selectedCategory: _selectedCategory,
            onCategorySelected: (category) {
              setState(() => _selectedCategory = category);
            },
            onLogout: () => DangerZoneDialogs.showLogoutDialog(context),
            onDeleteAccount: () => DangerZoneDialogs.showDeleteAccountDialog(context),
          ),

          // 2. Right Content View (Expanded)
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _buildCategoryView(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryView() {
    switch (_selectedCategory) {
      case SettingsCategory.account:
        return const AccountSettingsView(key: ValueKey('account_settings_view'));
      case SettingsCategory.theme:
        return const ThemeSettingsView(key: ValueKey('theme_settings_view'));
      case SettingsCategory.widget:
        return const WidgetSettingsView(key: ValueKey('widget_settings_view'));
      case SettingsCategory.privacy:
        return const PrivacySecurityView(key: ValueKey('privacy_security_view'));
      case SettingsCategory.notifications:
        return const NotificationSettingsView(key: ValueKey('notification_settings_view'));
      case SettingsCategory.storage:
        return const StorageSettingsView(key: ValueKey('storage_settings_view'));
    }
  }
}
