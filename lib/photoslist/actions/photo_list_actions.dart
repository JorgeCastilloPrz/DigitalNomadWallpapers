import 'package:digital_nomad_wallpapers/app/store/app_state.dart';
import 'package:digital_nomad_wallpapers/common/models/photo.dart';
import 'package:digital_nomad_wallpapers/di/dependency_graph.dart';
import 'package:digital_nomad_wallpapers/di/middleware_injector.dart';

class TogglePhotosListLoadingAction {
  final bool isLoading;

  const TogglePhotosListLoadingAction({this.isLoading});
}

class UpdatePhotosAction {
  final List<Photo> photos;

  const UpdatePhotosAction({this.photos});
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
