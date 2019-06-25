import 'package:digital_nomad_wallpapers/store/app_state.dart';
import 'package:redux/redux.dart';

import '../main.dart';
import 'actions/navigation_actions.dart';

List<Middleware<AppState>> createNavigationMiddleware() {
  return [
    TypedMiddleware<AppState, NavigateReplaceAction>(_navigateReplace),
    TypedMiddleware<AppState, NavigatePushAction>(_navigate),
    TypedMiddleware<AppState, NavigatePopAction>(_navigate)
  ];
}

_navigateReplace(Store<AppState> store, action, NextDispatcher next) {
  final routeName = (action as NavigateReplaceAction).routeName;
  if (store.state.navigationState.routes.last != routeName) {
    navigatorKey.currentState.pushReplacementNamed(routeName);
  }
  next(action); //This need to be after name checks
}

_navigate(Store<AppState> store, action, NextDispatcher next) {
  if (action is NavigatePopAction && navigatorKey.currentState.canPop()) {
    navigatorKey.currentState.pop();
  } else if (action is NavigatePushAction) {
    if (store.state.navigationState.routes.last != action.routeName) {
      navigatorKey.currentState.pushNamed(action.routeName);
    }
  }
  next(action); //This need to be after name checks
}
