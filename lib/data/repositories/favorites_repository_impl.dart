import '../../domain/entities/image_item.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../data_sources/local_data_source.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final LocalDataSource localDataSource;
  final Map<int, ImageItem> _favorites = <int, ImageItem>{};
  bool _initialized = false;

  FavoritesRepositoryImpl(this.localDataSource);

  Future<void> _ensureInitialized() async {
    if (!_initialized) {
      final List<ImageItem> favorites = await localDataSource.getFavorites();
      for (final ImageItem item in favorites) {
        _favorites[item.id] = item;
      }
      _initialized = true;
    }
  }

  Future<void> _saveToStorage() async {
    await localDataSource.saveFavorites(_favorites.values.toList(growable: false));
  }

  @override
  List<ImageItem> getFavorites() {
    return _favorites.values.toList(growable: false);
  }

  @override
  bool isFavorite(int id) {
    return _favorites.containsKey(id);
  }

  @override
  Future<void> addFavorite(ImageItem item) async {
    await _ensureInitialized();
    if (!_favorites.containsKey(item.id)) {
      _favorites[item.id] = item;
      await _saveToStorage();
    }
  }

  @override
  Future<void> removeFavorite(int id) async {
    await _ensureInitialized();
    if (_favorites.remove(id) != null) {
      await _saveToStorage();
    }
  }

  @override
  Future<void> toggleFavorite(ImageItem item) async {
    await _ensureInitialized();
    if (isFavorite(item.id)) {
      await removeFavorite(item.id);
    } else {
      await addFavorite(item);
    }
  }

  @override
  Future<void> clearFavorites() async {
    await _ensureInitialized();
    _favorites.clear();
    await _saveToStorage();
  }

  Future<void> loadFavorites() async {
    await _ensureInitialized();
  }
}

