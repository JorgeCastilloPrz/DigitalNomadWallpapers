import 'package:digital_nomad_wallpapers/actions/app_state_actions.dart';
import 'package:digital_nomad_wallpapers/common/view/ProgressLoader.dart';
import 'package:digital_nomad_wallpapers/models/photo.dart';
import 'package:digital_nomad_wallpapers/navigation/actions/navigation_actions.dart';
import 'package:digital_nomad_wallpapers/navigation/routes/app_routes.dart';
import 'package:digital_nomad_wallpapers/store/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

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
            converter: (store) =>
                store.state.photosListState.isPhotosListLoading,
            onInit: (store) {
              store.dispatch(fetchPhotosAction());
            },
            distinct: true,
            builder: (_, isLoading) {
              return isLoading
                  ? ProgressLoader()
                  : Padding(
                      padding: EdgeInsets.all(2.0),
                      child: StoreConnector<AppState, List<Photo>>(
                        converter: (store) =>
                            store.state.photosListState.photos,
                        builder: (_, photos) {
                          return GridView.builder(
                            itemCount: photos.length,
                            itemBuilder: (BuildContext context, int index) {
                              final photoUrl = photos[index].portrait;
                              return StoreBuilder(
                                  builder: (_, Store<AppState> store) {
                                return InkWell(
                                    onTap: () {
                                      store.dispatch(SelectPhotoAction(
                                          photoUrl: photoUrl));
                                      store.dispatch(
                                          NavigatePushAction(AppRoutes.detail));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: new Image.network(
                                        photoUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    ));
                              });
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
