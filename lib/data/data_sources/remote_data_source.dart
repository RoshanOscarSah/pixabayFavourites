import '../../domain/entities/image_item.dart';
import '../../core/errors/exceptions.dart';
import '../../core/constants/api_constants.dart';
import '../../core/constants/app_constants.dart';
import '../models/image_item_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<List<ImageItem>> searchImages(String query, {int perPage = 20, int page = 1});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl(this.client);

  @override
  Future<List<ImageItem>> searchImages(String query, {int perPage = 20, int page = 1}) async {
    final Uri url = Uri.parse(
      '${ApiConstants.baseUrl}?key=${AppConstants.pixabayApiKey}&q=${Uri.encodeQueryComponent(query)}&image_type=photo&per_page=$perPage&page=$page&safesearch=true',
    );
    
    try {
      final http.Response response = await client.get(url);
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = json.decode(response.body) as Map<String, dynamic>;
        final List<dynamic> hits = jsonBody['hits'] as List<dynamic>;
        return hits
            .map((dynamic e) => ImageItemModel.fromJson(e as Map<String, dynamic>))
            .toList(growable: false);
      } else {
        throw ServerException('Failed to fetch images: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Network error: ${e.toString()}');
    }
  }
}


