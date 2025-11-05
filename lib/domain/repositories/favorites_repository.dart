import '../entities/image_item.dart';

abstract class FavoritesRepository {
  List<ImageItem> getFavorites();
  bool isFavorite(int id);
  void addFavorite(ImageItem item);
  void removeFavorite(int id);
  void toggleFavorite(ImageItem item);
  void clearFavorites();
}


