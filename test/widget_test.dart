// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:digital_nomad_wallpapers/data/PhotosRepository.dart';
import 'package:digital_nomad_wallpapers/data/memory/PhotosMemoryCache.dart';
import 'package:digital_nomad_wallpapers/di/dependency_graph.dart';
import 'package:digital_nomad_wallpapers/di/middleware_injector.dart';
import 'package:digital_nomad_wallpapers/main.dart';
import 'package:digital_nomad_wallpapers/reducers/app_reducer.dart';
import 'package:digital_nomad_wallpapers/store/app_state.dart';
import 'package:digital_nomad_wallpapers/store/navigation_state.dart';
import 'package:digital_nomad_wallpapers/store/photos_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

import 'StubPhotosApiClient.dart';

void main() {
  testWidgets('Show loading when building DigitalNomadApp',
          (WidgetTester tester) async {
        final middleWare = InjectedMiddleware<DependencyGraph>(
            deps: DependencyGraph(
                photosRepo: PhotosRepository(
                    apiClient: StubPhotosApiClient(),
                    memoryCache: PhotosMemoryCache())));

        final store = Store<AppState>(appReducer,
            initialState: AppState(
                photosListState:
                PhotosListState(photos: List(), isPhotosListLoading: false),
                navigationState: NavigationState(routes: ["/"])),
            middleware: [
              new LoggingMiddleware.printer(),
              middleWare.thunkMiddlewareInjector
            ]);
        await tester
            .pumpWidget(StoreProvider(store: store, child: DigitalNomadApp()));

        // Verify that progress indicator widget is attached
        expect(
            find.byType(CircularProgressIndicator().runtimeType),
            findsOneWidget);
      });
}
