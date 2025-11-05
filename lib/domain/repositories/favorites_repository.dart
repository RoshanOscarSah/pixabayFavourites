import '../entities/image_item.dart';

abstract class FavoritesRepository {
  List<ImageItem> getFavorites();
  bool isFavorite(int id);
  Future<void> addFavorite(ImageItem item);
  Future<void> removeFavorite(int id);
  Future<void> toggleFavorite(ImageItem item);
  Future<void> clearFavorites();
  Future<void> loadFavorites();
}


