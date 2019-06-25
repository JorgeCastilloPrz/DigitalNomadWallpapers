import 'package:meta/meta.dart';

@immutable
class PhotoDetailState {
  final photoUrl;

  const PhotoDetailState({@required this.photoUrl});

  @override
  String toString() {
    return 'DetailState: {photoUrl: $photoUrl}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhotoDetailState &&
          runtimeType == other.runtimeType &&
          photoUrl.equals(other.photoUrl);

  @override
  int get hashCode => photoUrl.hashCode;
}
