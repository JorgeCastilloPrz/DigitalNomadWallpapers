import 'dart:convert';
import 'dart:io';

import 'package:digital_nomad_wallpapers/actions/view_state_actions.dart';
import 'package:digital_nomad_wallpapers/config/keys.dart';
import 'package:digital_nomad_wallpapers/models/app_state.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../photo.dart';

class UpdatePhotosAction {
  final List<Photo> photos;

  const UpdatePhotosAction({this.photos});
}

// ThunkAction
ThunkAction<AppState> fetchPhotosThunkAction = (Store<AppState> store) async {
  store.dispatch(new TogglePhotosListLoadingAction(isLoading: true));
  final response = await http.get(
      "https://api.pexels.com/v1/search?query=digital+nomad&per_page=30&page=1",
      headers: {HttpHeaders.authorizationHeader: pexelsApiKey});
  if (response.statusCode == 200) {
    List<Photo> photos = (json.decode(response.body)["photos"] as List)
        .map((data) => new Photo.fromJson(data))
        .toList();

    store.dispatch(new TogglePhotosListLoadingAction(isLoading: false));
    store.dispatch(new UpdatePhotosAction(photos: photos));
  } else {
    throw Exception('Failed to load photos:' + response.body);
  }
};
