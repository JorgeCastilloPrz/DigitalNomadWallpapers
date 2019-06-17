import 'package:digital_nomad_wallpapers/actions/app_state_actions.dart';
import 'package:digital_nomad_wallpapers/models/models.dart';
import 'package:digital_nomad_wallpapers/reducers/app_reducer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'photo.dart';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState(photos: List(), isPhotosListLoading: false),
      middleware: [new LoggingMiddleware.printer(), thunkMiddleware]);

  runApp(StoreProvider(store: store, child: DigitalNomadApp()));
}

class DigitalNomadApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Nomad Wallpapers',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PhotoList(),
    );
  }
}

class PhotoList extends StatefulWidget {
  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  void loadPhotos() {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    store.dispatch(fetchPhotosThunkAction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Digital Nomad Wallpapers"),
        ),
        backgroundColor: Colors.black,
        body: StoreConnector<AppState, bool>(
            converter: (store) => store.state.isPhotosListLoading,
            onInit: (store) => loadPhotos(),
            distinct: true,
            builder: (_, isLoading) {
              return isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: EdgeInsets.all(2.0),
                      child: StoreConnector<AppState, List<Photo>>(
                        converter: (store) => store.state.photos,
                        builder: (_, photos) {
                          return GridView.builder(
                            itemCount: photos.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.all(1.0),
                                child: new Image.network(
                                  photos[index].large,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, childAspectRatio: 0.6),
                          );
                        },
                      ));
            }));
  }
}
