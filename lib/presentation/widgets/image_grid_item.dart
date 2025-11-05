import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
                      child: Image.network(
                        item.previewURL,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.error),
                          );
                        },
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
                      child: Image.network(
                        item.previewURL,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: CupertinoColors.systemGrey5,
                            child: const Icon(
                              CupertinoIcons.exclamationmark_circle,
                            ),
                          );
                        },
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
