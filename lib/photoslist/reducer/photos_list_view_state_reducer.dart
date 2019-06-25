import 'package:digital_nomad_wallpapers/photoslist/actions/photo_list_actions.dart';
import 'package:redux/redux.dart';

final photosListViewStateReducer =
    TypedReducer<bool, TogglePhotosListLoadingAction>(_togglePhotosListLoading);

bool _togglePhotosListLoading(
    bool state, TogglePhotosListLoadingAction action) {
  return action.isLoading;
}
