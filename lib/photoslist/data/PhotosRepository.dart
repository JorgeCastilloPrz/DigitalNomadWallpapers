import 'dart:async';
import 'dart:convert';

import 'package:digital_nomad_wallpapers/common/models/photo.dart';

import 'memory/PhotosMemoryCache.dart';
import 'network/PhotosApiClient.dart';

class PhotosRepository {
  const PhotosRepository({this.apiClient, this.memoryCache});

  final PhotosApiClient apiClient;
  final PhotosMemoryCache memoryCache;

  Future<List<Photo>> getPhotos() async {
    final cachedPhotos = memoryCache.getAll();
    if (cachedPhotos.isNotEmpty) {
      return cachedPhotos;
    } else {
      return await apiClient.loadPhotos().then(
        (response) {
          final photos = (json.decode(response.body)["photos"] as List)
              .map((data) => new Photo.fromJson(data))
              .toList();
          memoryCache.store(photos);
          return photos;
        },
      ).catchError((error) => throw Exception(error));
    }
  }
}
