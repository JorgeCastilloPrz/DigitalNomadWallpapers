import 'package:digital_nomad_wallpapers/actions/app_state_actions.dart';
import 'package:digital_nomad_wallpapers/actions/view_state_actions.dart';
import 'package:digital_nomad_wallpapers/models/models.dart';
import 'package:digital_nomad_wallpapers/reducers/photos_list_view_state_reducer.dart';
import 'package:digital_nomad_wallpapers/reducers/photos_reducer.dart';

AppState appReducer(AppState state, action) {
  switch (action.runtimeType) {
    case UpdatePhotosAction:
      return AppState(
          photos: photosReducer(state.photos, action),
          isPhotosListLoading: state.isPhotosListLoading);
      break;
    case TogglePhotosListLoadingAction:
      return AppState(
          photos: state.photos,
          isPhotosListLoading:
              photosListViewStateReducer(state.isPhotosListLoading, action));
      break;
    default:
      return state;
  }
}
