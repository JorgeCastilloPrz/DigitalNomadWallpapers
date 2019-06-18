import 'package:digital_nomad_wallpapers/data/network/PhotosApiClient.dart';
import 'package:digital_nomad_wallpapers/photo.dart';
import 'package:http/http.dart';

class StubPhotosApiClient extends PhotosApiClient {
  final List<Photo> photos;

  const StubPhotosApiClient({this.photos});

  @override
  Future<Response> loadPhotos() {
    return Future.value(Response("""{
      "page": 1,
      "per_page": 1,
      "total_results": 1,
      "url": "https://www.pexels.com/search/example%20query/",
      "next_page": "https://api.pexels.com/v1/search/?page=2&per_page=15&query=example+query",
      "photos": [{
        "width": 1000,
        "height": 1000,
        "url": "https://www.pexels.com/photo/12345",
        "photographer": "Name",
        "src": {
          "original": "https://*.jpg",
          "large": "https://*.jpg",
          "large2x": "https://*.jpg",
          "medium": "https://*.jpg",
          "small": "https://*.jpg",
          "portrait": "https://*.jpg",
          "landscape": "https://*.jpg",
          "tiny": "https://*.jpg"
        }}]
      }
   """, 200));
  }
}
