import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/zalo_theme.dart';

class MomentDetailViewer {
  static void show(
    BuildContext context, {
    required List<Map<String, String>> moments,
    required int initialIndex,
    required String friendName,
    required String friendAvatarUrl,
    String? customHeroTag,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        transitionDuration: const Duration(milliseconds: 320),
        reverseTransitionDuration: const Duration(milliseconds: 280),
        pageBuilder: (dialogContext, animation, secondaryAnimation) {
          int currentIndex = initialIndex;

          return StatefulBuilder(
            builder: (context, setDialogState) {
              final currentMoment = moments[currentIndex];
              final hasPrevious = currentIndex > 0;
              final hasNext = currentIndex < moments.length - 1;
              final heroTag = customHeroTag ?? 'moment_gallery_$initialIndex';

              return Focus(
                autofocus: true,
                onKeyEvent: (node, event) {
                  if (event is KeyDownEvent) {
                    if (event.logicalKey == LogicalKeyboardKey.arrowLeft && hasPrevious) {
                      setDialogState(() => currentIndex--);
                      return KeyEventResult.handled;
                    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight && hasNext) {
                      setDialogState(() => currentIndex++);
                      return KeyEventResult.handled;
                    } else if (event.logicalKey == LogicalKeyboardKey.escape) {
                      Navigator.of(context).pop();
                      return KeyEventResult.handled;
                    }
                  }
                  return KeyEventResult.ignored;
                },
                child: Material(
                  color: Colors.transparent,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // 1. Semi-transparent dark overlay (fade in/out, tap backdrop to dismiss)
                      FadeTransition(
                        opacity: CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutCubic,
                          reverseCurve: Curves.easeInCubic,
                        ),
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            color: Colors.black.withValues(alpha: 0.88),
                          ),
                        ),
                      ),

                      // 2. Top Navigation Bar (Friend info, index counter, close button)
                      Positioned(
                        top: 24,
                        left: 28,
                        right: 28,
                        child: FadeTransition(
                          opacity: CurvedAnimation(
                            parent: animation,
                            curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
                            reverseCurve: const Interval(0.3, 1.0, curve: Curves.easeIn),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(friendAvatarUrl),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    friendName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (currentMoment['time'] != null)
                                    Text(
                                      currentMoment['time']!,
                                      style: TextStyle(
                                        color: Colors.white.withValues(alpha: 0.7),
                                        fontSize: 11.5,
                                      ),
                                    ),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                                ),
                                child: Text(
                                  '${currentIndex + 1} / ${moments.length}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                                child: Container(
                                  width: 38,
                                  height: 38,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: FaIcon(FontAwesomeIcons.xmark, size: 16, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // 3. Center Area with Hero Image and Left/Right Navigation Buttons
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Previous Button (Left)
                              FadeTransition(
                                opacity: CurvedAnimation(
                                  parent: animation,
                                  curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
                                  reverseCurve: const Interval(0.3, 1.0, curve: Curves.easeIn),
                                ),
                                child: Opacity(
                                  opacity: hasPrevious ? 1.0 : 0.3,
                                  child: InkWell(
                                    onTap: hasPrevious
                                        ? () => setDialogState(() => currentIndex--)
                                        : null,
                                    borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                                    child: Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.18),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.3),
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                      child: const Center(
                                        child: FaIcon(FontAwesomeIcons.chevronLeft, size: 18, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 32),

                              // Main Image Card (Hero Scale Transition from original position)
                              SizedBox(
                                width: 440,
                                height: 440,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    // 1. Hero Image scaling from grid item to 440x440
                                    Hero(
                                      tag: heroTag,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(48),
                                        child: Image.network(
                                          currentMoment['url']!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    // 4. Caption Overlay (Bottom Center Pill - w-fit co giãn theo nội dung)
                                    if (currentMoment['caption'] != null)
                                      Positioned(
                                        bottom: 20,
                                        left: 20,
                                        right: 20,
                                        child: Center(
                                          child: FadeTransition(
                                            opacity: CurvedAnimation(
                                              parent: animation,
                                              curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
                                              reverseCurve: const Interval(0.5, 1.0, curve: Curves.easeIn),
                                            ),
                                            child: Container(
                                              constraints: const BoxConstraints(maxWidth: 380),
                                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                                              decoration: BoxDecoration(
                                                color: Colors.black.withValues(alpha: 0.75),
                                                borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                                              ),
                                              child: Text(
                                                currentMoment['caption']!,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13.5,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 32),

                              // Next Button (Right) - fades in/out with dialog
                              FadeTransition(
                                opacity: CurvedAnimation(
                                  parent: animation,
                                  curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
                                  reverseCurve: const Interval(0.3, 1.0, curve: Curves.easeIn),
                                ),
                                child: Opacity(
                                  opacity: hasNext ? 1.0 : 0.3,
                                  child: InkWell(
                                    onTap: hasNext
                                        ? () => setDialogState(() => currentIndex++)
                                        : null,
                                    borderRadius: BorderRadius.circular(ZaloColors.radiusPill),
                                    child: Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.18),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.3),
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                      child: const Center(
                                        child: FaIcon(FontAwesomeIcons.chevronRight, size: 18, color: Colors.white),
                                      ),
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
              );
            },
          );
        },
      ),
    );
  }
}
