import 'dart:async';
import 'dart:convert';

import 'package:digital_nomad_wallpapers/photo.dart';

import 'network/PhotosApiClient.dart';

class PhotosRepository {
  const PhotosRepository({this.client});

  final PhotosApiClient client;

  Future<List<Photo>> getPhotos() async {
    return await client.loadPhotos().then(
      (response) {
        final photos = (json.decode(response.body)["photos"] as List)
            .map((data) => new Photo.fromJson(data))
            .toList();
        return photos;
      },
    ).catchError((error) => throw Exception(error));
  }
}
