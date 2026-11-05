import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/theme/zalo_theme.dart';
import '../../shared/mock/mock_data.dart';

class DesktopNavRail extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const DesktopNavRail({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      decoration: const BoxDecoration(
        color: ZaloColors.railBackground,
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          // User Avatar with Online Indicator & Rounded Ring
          Stack(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black.withValues(alpha: 0.2),
                    width: 2.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(MockData.currentUser.avatarUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 2,
                bottom: 2,
                child: Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                    color: ZaloColors.online,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Navigation Items (Bo tròn dạng pill / squircle)
          _buildRailItem(
            icon: FontAwesomeIcons.commentDots,
            activeIcon: FontAwesomeIcons.solidCommentDots,
            label: 'Tin nhắn',
            index: 0,
            badgeCount: 3,
          ),
          const SizedBox(height: 8),
          _buildRailItem(
            icon: FontAwesomeIcons.userGroup,
            activeIcon: FontAwesomeIcons.userGroup,
            label: 'Bạn bè',
            index: 1,
          ),
          const SizedBox(height: 8),
          _buildRailItem(
            icon: FontAwesomeIcons.boltLightning,
            activeIcon: FontAwesomeIcons.boltLightning,
            label: 'Locket Feed',
            index: 2,
            hasOrangeDot: true,
          ),
          const SizedBox(height: 8),
          _buildRailItem(
            icon: FontAwesomeIcons.wandMagicSparkles,
            activeIcon: FontAwesomeIcons.wandMagicSparkles,
            label: 'Custom Studio',
            index: 3,
          ),

          const Spacer(),

          // Bottom Items with FontAwesome
          _buildBottomAction(
            icon: FontAwesomeIcons.cloud,
            tooltip: 'Cloud của tôi',
            onTap: () {},
          ),
          const SizedBox(height: 6),
          _buildBottomAction(
            icon: FontAwesomeIcons.gear,
            tooltip: 'Cài đặt',
            isSelected: selectedIndex == 4,
            onTap: () => onDestinationSelected(4),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildRailItem({
    required FaIconData icon,
    required FaIconData activeIcon,
    required String label,
    required int index,
    int badgeCount = 0,
    bool hasOrangeDot = false,
  }) {
    final isSelected = selectedIndex == index;
    return Tooltip(
      message: label,
      preferBelow: false,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onDestinationSelected(index),
          borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.black.withValues(alpha: 0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ]
                  : null,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                FaIcon(
                  isSelected ? activeIcon : icon,
                  color: isSelected
                      ? ZaloColors.railIconColor
                      : ZaloColors.railIconInactive,
                  size: 20,
                ),
                if (badgeCount > 0)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: ZaloColors.badgeRed,
                        borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                        border: Border.all(color: Colors.white, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                      child: Text(
                        badgeCount > 9 ? '9+' : '$badgeCount',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                if (hasOrangeDot)
                  Positioned(
                    top: 8,
                    right: 10,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF5722),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomAction({
    required FaIconData icon,
    required String tooltip,
    required VoidCallback onTap,
    bool isSelected = false,
  }) {
    return Tooltip(
      message: tooltip,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isSelected ? Colors.black.withValues(alpha: 0.15) : Colors.transparent,
              borderRadius: BorderRadius.circular(ZaloColors.radiusMd),
            ),
            child: Center(
              child: FaIcon(
                icon,
                color: isSelected ? ZaloColors.railIconColor : ZaloColors.railIconInactive,
                size: 19,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
