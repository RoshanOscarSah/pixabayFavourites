import '../entities/image_item.dart';
import '../repositories/images_repository.dart';
import '../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

class SearchImagesUseCase {
  final ImagesRepository repository;

  SearchImagesUseCase(this.repository);

  Future<Either<Failure, List<ImageItem>>> call(String query, {int perPage = 20}) {
    return repository.searchImages(query, perPage: perPage);
  }
}


