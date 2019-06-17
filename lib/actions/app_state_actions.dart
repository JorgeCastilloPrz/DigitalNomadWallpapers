import 'package:digital_nomad_wallpapers/actions/view_state_actions.dart';
import 'package:digital_nomad_wallpapers/data/PhotosRepository.dart';
import 'package:digital_nomad_wallpapers/models/app_state.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../photo.dart';

class UpdatePhotosAction {
  final List<Photo> photos;

  const UpdatePhotosAction({this.photos});
}

ThunkAction<AppState> fetchPhotosAction([
  PhotosRepository repository = const PhotosRepository(),
]) {
  return (store) {
    store.dispatch(new TogglePhotosListLoadingAction(isLoading: true));
    repository.getPhotos().then((photos) {
      store.dispatch(new TogglePhotosListLoadingAction(isLoading: false));
      store.dispatch(new UpdatePhotosAction(photos: photos));
    }).catchError((exception) => throw Exception(exception));
  };
}
