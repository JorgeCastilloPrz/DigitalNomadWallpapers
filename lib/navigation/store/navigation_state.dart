import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

@immutable
class NavigationState {
  final List<String> routes;

  const NavigationState({@required this.routes});

  @override
  String toString() {
    return 'NavigationState: {State routes: ${routes.toString()}}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NavigationState &&
          runtimeType == other.runtimeType &&
          ListEquality().equals(routes, other.routes);

  @override
  int get hashCode => routes.hashCode;
}

abstract class Screen {
  T fold<T>(T Function(PhotoListScreen) onPhotoListScreen,
      T Function(DetailScreen) onDetailScreen) {
    if (this is PhotoListScreen) {
      return onPhotoListScreen(this);
    }
    if (this is DetailScreen) {
      return onDetailScreen(this);
    }
    throw Exception('Invalid Screen');
  }
}

class PhotoListScreen extends Screen {}

class DetailScreen extends Screen {
  final String photoUrl;

  DetailScreen({@required this.photoUrl});
}
