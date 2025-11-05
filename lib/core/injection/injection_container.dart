import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../data/data_sources/remote_data_source.dart';
import '../../data/repositories/images_repository_impl.dart';
import '../../data/repositories/favorites_repository_impl.dart';
import '../../domain/repositories/images_repository.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../../domain/use_cases/search_images_use_case.dart';
import '../../core/network/network_info.dart';
import '../../presentation/providers/favorites_provider.dart';

class InjectionContainer {
  static Future<void> setup() async {
    // Core
    final Connectivity connectivity = Connectivity();
    final NetworkInfo networkInfo = NetworkInfoImpl(connectivity);
    final http.Client httpClient = http.Client();

    // Data sources
    final RemoteDataSource remoteDataSource = RemoteDataSourceImpl(httpClient);

    // Repositories
    final ImagesRepository imagesRepository = ImagesRepositoryImpl(
      remoteDataSource: remoteDataSource,
      networkInfo: networkInfo,
    );
    final FavoritesRepository favoritesRepository = FavoritesRepositoryImpl();

    // Use cases
    final SearchImagesUseCase searchImagesUseCase = SearchImagesUseCase(imagesRepository);

    // Providers
    final FavoritesProvider favoritesProvider = FavoritesProvider(favoritesRepository);

    // Make available globally (could use a DI container like get_it, but Provider is simpler here)
    InjectionContainer._networkInfo = networkInfo;
    InjectionContainer._favoritesProvider = favoritesProvider;
    InjectionContainer._searchImagesUseCase = searchImagesUseCase;
  }

  static NetworkInfo? _networkInfo;
  static FavoritesProvider? _favoritesProvider;
  static SearchImagesUseCase? _searchImagesUseCase;

  static NetworkInfo get networkInfo {
    if (_networkInfo == null) throw Exception('InjectionContainer not initialized');
    return _networkInfo!;
  }

  static FavoritesProvider get favoritesProvider {
    if (_favoritesProvider == null) throw Exception('InjectionContainer not initialized');
    return _favoritesProvider!;
  }

  static SearchImagesUseCase get searchImagesUseCase {
    if (_searchImagesUseCase == null) throw Exception('InjectionContainer not initialized');
    return _searchImagesUseCase!;
  }
}

