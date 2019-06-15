import 'dart:convert';
import 'dart:io';

import 'package:digital_nomad_wallpapers/actions/actions.dart';
import 'package:digital_nomad_wallpapers/models/models.dart';
import 'package:digital_nomad_wallpapers/reducers/app_reducer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'config/keys.dart';
import 'photo.dart';

void main() {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState(photos: List()),
  );

  print('Initial state: ${store.state}');

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
  List<Photo> _list = List();
  var _isLoading = true;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _isLoading = true;
    });
    StoreProvider.of<AppState>(context).dispatch(LoadPhotosAction());
    setState(() {
      _isLoading = false;
    });

    return Scaffold(
        appBar: AppBar(
          title: Text("Digital Nomad Wallpapers"),
        ),
        backgroundColor: Colors.black,
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.all(2.0),
                child: GridView.builder(
                  itemCount: _list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.all(1.0),
                      child: new Image.network(
                        _list[index].large,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: 0.6),
                )));
  }
}
