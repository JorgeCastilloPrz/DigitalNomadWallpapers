import 'package:digital_nomad_wallpapers/data/memory/PhotosMemoryCache.dart';
import 'package:digital_nomad_wallpapers/data/network/PhotosApiClient.dart';
import 'package:digital_nomad_wallpapers/di/dependency_graph.dart';
import 'package:digital_nomad_wallpapers/di/middleware_injector.dart';
import 'package:digital_nomad_wallpapers/navigation/navigation_middleware.dart';
import 'package:digital_nomad_wallpapers/navigation/routes/app_routes.dart';
import 'package:digital_nomad_wallpapers/navigation/routes/page_routes.dart';
import 'package:digital_nomad_wallpapers/photodetail/PhotoDetailView.dart';
import 'package:digital_nomad_wallpapers/photoslist/PhotosListView.dart';
import 'package:digital_nomad_wallpapers/reducers/app_reducer.dart';
import 'package:digital_nomad_wallpapers/store/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

import 'data/PhotosRepository.dart';
import 'navigation/route_widgets.dart';

void main() {
  final middleWare = InjectedMiddleware<DependencyGraph>(
      deps: DependencyGraph(
          photosRepo: PhotosRepository(
              apiClient: PhotosApiClient(), memoryCache: PhotosMemoryCache())));

  final store = Store<AppState>(appReducer,
      initialState: AppState.initialState(),
      middleware: [
        new LoggingMiddleware.printer(),
        middleWare.thunkMiddlewareInjector,
        ...createNavigationMiddleware()
      ]);

  runApp(StoreProvider(store: store, child: DigitalNomadApp()));
}

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class DigitalNomadApp extends StatelessWidget {
  MaterialPageRoute _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MainRoute(PhotoList(), settings: settings);
      case AppRoutes.detail:
        return DetailRoute(PhotoDetail(), settings: settings);
      default:
        return MainRoute(PhotoList(), settings: settings);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      navigatorObservers: [routeObserver],
      title: 'Digital Nomad Wallpapers',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (RouteSettings settings) => _getRoute(settings),
    );
  }
}
