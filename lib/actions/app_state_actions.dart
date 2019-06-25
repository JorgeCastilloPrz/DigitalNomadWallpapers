import 'package:digital_nomad_wallpapers/actions/view_state_actions.dart';
import 'package:digital_nomad_wallpapers/di/dependency_graph.dart';
import 'package:digital_nomad_wallpapers/di/middleware_injector.dart';
import 'package:digital_nomad_wallpapers/models/photo.dart';
import 'package:digital_nomad_wallpapers/store/app_state.dart';

class UpdatePhotosAction {
  final List<Photo> photos;

  const UpdatePhotosAction({this.photos});
}

class SelectPhotoAction {
  final String photoUrl;

  const SelectPhotoAction({this.photoUrl});
}

ThunkInjectedAction<DependencyGraph, AppState> fetchPhotosAction() {
  return (deps) => (store) {
        store.dispatch(new TogglePhotosListLoadingAction(isLoading: true));
        deps.photosRepo.getPhotos().then((photos) {
          store.dispatch(new TogglePhotosListLoadingAction(isLoading: false));
          store.dispatch(new UpdatePhotosAction(photos: photos));
        }).catchError((exception) => throw Exception(exception));
      };
}
