// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:digital_nomad_wallpapers/main.dart';
import 'package:digital_nomad_wallpapers/models/app_state.dart';
import 'package:digital_nomad_wallpapers/reducers/app_reducer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';

void main() {
  testWidgets('Show loading when building DigitalNomadApp',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final store = Store<AppState>(appReducer,
        initialState: AppState(photos: List(), isPhotosListLoading: false),
        middleware: [new LoggingMiddleware.printer(), thunkMiddleware]);
    await tester
        .pumpWidget(StoreProvider(store: store, child: DigitalNomadApp()));

    // Verify that progress indicator widget is attached
    expect(find.byType(CircularProgressIndicator().runtimeType), findsOneWidget);
  });
}
