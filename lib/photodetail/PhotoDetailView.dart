import 'package:digital_nomad_wallpapers/actions/view_state_actions.dart';
import 'package:digital_nomad_wallpapers/store/app_state.dart';
import 'package:digital_nomad_wallpapers/store/navigation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class PhotoDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder(builder: (_, Store<AppState> store) {
      return Scaffold(
          body: Stack(
        children: <Widget>[
          new Image.network(
            store.state.photoDetailState.photoUrl,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: true,
              title: Text('Hello world'),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => store.dispatch(
                    RouteAction(destinationScreen: PhotoListScreen())),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.all(32.0),
                child: FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Colors.pink,
                  child: Icon(Icons.file_download, color: Colors.white),
                )),
          ),
        ],
      ));
    });
  }
}
