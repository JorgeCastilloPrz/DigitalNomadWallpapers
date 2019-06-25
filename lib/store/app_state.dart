import 'package:digital_nomad_wallpapers/store/navigation_state.dart';
import 'package:digital_nomad_wallpapers/store/photo_detail_state.dart';
import 'package:digital_nomad_wallpapers/store/photos_list_state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final PhotosListState photosListState;
  final PhotoDetailState photoDetailState;
  final NavigationState navigationState;

  const AppState(
      {@required this.photosListState,
      @required this.photoDetailState,
      @required this.navigationState});

  @override
  String toString() {
    return 'AppState: {$photosListState\n$photoDetailState\n$navigationState}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          photosListState == other.photosListState &&
          photoDetailState == other.photoDetailState &&
          navigationState == other.navigationState;

  @override
  int get hashCode => photosListState.hashCode ^ navigationState.hashCode;

  factory AppState.initialState() => AppState(
      photosListState:
          PhotosListState(photos: List(), isPhotosListLoading: false),
      photoDetailState: PhotoDetailState(photoUrl: ""),
      navigationState: NavigationState(routes: ["/"]));
}
