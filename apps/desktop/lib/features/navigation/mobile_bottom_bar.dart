import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/theme/zalo_theme.dart';

class MobileBottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const MobileBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ZaloColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(ZaloColors.radiusLg)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(ZaloColors.radiusLg)),
        child: SafeArea(
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: onDestinationSelected,
            type: BottomNavigationBarType.fixed,
            backgroundColor: ZaloColors.surface,
            selectedItemColor: const Color(0xFFD97706), // warm amber/gold
            unselectedItemColor: ZaloColors.textSecondary,
            selectedFontSize: 11,
            unselectedFontSize: 11,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Badge(
                  label: Text('3'),
                  child: FaIcon(FontAwesomeIcons.commentDots, size: 19),
                ),
                activeIcon: Badge(
                  label: Text('3'),
                  child: FaIcon(FontAwesomeIcons.solidCommentDots, size: 19),
                ),
                label: 'Tin nhắn',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.userGroup, size: 19),
                activeIcon: FaIcon(FontAwesomeIcons.userGroup, size: 19),
                label: 'Bạn bè',
              ),
              BottomNavigationBarItem(
                icon: Badge(
                  backgroundColor: ZaloColors.locketOrange,
                  smallSize: 8,
                  child: FaIcon(FontAwesomeIcons.boltLightning, size: 19),
                ),
                activeIcon: Badge(
                  backgroundColor: ZaloColors.locketOrange,
                  smallSize: 8,
                  child: FaIcon(FontAwesomeIcons.boltLightning, size: 19),
                ),
                label: 'Khám phá',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.wandMagicSparkles, size: 19),
                activeIcon: FaIcon(FontAwesomeIcons.wandMagicSparkles, size: 19),
                label: 'Studio',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.solidUser, size: 19),
                activeIcon: FaIcon(FontAwesomeIcons.solidUser, size: 19),
                label: 'Cá nhân',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
