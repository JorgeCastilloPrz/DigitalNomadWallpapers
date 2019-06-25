import 'package:digital_nomad_wallpapers/store/navigation_state.dart';
import 'package:flutter/cupertino.dart';

class TogglePhotosListLoadingAction {
  final bool isLoading;

  const TogglePhotosListLoadingAction({this.isLoading});
}

@immutable
class RouteAction {
  final Screen destinationScreen;

  const RouteAction({@required this.destinationScreen});
}
