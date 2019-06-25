import 'package:digital_nomad_wallpapers/navigation/actions/navigation_actions.dart';
import 'package:digital_nomad_wallpapers/app/store/app_state.dart';
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
              title: Text('Hello world'),
              automaticallyImplyLeading: true),
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
