import 'package:digital_nomad_wallpapers/actions/app_state_actions.dart';
import 'package:digital_nomad_wallpapers/data/network/PhotosApiClient.dart';
import 'package:digital_nomad_wallpapers/di/dependency_graph.dart';
import 'package:digital_nomad_wallpapers/di/middleware_injector.dart';
import 'package:digital_nomad_wallpapers/reducers/app_reducer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

import 'data/PhotosRepository.dart';
import 'detail/PhotoDetail.dart';
import 'models/app_state.dart';
import 'photo.dart';

void main() {
  final middleWare = InjectedMiddleware<DependencyGraph>(
      deps: DependencyGraph(
          photosRepo: PhotosRepository(client: PhotosApiClient())));

  final store = Store<AppState>(appReducer,
      initialState: AppState(photos: List(), isPhotosListLoading: false),
      middleware: [
        new LoggingMiddleware.printer(),
        middleWare.thunkMiddlewareInjector
      ]);

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Digital Nomad Wallpapers"),
        ),
        backgroundColor: Colors.black,
        body: StoreConnector<AppState, bool>(
            converter: (store) => store.state.isPhotosListLoading,
            onInit: (store) {
              store.dispatch(fetchPhotosAction());
            },
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
                              final photoUrl = photos[index].portrait;
                              return InkWell(
                                  onTap: () => _routeToPhotoDetail(photoUrl),
                                  child: Padding(
                                    padding: EdgeInsets.all(1.0),
                                    child: new Image.network(
                                      photoUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ));
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, childAspectRatio: 0.6),
                          );
                        },
                      ));
            }));
  }

  _routeToPhotoDetail(String photoUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoDetail(photoUrl: photoUrl),
      ),
    );
  }
}
