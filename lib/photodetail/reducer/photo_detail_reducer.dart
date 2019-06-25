import 'package:digital_nomad_wallpapers/photodetail/actions/photo_detail_actions.dart';
import 'package:digital_nomad_wallpapers/photodetail/store/photo_detail_state.dart';
import 'package:redux/redux.dart';

final photoDetailReducer =
    TypedReducer<PhotoDetailState, SelectPhotoAction>(_photoDetailReducer);

PhotoDetailState _photoDetailReducer(
    PhotoDetailState state, SelectPhotoAction action) {
  return PhotoDetailState(photoUrl: action.photoUrl);
}
