import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/image_item.dart';
import '../../core/utils/format_bytes.dart';
import '../theme/app_theme.dart';

class ImageGridItem extends StatelessWidget {
  final ImageItem item;
  final VoidCallback? onTap;
  final bool showSelectionOverlay;
  final bool selected;

  const ImageGridItem({
    super.key,
    required this.item,
    this.onTap,
    this.showSelectionOverlay = false,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    if (AppTheme.isIOS) {
      return _buildCupertinoItem(context);
    } else {
      return _buildMaterialItem(context);
    }
  }

  Widget _buildMaterialItem(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: item.previewURL,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.error),
                        ),
                        memCacheWidth: 300,
                        memCacheHeight: 300,
                      ),
                    ),
                  ),
                  if (showSelectionOverlay && selected)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 48,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.user,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: 13),
          ),
          Text(
            FormatBytes.formatShort(item.imageSizeBytes),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCupertinoItem(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            child: AspectRatio(
              aspectRatio: 1,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: item.previewURL,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: CupertinoColors.systemGrey5,
                          child: const Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: CupertinoColors.systemGrey5,
                          child: const Icon(
                            CupertinoIcons.exclamationmark_circle,
                          ),
                        ),
                        memCacheWidth: 300,
                        memCacheHeight: 300,
                      ),
                    ),
                  ),
                  if (showSelectionOverlay && selected)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: CupertinoColors.black.withOpacity(0.45),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(
                            CupertinoIcons.check_mark,
                            color: CupertinoColors.white,
                            size: 48,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.user,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: CupertinoTheme.of(
              context,
            ).textTheme.textStyle.copyWith(fontSize: 13),
          ),
          Text(
            FormatBytes.formatShort(item.imageSizeBytes),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
              color: CupertinoColors.systemGrey,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
