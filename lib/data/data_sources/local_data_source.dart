import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../../domain/entities/image_item.dart';
import '../models/image_item_model.dart';

abstract class LocalDataSource {
  Future<List<ImageItem>> getFavorites();
  Future<void> saveFavorites(List<ImageItem> favorites);
}

class LocalDataSourceImpl implements LocalDataSource {
  final GetStorage storage;
  static const String _favoritesKey = 'favorites';

  LocalDataSourceImpl(this.storage);

  @override
  Future<List<ImageItem>> getFavorites() async {
    final String? jsonString = storage.read<String>(_favoritesKey);
    if (jsonString == null) {
      return <ImageItem>[];
    }
    try {
      final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
      return jsonList
          .map((dynamic e) => ImageItemModel.fromJson(e as Map<String, dynamic>))
          .toList(growable: false);
    } catch (e) {
      return <ImageItem>[];
    }
  }

  @override
  Future<void> saveFavorites(List<ImageItem> favorites) async {
    final List<Map<String, dynamic>> jsonList =
        favorites.map((ImageItem item) => ImageItemModel(
              id: item.id,
              previewURL: item.previewURL,
              largeImageURL: item.largeImageURL,
              user: item.user,
              imageSizeBytes: item.imageSizeBytes,
            ).toJson()).toList();
    final String jsonString = json.encode(jsonList);
    await storage.write(_favoritesKey, jsonString);
  }
}

