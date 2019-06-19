import 'package:flutter/material.dart';

class PhotoDetail extends StatelessWidget {
  final String photoUrl;

  const PhotoDetail({this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        new Image.network(
          photoUrl,
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
              onPressed: () => Navigator.pop(context, false),
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
  }
}
