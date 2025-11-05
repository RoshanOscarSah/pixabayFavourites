import '../../domain/entities/image_item.dart';

class ImageItemModel extends ImageItem {
  const ImageItemModel({
    required super.id,
    required super.previewURL,
    required super.largeImageURL,
    required super.user,
    required super.imageSizeBytes,
  });

  factory ImageItemModel.fromJson(Map<String, dynamic> json) {
    return ImageItemModel(
      id: json['id'] as int,
      previewURL: json['previewURL'] as String,
      largeImageURL: (json['largeImageURL'] ?? json['webformatURL']) as String,
      user: json['user'] as String,
      imageSizeBytes: json['imageSize'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'previewURL': previewURL,
      'largeImageURL': largeImageURL,
      'user': user,
      'imageSize': imageSizeBytes,
    };
  }
}


