import 'package:digital_nomad_wallpapers/models/models.dart';
import 'package:digital_nomad_wallpapers/reducers/test_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    photos: photosReducer(state.photos, action),
  );
}
