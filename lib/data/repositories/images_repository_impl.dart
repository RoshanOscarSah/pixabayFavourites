import '../../domain/entities/image_item.dart';
import '../../domain/repositories/images_repository.dart';
import '../../core/errors/failures.dart';
import '../../core/errors/exceptions.dart';
import '../../core/network/network_info.dart';
import '../data_sources/remote_data_source.dart';
import 'package:dartz/dartz.dart';

class ImagesRepositoryImpl implements ImagesRepository {
  final RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ImagesRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<ImageItem>>> searchImages(String query, {int perPage = 20}) async {
    if (await networkInfo.isConnected) {
      try {
        final List<ImageItem> images = await remoteDataSource.searchImages(query, perPage: perPage);
        return Right(images);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure('Unexpected error: ${e.toString()}'));
      }
    } else {
      return const Left(NetworkFailure('No internet connection'));
    }
  }
}

