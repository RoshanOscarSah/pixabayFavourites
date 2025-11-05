import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/image_item.dart';
import '../providers/favorites_provider.dart';
import '../widgets/image_grid_item.dart';
import '../theme/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (AppTheme.isIOS) {
      return _buildCupertinoPage(context);
    } else {
      return _buildMaterialPage(context);
    }
  }

  Widget _buildMaterialPage(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favorites;
    return Scaffold(
      appBar: AppBar(title: const Text('Your favorite images')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: favorites.isEmpty
            ? const Center(child: Text("Your favorite list is empty"))
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.95,
                ),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final item = favorites[index];
                  return ImageGridItem(
                    item: item,
                    onTap: () => _showRemoveDialog(context, item),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).pushNamed('/search'),
        icon: const Icon(Icons.add),
        label: const Text('Add new images'),
      ),
    );
  }

  Widget _buildCupertinoPage(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favorites;
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Your favorite images'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: <Widget>[
              Expanded(
                child: favorites.isEmpty
                    ? const Center(child: Text("Your favorite list is empty"))
                    : GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.95,
                        ),
                        itemCount: favorites.length,
                        itemBuilder: (context, index) {
                          final item = favorites[index];
                          return ImageGridItem(
                            item: item,
                            onTap: () => _showRemoveDialog(context, item),
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: CupertinoButton.filled(
                    onPressed: () => Navigator.of(context).pushNamed('/search'),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(CupertinoIcons.add, size: 20),
                        SizedBox(width: 8),
                        Text('Add new images'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showRemoveDialog(BuildContext context, ImageItem item) async {
    final bool? confirm = AppTheme.isIOS
        ? await _showCupertinoDialog(context)
        : await _showMaterialDialog(context);

    if (confirm == true && context.mounted) {
      context.read<FavoritesProvider>().removeById(item.id);
    }
  }

  Future<bool?> _showMaterialDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove image'),
        content: const Text('Do you want to remove this image from favorites?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('NO'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('YES'),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showCupertinoDialog(BuildContext context) {
    return showCupertinoDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Remove image'),
        content: const Text('Do you want to remove this image from favorites?'),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('NO'),
          ),
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(true),
            isDestructiveAction: true,
            child: const Text('YES'),
          ),
        ],
      ),
    );
  }
}


