import 'package:equatable/equatable.dart';

class ImageItem extends Equatable {
  final int id;
  final String previewURL;
  final String largeImageURL;
  final String user;
  final int imageSizeBytes;

  const ImageItem({
    required this.id,
    required this.previewURL,
    required this.largeImageURL,
    required this.user,
    required this.imageSizeBytes,
  });

  @override
  List<Object> get props => [id, previewURL, largeImageURL, user, imageSizeBytes];
}


