import 'package:digital_nomad_wallpapers/navigation/actions/navigation_actions.dart';
import 'package:digital_nomad_wallpapers/store/navigation_state.dart';
import 'package:redux/redux.dart';

final navigationReducer = combineReducers<NavigationState>([
  TypedReducer<NavigationState, NavigateReplaceAction>(_navigateReplace),
  TypedReducer<NavigationState, NavigatePushAction>(_navigatePush),
  TypedReducer<NavigationState, NavigatePopAction>(_navigatePop),
]);

NavigationState _navigateReplace(
    NavigationState state, NavigateReplaceAction action) {
  return NavigationState(routes: [action.routeName]);
}

NavigationState _navigatePush(
    NavigationState state, NavigatePushAction action) {
  var result = state.routes;
  result.add(action.routeName);
  return NavigationState(routes: result);
}

NavigationState _navigatePop(NavigationState state, NavigatePopAction action) {
  var result = state.routes;
  if (result.isNotEmpty) {
    result.removeLast();
  }
  return NavigationState(routes: result);
}
