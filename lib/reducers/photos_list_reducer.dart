import 'package:digital_nomad_wallpapers/reducers/photos_list_view_state_reducer.dart';
import 'package:digital_nomad_wallpapers/reducers/photos_reducer.dart';
import 'package:digital_nomad_wallpapers/store/photos_list_state.dart';

PhotosListState photosListReducer(PhotosListState state, action) {
  return PhotosListState(
      photos: photosReducer(state.photos, action),
      isPhotosListLoading:
          photosListViewStateReducer(state.isPhotosListLoading, action));
}
