import 'package:digital_nomad_wallpapers/common/models/photo.dart';

class PhotosMemoryCache {
  final List<Photo> _photos = List();

  store(List<Photo> photos) {
    this._photos.clear();
    this._photos.addAll(photos);
  }

  List<Photo> getAll() => _photos;
}
