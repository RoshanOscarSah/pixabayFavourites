import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/image_item.dart';
import '../../domain/use_cases/search_images_use_case.dart';
import '../../core/errors/failures.dart';
import '../providers/favorites_provider.dart';
import '../widgets/image_grid_item.dart';
import '../theme/app_theme.dart';
import 'package:dartz/dartz.dart' hide State;

class SearchPage extends StatefulWidget {
  final SearchImagesUseCase searchImagesUseCase;

  const SearchPage({super.key, required this.searchImagesUseCase});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<ImageItem> _results = <ImageItem>[];
  bool _loading = false;
  bool _loadingMore = false;
  String? _error;
  String? _currentQuery;
  int _currentPage = 1;
  bool _hasMorePages = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      _loadMore();
    }
  }

  Future<void> _doSearch() async {
    final String q = _controller.text.trim();
    if (q.isEmpty) return;
    
    setState(() {
      _loading = true;
      _error = null;
      _currentQuery = q;
      _currentPage = 1;
      _hasMorePages = true;
      _results = <ImageItem>[];
    });

    final Either<Failure, List<ImageItem>> result = await widget
        .searchImagesUseCase(q, page: _currentPage);
    if (!mounted) return;

    result.fold(
      (Failure failure) {
        setState(() {
          _error = failure.message;
          _loading = false;
        });
      },
      (List<ImageItem> images) {
        setState(() {
          _results = images;
          _loading = false;
          _hasMorePages = images.length >= 20;
        });
      },
    );
  }

  Future<void> _loadMore() async {
    if (_loadingMore || !_hasMorePages || _currentQuery == null) return;

    setState(() {
      _loadingMore = true;
    });

    _currentPage++;
    final Either<Failure, List<ImageItem>> result = await widget
        .searchImagesUseCase(_currentQuery!, page: _currentPage);
    
    if (!mounted) return;

    result.fold(
      (Failure failure) {
        setState(() {
          _loadingMore = false;
          _currentPage--;
        });
      },
      (List<ImageItem> images) {
        setState(() {
          _results.addAll(images);
          _loadingMore = false;
          _hasMorePages = images.length >= 20;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (AppTheme.isIOS) {
      return _buildCupertinoPage(context);
    } else {
      return _buildMaterialPage(context);
    }
  }

  Widget _buildMaterialPage(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Add new images'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Search images',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                    ),
                    onSubmitted: (_) => _doSearch(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: _doSearch,
                  icon: const Icon(Icons.search, size: 20),
                  label: const Text('Search'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    minimumSize: const Size(0, 48),
                  ),
                ),
              ],
            ),
          ),
          if (_loading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (_error != null)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(_error!),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GridView.builder(
                  controller: _scrollController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.95,
                  ),
                  itemCount: _results.length + (_loadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _results.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    final item = _results[index];
                    final bool selected = favorites.isFavorite(item.id);
                    return ImageGridItem(
                      item: item,
                      showSelectionOverlay: true,
                      selected: selected,
                      onTap: () async {
                        await favorites.toggle(item);
                        setState(() {});
                      },
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCupertinoPage(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        middle: const Text('Add new images'),
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: CupertinoTextField(
                      controller: _controller,
                      placeholder: 'Search images',
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey6,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onSubmitted: (_) => _doSearch(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CupertinoButton.filled(
                    onPressed: _doSearch,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    minSize: 40,
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(CupertinoIcons.search, size: 16),
                        SizedBox(width: 4),
                        Text('Search'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (_loading)
              const Expanded(child: Center(child: CupertinoActivityIndicator()))
            else if (_error != null)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        CupertinoIcons.exclamationmark_circle_fill,
                        size: 48,
                        color: CupertinoColors.systemRed,
                      ),
                      const SizedBox(height: 16),
                      Text(_error!),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GridView.builder(
                    controller: _scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.95,
                        ),
                    itemCount: _results.length + (_loadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == _results.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CupertinoActivityIndicator(),
                          ),
                        );
                      }
                      final item = _results[index];
                      final bool selected = favorites.isFavorite(item.id);
                      return ImageGridItem(
                        item: item,
                        showSelectionOverlay: true,
                        selected: selected,
                        onTap: () {
                          favorites.toggle(item);
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
