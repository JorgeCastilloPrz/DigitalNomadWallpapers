import 'package:digital_nomad_wallpapers/common/models/photo.dart';
import 'package:digital_nomad_wallpapers/photoslist/actions/photo_list_actions.dart';
import 'package:redux/redux.dart';

final photosReducer =
    TypedReducer<List<Photo>, UpdatePhotosAction>(_updatePhotosReducer);

List<Photo> _updatePhotosReducer(List<Photo> state, UpdatePhotosAction action) {
  return action.photos;
}
