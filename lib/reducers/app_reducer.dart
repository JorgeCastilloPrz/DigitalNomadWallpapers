import 'package:digital_nomad_wallpapers/models/models.dart';
import 'package:digital_nomad_wallpapers/reducers/photos_list_view_state_reducer.dart';
import 'package:digital_nomad_wallpapers/reducers/photos_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
      photos: photosReducer(state.photos, action),
      isPhotosListLoading:
          photosListViewStateReducer(state.isPhotosListLoading, action));
}
