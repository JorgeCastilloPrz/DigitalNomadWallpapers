import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../photo.dart';

@immutable
class AppState {
  final List<Photo> photos;
  final bool isPhotosListLoading;

  const AppState({@required this.photos, @required this.isPhotosListLoading});

  @override
  String toString() {
    return 'AppState: {photos: $photos}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          ListEquality().equals(photos, other.photos) &&
          isPhotosListLoading == other.isPhotosListLoading;

  @override
  int get hashCode => photos.hashCode ^ isPhotosListLoading.hashCode;
}
