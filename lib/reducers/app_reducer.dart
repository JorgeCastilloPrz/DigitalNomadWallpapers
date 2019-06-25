import 'package:digital_nomad_wallpapers/reducers/photo_detail_reducer.dart';
import 'package:digital_nomad_wallpapers/reducers/photos_list_reducer.dart';
import 'package:digital_nomad_wallpapers/store/app_state.dart';

import 'navigation_reducer.dart';

AppState appReducer(AppState currentState, action) {
  return AppState(
      photosListState: photosListReducer(currentState.photosListState, action),
      photoDetailState:
          photoDetailReducer(currentState.photoDetailState, action),
      navigationState: navigationReducer(currentState.navigationState, action));
}
