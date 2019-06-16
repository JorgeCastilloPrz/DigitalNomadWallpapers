import 'package:digital_nomad_wallpapers/actions/view_state_actions.dart';
import 'package:redux/redux.dart';

final photosListViewStateReducer =
    TypedReducer<bool, TogglePhotosListLoadingAction>(_togglePhotosListLoading);

bool _togglePhotosListLoading(bool state, TogglePhotosListLoadingAction action) {
  return action.isLoading;
}
