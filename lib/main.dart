import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'config/keys.dart';
import 'photo.dart';

void main() => runApp(DigitalNomadApp());

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

  _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    final response = await http.get(
        "https://api.pexels.com/v1/search?query=digital+nomad&per_page=30&page=1",
        headers: {HttpHeaders.authorizationHeader: pexelsApiKey});
    if (response.statusCode == 200) {
      _list = (json.decode(response.body)["photos"] as List)
          .map((data) => new Photo.fromJson(data))
          .toList();
      setState(() {
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Failed to load photos"),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _list.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    title: new Text(_list[index].photographer),
                    trailing: new Image.network(
                      _list[index].large2x,
                      fit: BoxFit.cover,
                      height: 40.0,
                      width: 40.0,
                    ),
                  );
                }));
  }
}
