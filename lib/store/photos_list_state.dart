import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

import 'package:digital_nomad_wallpapers/models/photo.dart';

@immutable
class PhotosListState {
  final List<Photo> photos;
  final bool isPhotosListLoading;

  const PhotosListState({@required this.photos, @required this.isPhotosListLoading});

  @override
  String toString() {
    return 'AppState: {photos: $photos}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhotosListState &&
          runtimeType == other.runtimeType &&
          ListEquality().equals(photos, other.photos) &&
          isPhotosListLoading == other.isPhotosListLoading;

  @override
  int get hashCode => photos.hashCode ^ isPhotosListLoading.hashCode;
}
