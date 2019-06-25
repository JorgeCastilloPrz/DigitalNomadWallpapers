import 'package:digital_nomad_wallpapers/photodetail/reducer/photo_detail_reducer.dart';
import 'package:digital_nomad_wallpapers/photoslist/reducer/photos_list_reducer.dart';
import 'package:digital_nomad_wallpapers/app/store/app_state.dart';

import 'package:digital_nomad_wallpapers/navigation/reducer/navigation_reducer.dart';

AppState appReducer(AppState currentState, action) {
  return AppState(
      photosListState: photosListReducer(currentState.photosListState, action),
      photoDetailState:
          photoDetailReducer(currentState.photoDetailState, action),
      navigationState: navigationReducer(currentState.navigationState, action));
}
