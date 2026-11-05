import 'package:flutter/material.dart';
import '../../../../core/theme/zalo_theme.dart';

class WidgetSettingsView extends StatefulWidget {
  const WidgetSettingsView({super.key});

  @override
  State<WidgetSettingsView> createState() => _WidgetSettingsViewState();
}

class _WidgetSettingsViewState extends State<WidgetSettingsView> {
  int _selectedFrameIndex = 0;
  int _refreshIntervalIndex = 1; // 0: 5 phút, 1: 15 phút, 2: 30 phút, 3: Khi có ảnh mới
  bool _showSenderName = true;
  bool _showCaption = true;
  bool _autoSyncWindowsWidget = true;

  final List<String> _frames = [
    'Viền vàng Locket (Signature)',
    'Kính mờ Frosted Glass',
    'Khung phim Polaroid cổ điển',
    'Không viền (Tràn viền vi vu)',
  ];

  final List<String> _refreshIntervals = [
    'Mỗi 5 phút',
    'Mỗi 15 phút (Khuyên dùng)',
    'Mỗi 30 phút',
    'Ngay lập tức khi có ảnh mới (Realtime)',
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
              'Cài đặt Widget Màn hình',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ZaloColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Cấu hình cách Locket hiển thị trên Desktop Widget (Windows/macOS) và Mobile Widget',
              style: TextStyle(fontSize: 13.5, color: ZaloColors.textSecondary),
            ),
            const SizedBox(height: 24),

            // 1. Live Preview of Widget
            Container(
              padding: const EdgeInsets.all(24),
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
                children: [
                  const Text(
                    'Xem trước Widget trên màn hình của bạn',
                    style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 18),
                  Center(
                    child: Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: _selectedFrameIndex == 0
                              ? ZaloColors.locketYellow
                              : (_selectedFrameIndex == 1
                                  ? Colors.white.withValues(alpha: 0.5)
                                  : (_selectedFrameIndex == 2
                                      ? Colors.white
                                      : Colors.transparent)),
                          width: _selectedFrameIndex == 2 ? 8 : 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(_selectedFrameIndex == 2 ? 20 : 24),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=500',
                              fit: BoxFit.cover,
                            ),
                            // Gradient shadow
                            Positioned.fill(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black.withValues(alpha: 0.25),
                                      Colors.transparent,
                                      Colors.black.withValues(alpha: 0.5),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (_showSenderName)
                              Positioned(
                                top: 12,
                                left: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.4),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(radius: 7, backgroundColor: ZaloColors.locketYellow),
                                      SizedBox(width: 5),
                                      Text('Thảo My • 2p trước', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            if (_showCaption)
                              Positioned(
                                bottom: 12,
                                left: 12,
                                right: 12,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.6),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Text(
                                    'Cafe sáng Chủ Nhật chill chill ☕✨',
                                    style: TextStyle(color: Colors.white, fontSize: 11),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 2. Frame Styles
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
                    'Kiểu khung viền Widget',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 14),
                  ...List.generate(_frames.length, (index) {
                    final isSelected = _selectedFrameIndex == index;
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
                        onTap: () => setState(() => _selectedFrameIndex = index),
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
                                _frames[index],
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
              ),
            ),
            const SizedBox(height: 24),

            // 3. Intervals and Toggles
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
                    'Tần suất làm mới Widget',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<int>(
                    initialValue: _refreshIntervalIndex,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF9FAFB),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
                        borderSide: BorderSide(color: ZaloColors.border.withValues(alpha: 0.8)),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    ),
                    items: List.generate(_refreshIntervals.length, (idx) {
                      return DropdownMenuItem(
                        value: idx,
                        child: Text(_refreshIntervals[idx], style: const TextStyle(fontSize: 13.5)),
                      );
                    }),
                    onChanged: (val) {
                      if (val != null) setState(() => _refreshIntervalIndex = val);
                    },
                  ),
                  const Divider(height: 28),
                  SwitchListTile(
                    value: _showSenderName,
                    contentPadding: EdgeInsets.zero,
                    activeThumbColor: const Color(0xFFD97706),
                    onChanged: (val) => setState(() => _showSenderName = val),
                    title: const Text('Hiển thị tên người gửi trên Widget', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    subtitle: const Text('Biết ngay ai vừa gửi ảnh cho bạn mà không cần mở app', style: TextStyle(fontSize: 12.5)),
                  ),
                  const Divider(height: 28),
                  SwitchListTile(
                    value: _showCaption,
                    contentPadding: EdgeInsets.zero,
                    activeThumbColor: const Color(0xFFD97706),
                    onChanged: (val) => setState(() => _showCaption = val),
                    title: const Text('Hiển thị dòng chữ Caption', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    subtitle: const Text('Bật/tắt thanh phụ đề chữ trên khung ảnh Widget', style: TextStyle(fontSize: 12.5)),
                  ),
                  const Divider(height: 28),
                  SwitchListTile(
                    value: _autoSyncWindowsWidget,
                    contentPadding: EdgeInsets.zero,
                    activeThumbColor: const Color(0xFFD97706),
                    onChanged: (val) => setState(() => _autoSyncWindowsWidget = val),
                    title: const Text('Tự động khởi động cùng hệ thống', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    subtitle: const Text('Giữ widget luôn chạy ngầm trên Windows & macOS', style: TextStyle(fontSize: 12.5)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
