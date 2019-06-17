import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:digital_nomad_wallpapers/config/keys.dart';
import 'package:http/http.dart' as http;

class PhotosApiClient {
  const PhotosApiClient();

  Future<dynamic> loadPhotos() async {
    return await http.Client().get(
        "https://api.pexels.com/v1/search?query=digital+nomad&per_page=30&page=1",
        headers: {HttpHeaders.authorizationHeader: pexelsApiKey});
  }
}
