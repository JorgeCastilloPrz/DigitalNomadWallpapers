import 'package:digital_nomad_wallpapers/actions/app_state_actions.dart';
import 'package:redux/redux.dart';

import 'package:digital_nomad_wallpapers/models/photo.dart';

final photosReducer =
    TypedReducer<List<Photo>, UpdatePhotosAction>(_updatePhotosReducer);

List<Photo> _updatePhotosReducer(List<Photo> state, UpdatePhotosAction action) {
  return action.photos;
}
