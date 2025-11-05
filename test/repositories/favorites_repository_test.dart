import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pixabay_favorites/data/repositories/favorites_repository_impl.dart';
import 'package:pixabay_favorites/data/data_sources/local_data_source.dart';
import 'package:pixabay_favorites/domain/entities/image_item.dart';

class MockLocalDataSource extends Mock implements LocalDataSource {}

void main() {
  late FavoritesRepositoryImpl repository;
  late MockLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    repository = FavoritesRepositoryImpl(mockLocalDataSource);
  });

  group('FavoritesRepositoryImpl', () {
    final ImageItem testItem1 = const ImageItem(
      id: 1,
      previewURL: 'https://example.com/preview1.jpg',
      largeImageURL: 'https://example.com/large1.jpg',
      user: 'User1',
      imageSizeBytes: 1024,
    );

    final ImageItem testItem2 = const ImageItem(
      id: 2,
      previewURL: 'https://example.com/preview2.jpg',
      largeImageURL: 'https://example.com/large2.jpg',
      user: 'User2',
      imageSizeBytes: 2048,
    );

    test('should return empty list when no favorites are stored', () async {
      when(() => mockLocalDataSource.getFavorites()).thenAnswer((_) async => <ImageItem>[]);
      
      await repository.loadFavorites();
      final List<ImageItem> favorites = repository.getFavorites();
      
      expect(favorites, isEmpty);
      expect(repository.isFavorite(1), isFalse);
    });

    test('should add favorite and save to local storage', () async {
      when(() => mockLocalDataSource.getFavorites()).thenAnswer((_) async => <ImageItem>[]);
      when(() => mockLocalDataSource.saveFavorites(any())).thenAnswer((_) async => {});
      
      await repository.loadFavorites();
      await repository.addFavorite(testItem1);
      
      expect(repository.getFavorites().length, 1);
      expect(repository.isFavorite(1), isTrue);
      expect(repository.getFavorites().first.id, 1);
      
      verify(() => mockLocalDataSource.saveFavorites(any())).called(1);
    });

    test('should remove favorite and save to local storage', () async {
      when(() => mockLocalDataSource.getFavorites()).thenAnswer((_) async => <ImageItem>[]);
      when(() => mockLocalDataSource.saveFavorites(any())).thenAnswer((_) async => {});
      
      await repository.loadFavorites();
      await repository.addFavorite(testItem1);
      await repository.addFavorite(testItem2);
      
      expect(repository.getFavorites().length, 2);
      
      await repository.removeFavorite(1);
      
      expect(repository.getFavorites().length, 1);
      expect(repository.isFavorite(1), isFalse);
      expect(repository.isFavorite(2), isTrue);
      
      verify(() => mockLocalDataSource.saveFavorites(any())).called(greaterThan(1));
    });

    test('should toggle favorite - add when not favorite, remove when favorite', () async {
      when(() => mockLocalDataSource.getFavorites()).thenAnswer((_) async => <ImageItem>[]);
      when(() => mockLocalDataSource.saveFavorites(any())).thenAnswer((_) async => {});
      
      await repository.loadFavorites();
      
      // First toggle should add
      await repository.toggleFavorite(testItem1);
      expect(repository.isFavorite(1), isTrue);
      expect(repository.getFavorites().length, 1);
      
      // Second toggle should remove
      await repository.toggleFavorite(testItem1);
      expect(repository.isFavorite(1), isFalse);
      expect(repository.getFavorites().length, 0);
    });

    test('should clear all favorites and save to local storage', () async {
      when(() => mockLocalDataSource.getFavorites()).thenAnswer((_) async => <ImageItem>[]);
      when(() => mockLocalDataSource.saveFavorites(any())).thenAnswer((_) async => {});
      
      await repository.loadFavorites();
      await repository.addFavorite(testItem1);
      await repository.addFavorite(testItem2);
      
      expect(repository.getFavorites().length, 2);
      
      await repository.clearFavorites();
      
      expect(repository.getFavorites(), isEmpty);
      expect(repository.isFavorite(1), isFalse);
      expect(repository.isFavorite(2), isFalse);
      
      verify(() => mockLocalDataSource.saveFavorites(any())).called(greaterThan(1));
    });
  });
}

