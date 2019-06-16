import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../photo.dart';

@immutable
class AppState {
  final List<Photo> photos;
  final bool isPhotosListLoading;

  const AppState({
    @required this.photos,
    @required this.isPhotosListLoading
  });

  @override
  String toString() {
    return 'AppState: {photos: $photos}';
  }
}