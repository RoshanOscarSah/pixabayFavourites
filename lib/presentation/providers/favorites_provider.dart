import 'package:flutter/foundation.dart';
import '../../domain/entities/image_item.dart';
import '../../domain/repositories/favorites_repository.dart';

class FavoritesProvider extends ChangeNotifier {
  final FavoritesRepository repository;

  FavoritesProvider(this.repository);

  List<ImageItem> get favorites => repository.getFavorites();

  bool isFavorite(int id) => repository.isFavorite(id);

  void add(ImageItem item) {
    repository.addFavorite(item);
    notifyListeners();
  }

  void removeById(int id) {
    repository.removeFavorite(id);
    notifyListeners();
  }

  void toggle(ImageItem item) {
    repository.toggleFavorite(item);
    notifyListeners();
  }

  void clear() {
    repository.clearFavorites();
    notifyListeners();
  }
}


