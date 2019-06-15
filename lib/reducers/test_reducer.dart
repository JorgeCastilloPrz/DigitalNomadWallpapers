import 'dart:convert';
import 'dart:io';

import 'package:digital_nomad_wallpapers/actions/actions.dart';
import 'package:digital_nomad_wallpapers/config/keys.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';

import '../photo.dart';

final photosReducer = TypedReducer<List<Photo>, LoadPhotosAction>(_loadPhotosReducer);

List<Photo> _loadPhotosReducer(List<Photo> state, LoadPhotosAction action) {
  return fetchPhotos();
}

fetchPhotos() async {
  final response = await http.get(
      "https://api.pexels.com/v1/search?query=digital+nomad&per_page=30&page=1",
      headers: {HttpHeaders.authorizationHeader: pexelsApiKey});
  if (response.statusCode == 200) {
    return (json.decode(response.body)["photos"] as List)
        .map((data) => new Photo.fromJson(data))
        .toList();
  } else {
    throw Exception('Failed to load photos:' + response.body);
  }
}
