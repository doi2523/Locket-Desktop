import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/zalo_theme.dart';

class StorageSettingsView extends StatefulWidget {
  const StorageSettingsView({super.key});

  @override
  State<StorageSettingsView> createState() => _StorageSettingsViewState();
}

class _StorageSettingsViewState extends State<StorageSettingsView> {
  bool _autoSavePhotos = true;
  bool _uploadHD = true;
  double _cacheSizeMB = 128.4;
  bool _isClearing = false;

  void _clearCache() async {
    setState(() => _isClearing = true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (mounted) {
      setState(() {
        _cacheSizeMB = 0.0;
        _isClearing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              FaIcon(FontAwesomeIcons.circleCheck, color: Colors.white, size: 16),
              SizedBox(width: 10),
              Text('Đã xóa sạch bộ nhớ đệm cache (128.4 MB giải phóng)!'),
            ],
          ),
          backgroundColor: const Color(0xFF10B981),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
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
            const Text(
              'Dữ liệu & Bộ nhớ lưu trữ',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ZaloColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Quản lý dung lượng bộ nhớ tạm thời của các khoảnh khắc và tối ưu hiệu suất máy tính',
              style: TextStyle(fontSize: 13.5, color: ZaloColors.textSecondary),
            ),
            const SizedBox(height: 24),

            // 1. Storage Usage Card
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Bộ nhớ đệm (Cache)',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _cacheSizeMB > 0 ? '${_cacheSizeMB.toStringAsFixed(1)} MB đang được sử dụng' : '0 MB (Đã dọn dẹp sạch sẽ)',
                            style: TextStyle(
                              fontSize: 13,
                              color: _cacheSizeMB > 0 ? ZaloColors.textSecondary : const Color(0xFF10B981),
                              fontWeight: _cacheSizeMB == 0 ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      FilledButton.icon(
                        onPressed: _cacheSizeMB > 0 && !_isClearing ? _clearCache : null,
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFFEF4444),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        icon: _isClearing
                            ? const SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              )
                            : const FaIcon(FontAwesomeIcons.broom, size: 13),
                        label: Text(_isClearing ? 'Đang dọn...' : 'Xóa bộ nhớ đệm', style: const TextStyle(fontSize: 13)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                    child: LinearProgressIndicator(
                      value: _cacheSizeMB > 0 ? 0.35 : 0.0,
                      backgroundColor: const Color(0xFFF3F4F6),
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFD97706)),
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Cache chứa ảnh tạm thời giúp tải nhanh khoảnh khắc khi không có mạng. Xóa cache không làm mất ảnh của bạn.',
                    style: TextStyle(fontSize: 12, color: ZaloColors.textMuted),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 2. Photo saving & quality
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
                    'Ảnh & Đa phương tiện',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    value: _autoSavePhotos,
                    contentPadding: EdgeInsets.zero,
                    activeThumbColor: const Color(0xFFD97706),
                    onChanged: (val) => setState(() => _autoSavePhotos = val),
                    title: const Text('Tự động lưu ảnh chụp vào máy tính', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    subtitle: const Text('Lưu ảnh khoảnh khắc bạn chụp vào thư mục Pictures/Locket', style: TextStyle(fontSize: 12.5)),
                  ),
                  const Divider(height: 24),
                  SwitchListTile(
                    value: _uploadHD,
                    contentPadding: EdgeInsets.zero,
                    activeThumbColor: const Color(0xFFD97706),
                    onChanged: (val) => setState(() => _uploadHD = val),
                    title: const Text('Tải ảnh lên chất lượng cao (HD)', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    subtitle: const Text('Giữ nguyên độ sắc nét tối đa của ống kính camera', style: TextStyle(fontSize: 12.5)),
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
