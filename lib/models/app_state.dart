import 'package:meta/meta.dart';

import '../photo.dart';

@immutable
class AppState {
  final List<Photo> photos;

  const AppState({
    @required this.photos,
  });

  @override
  String toString() {
    return 'AppState: {photos: $photos}';
  }
}