import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/theme/zalo_theme.dart';

class CustomStudioPanel extends StatefulWidget {
  const CustomStudioPanel({super.key});

  @override
  State<CustomStudioPanel> createState() => _CustomStudioPanelState();
}

class _CustomStudioPanelState extends State<CustomStudioPanel> {
  final TextEditingController _captionController =
      TextEditingController(text: 'Chúc mọi người một ngày làm việc tràn đầy năng lượng! ✨');
  Color _selectedFrameColor = const Color(0xFFFFCC00);
  int _selectedFilterIndex = 0;

  final List<Color> _frameColors = const [
    Color(0xFFFFCC00), // Locket Yellow
    Color(0xFF0068FF), // Zalo Blue
    Color(0xFFFF4D4F), // Red
    Color(0xFF52C41A), // Green
    Color(0xFF722ED1), // Purple
    Color(0xFF13C2C2), // Cyan
    Color(0xFF1F1F1F), // Dark
  ];

  final List<String> _filters = const [
    'Mặc định',
    'Hoàng hôn (Warm)',
    'Cổ điển (Vintage)',
    'Điện ảnh (Cinematic)',
    'Đen trắng (B&W)',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF0F2F5),
      child: Column(
        children: [
          // Header
          Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            color: ZaloColors.surface,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ZaloColors.locketYellowLight,
                    borderRadius: BorderRadius.circular(ZaloColors.radiusSm),
                  ),
                  child: const FaIcon(
                    FontAwesomeIcons.wandMagicSparkles,
                    color: Color(0xFFD97706),
                    size: 16,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Locket Dio Custom Studio',
                  style: TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.bold,
                    color: ZaloColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Studio Body
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Controls (380px)
                Container(
                  width: 380,
                  color: ZaloColors.surface,
                  padding: const EdgeInsets.all(24),
                  child: ListView(
                    children: [
                      const Text(
                        '1. Soạn thảo Caption',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _captionController,
                        maxLines: 3,
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          hintText: 'Nhập nội dung caption...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
                            borderSide: const BorderSide(color: ZaloColors.border),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
                            borderSide: BorderSide(color: ZaloColors.border.withValues(alpha: 0.8)),
                          ),
                          filled: true,
                          fillColor: ZaloColors.background,
                          contentPadding: const EdgeInsets.all(14),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        '2. Màu viền Widget / Frame',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: _frameColors.map((color) {
                          final isSelected = _selectedFrameColor == color;
                          return InkWell(
                            onTap: () => setState(() => _selectedFrameColor = color),
                            borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? Colors.black : Colors.transparent,
                                  width: 2.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: color.withValues(alpha: 0.35),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: isSelected
                                  ? const Center(
                                      child: FaIcon(FontAwesomeIcons.check, size: 14, color: Colors.white),
                                    )
                                  : null,
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        '3. Bộ lọc màu (Preset Filter)',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<int>(
                        initialValue: _selectedFilterIndex,
                        items: List.generate(_filters.length, (index) {
                          return DropdownMenuItem(
                            value: index,
                            child: Text(_filters[index], style: const TextStyle(fontSize: 13.5)),
                          );
                        }),
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedFilterIndex = val);
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          filled: true,
                          fillColor: ZaloColors.background,
                        ),
                      ),
                      const SizedBox(height: 32),
                      FilledButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Đã đồng bộ Moment sang Widget Windows & iOS!')),
                          );
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF1E1E1E),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                          ),
                        ),
                        icon: const FaIcon(FontAwesomeIcons.cloudArrowUp, size: 16),
                        label: const Text(
                          'Áp dụng & Gửi lên Widget',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(width: 1),
                // Right Live Preview Area
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Xem trước Widget hiển thị trên Desktop / Lockscreen',
                          style: TextStyle(
                            fontSize: 13.5,
                            color: ZaloColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: 340,
                          height: 340,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(34),
                            border: Border.all(color: _selectedFrameColor, width: 4.5),
                            boxShadow: [
                              BoxShadow(
                                color: _selectedFrameColor.withValues(alpha: 0.35),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=600',
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  bottom: 16,
                                  left: 14,
                                  right: 14,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withValues(alpha: 0.72),
                                      borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                                    ),
                                    child: Text(
                                      _captionController.text,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
}
