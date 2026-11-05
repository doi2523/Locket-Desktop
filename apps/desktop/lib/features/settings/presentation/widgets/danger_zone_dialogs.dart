import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/zalo_theme.dart';

class DangerZoneDialogs {
  static void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ZaloColors.radiusLg)),
        title: Row(
          children: const [
            FaIcon(FontAwesomeIcons.arrowRightFromBracket, size: 18, color: Color(0xFFEF4444)),
            SizedBox(width: 12),
            Text('Đăng xuất tài khoản', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        content: const Text(
          'Bạn có chắc chắn muốn đăng xuất khỏi Locket Dio trên thiết bị này không? Các khoảnh khắc của bạn vẫn được lưu an toàn trên đám mây.',
          style: TextStyle(fontSize: 13.5, color: ZaloColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy', style: TextStyle(color: ZaloColors.textSecondary)),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Đã đăng xuất thành công!'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ZaloColors.radiusPill)),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            ),
            child: const Text('Đăng xuất', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  static void showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ZaloColors.radiusLg)),
        title: Row(
          children: const [
            FaIcon(FontAwesomeIcons.triangleExclamation, size: 18, color: Color(0xFFDC2626)),
            SizedBox(width: 12),
            Text('Xóa vĩnh viễn tài khoản?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFDC2626))),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Hành động này KHÔNG THỂ HOÀN TÁC. Khi xóa tài khoản:',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5),
            ),
            SizedBox(height: 8),
            Text('• Toàn bộ lịch sử khoảnh khắc Moment sẽ bị xóa vĩnh viễn.', style: TextStyle(fontSize: 12.5, color: ZaloColors.textSecondary)),
            SizedBox(height: 4),
            Text('• Bạn bè sẽ không còn thấy bạn trên Locket Widget.', style: TextStyle(fontSize: 12.5, color: ZaloColors.textSecondary)),
            SizedBox(height: 4),
            Text('• Locket ID @dio.developer.2026 sẽ được giải phóng.', style: TextStyle(fontSize: 12.5, color: ZaloColors.textSecondary)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy bỏ', style: TextStyle(color: ZaloColors.textSecondary)),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Yêu cầu xóa tài khoản đã được tiếp nhận.'),
                  backgroundColor: const Color(0xFFDC2626),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ZaloColors.radiusPill)),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            ),
            child: const Text('Tôi hiểu, xóa tài khoản', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
