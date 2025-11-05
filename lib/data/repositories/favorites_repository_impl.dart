import '../../domain/entities/image_item.dart';
import '../../domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final Map<int, ImageItem> _favorites = <int, ImageItem>{};

  @override
  List<ImageItem> getFavorites() {
    return _favorites.values.toList(growable: false);
  }

  @override
  bool isFavorite(int id) {
    return _favorites.containsKey(id);
  }

  @override
  void addFavorite(ImageItem item) {
    if (!_favorites.containsKey(item.id)) {
      _favorites[item.id] = item;
    }
  }

  @override
  void removeFavorite(int id) {
    _favorites.remove(id);
  }

  @override
  void toggleFavorite(ImageItem item) {
    if (isFavorite(item.id)) {
      removeFavorite(item.id);
    } else {
      addFavorite(item);
    }
  }

  @override
  void clearFavorites() {
    _favorites.clear();
  }
}

