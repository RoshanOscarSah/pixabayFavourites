import '../entities/image_item.dart';
import '../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ImagesRepository {
  Future<Either<Failure, List<ImageItem>>> searchImages(String query, {int perPage = 20, int page = 1});
}


