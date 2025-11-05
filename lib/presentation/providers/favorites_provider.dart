import 'package:flutter/foundation.dart';
import '../../domain/entities/image_item.dart';
import '../../domain/repositories/favorites_repository.dart';

class FavoritesProvider extends ChangeNotifier {
  final FavoritesRepository repository;

  FavoritesProvider(this.repository);

  List<ImageItem> get favorites => repository.getFavorites();

  bool isFavorite(int id) => repository.isFavorite(id);

  Future<void> loadFavorites() async {
    await repository.loadFavorites();
    notifyListeners();
  }

  Future<void> add(ImageItem item) async {
    await repository.addFavorite(item);
    notifyListeners();
  }

  Future<void> removeById(int id) async {
    await repository.removeFavorite(id);
    notifyListeners();
  }

  Future<void> toggle(ImageItem item) async {
    await repository.toggleFavorite(item);
    notifyListeners();
  }

  Future<void> clear() async {
    await repository.clearFavorites();
    notifyListeners();
  }
}


