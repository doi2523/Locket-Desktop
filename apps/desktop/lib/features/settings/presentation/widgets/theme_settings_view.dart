import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/zalo_theme.dart';

class ThemeSettingsView extends StatefulWidget {
  const ThemeSettingsView({super.key});

  @override
  State<ThemeSettingsView> createState() => _ThemeSettingsViewState();
}

class _ThemeSettingsViewState extends State<ThemeSettingsView> {
  int _themeMode = 0; // 0: Sáng, 1: Tối, 2: Hệ thống
  int _selectedColorIndex = 0;
  double _momentRadius = 24.0;
  bool _enableGlassmorphism = true;
  bool _highQualityAnimations = true;

  final List<Map<String, dynamic>> _accentColors = [
    {'name': 'Vàng Locket', 'color': const Color(0xFFFFD600)},
    {'name': 'Xanh Zalo', 'color': const Color(0xFF0068FF)},
    {'name': 'Cam Hoàng Hôn', 'color': const Color(0xFFFF8500)},
    {'name': 'Tím Neon', 'color': const Color(0xFF8B5CF6)},
    {'name': 'Hồng Sakura', 'color': const Color(0xFFEC4899)},
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
              'Chủ đề & Giao diện',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ZaloColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Tùy biến màu sắc, chế độ hiển thị và hiệu ứng chuyển động theo phong cách của bạn',
              style: TextStyle(fontSize: 13.5, color: ZaloColors.textSecondary),
            ),
            const SizedBox(height: 24),

            // 1. Theme Mode Card (Light, Dark, System)
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
                    'Chế độ giao diện',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: _buildThemeModeOption(
                          index: 0,
                          icon: FontAwesomeIcons.sun,
                          title: 'Giao diện Sáng',
                          subtitle: 'Mặc định sạch sẽ',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildThemeModeOption(
                          index: 1,
                          icon: FontAwesomeIcons.moon,
                          title: 'Giao diện Tối',
                          subtitle: 'Êm dịu ban đêm',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildThemeModeOption(
                          index: 2,
                          icon: FontAwesomeIcons.desktop,
                          title: 'Theo hệ thống',
                          subtitle: 'Tự động đồng bộ',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 2. Accent Color Palette
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
                    'Màu sắc chủ đạo (Accent Color)',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Ảnh hưởng đến nút bấm, icon active, huy hiệu thông báo và viền widget',
                    style: TextStyle(fontSize: 12.5, color: ZaloColors.textSecondary),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 14,
                    runSpacing: 10,
                    children: List.generate(_accentColors.length, (index) {
                      final item = _accentColors[index];
                      final isSelected = _selectedColorIndex == index;
                      final Color col = item['color'];

                      return InkWell(
                        onTap: () => setState(() => _selectedColorIndex = index),
                        borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? col.withValues(alpha: 0.15) : const Color(0xFFF9FAFB),
                            borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                            border: Border.all(
                              color: isSelected ? col : ZaloColors.border.withValues(alpha: 0.7),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: col,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.black.withValues(alpha: 0.1)),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                item['name'],
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                  color: isSelected ? Colors.black : ZaloColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 3. Roundness & Effects
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
                    'Độ bo góc Moment (${24}px)',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Độ tròn viền góc của ảnh Moment trong màn hình Chat và Locket Feed',
                    style: TextStyle(fontSize: 12.5, color: ZaloColors.textSecondary),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Text('12px', style: TextStyle(fontSize: 12, color: ZaloColors.textSecondary)),
                      Expanded(
                        child: Slider(
                          value: _momentRadius,
                          min: 12,
                          max: 36,
                          divisions: 6,
                          activeColor: ZaloColors.locketYellow,
                          label: '${_momentRadius.toInt()}px',
                          onChanged: (val) => setState(() => _momentRadius = val),
                        ),
                      ),
                      const Text('36px', style: TextStyle(fontSize: 12, color: ZaloColors.textSecondary)),
                    ],
                  ),
                  const Divider(height: 24),
                  SwitchListTile(
                    value: _enableGlassmorphism,
                    contentPadding: EdgeInsets.zero,
                    activeThumbColor: const Color(0xFFD97706),
                    onChanged: (val) => setState(() => _enableGlassmorphism = val),
                    title: const Text('Hiệu ứng kính mờ (Glassmorphism)', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    subtitle: const Text('Làm mờ nền đằng sau thanh điều hướng và header', style: TextStyle(fontSize: 12.5)),
                  ),
                  const Divider(height: 24),
                  SwitchListTile(
                    value: _highQualityAnimations,
                    contentPadding: EdgeInsets.zero,
                    activeThumbColor: const Color(0xFFD97706),
                    onChanged: (val) => setState(() => _highQualityAnimations = val),
                    title: const Text('Hiệu ứng chuyển cảnh 60fps', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    subtitle: const Text('Phóng to ảnh mượt mà từ vị trí thumbnail với hiệu ứng Hero scale', style: TextStyle(fontSize: 12.5)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeModeOption({
    required int index,
    required FaIconData icon,
    required String title,
    required String subtitle,
  }) {
    final isSelected = _themeMode == index;

    return InkWell(
      onTap: () => setState(() => _themeMode = index),
      borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? ZaloColors.locketYellowLight.withValues(alpha: 0.5) : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
          border: Border.all(
            color: isSelected ? ZaloColors.locketYellow : ZaloColors.border.withValues(alpha: 0.7),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            FaIcon(
              icon,
              size: 24,
              color: isSelected ? const Color(0xFFD97706) : ZaloColors.textSecondary,
            ),
            const SizedBox(height: 10),
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
              style: const TextStyle(fontSize: 11.5, color: ZaloColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
