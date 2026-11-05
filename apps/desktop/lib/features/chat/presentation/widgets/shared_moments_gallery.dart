import 'package:flutter/material.dart';
import '../../../../core/theme/zalo_theme.dart';
import 'moment_detail_viewer.dart';

class SharedMomentsGallery extends StatelessWidget {
  final List<Map<String, String>> moments;
  final String friendName;
  final String friendAvatarUrl;

  const SharedMomentsGallery({
    super.key,
    required this.moments,
    required this.friendName,
    required this.friendAvatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Grid 3xn
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
        childAspectRatio: 1.0, // Aspect 1:1
      ),
      itemCount: moments.length,
      itemBuilder: (context, index) {
        final moment = moments[index];
        final heroTag = 'moment_gallery_$index';

        return InkWell(
          onTap: () {
            MomentDetailViewer.show(
              context,
              moments: moments,
              initialIndex: index,
              friendName: friendName,
              friendAvatarUrl: friendAvatarUrl,
            );
          },
          borderRadius: BorderRadius.circular(ZaloColors.radiusLg),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ZaloColors.radiusLg),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Hero(
              tag: heroTag,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(ZaloColors.radiusLg),
                child: Image.network(
                  moment['url']!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
