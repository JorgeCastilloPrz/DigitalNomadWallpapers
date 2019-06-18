import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';


class InjectedMiddleware<Deps> {

  final Deps deps;

  const InjectedMiddleware({this.deps});

  /// The thunkMiddlewareInjector intercepts and calls [ThunkInjectedAction]s,
  /// which is simply a fancy name for any function that takes 1 argument: The
  /// dependencies to run the program. As soon as those dependencies are passed to
  /// it, it returns a ThunkAction, which is another function that returns a Redux
  /// Store.
  ///
  /// This allows you to dispatch functions (aka [ThunkAction]s) to your Store
  /// that can perform asynchronous work, then dispatch actions using the Store
  /// after the work is complete.
  ///
  /// The cool point is that this version automatically passes dependencies to the
  /// thunk for you, so you can set it whenever you create the Store and pass in
  /// an instance of this middleware, and not anymore.
  ///
  /// The dispatched [ThunkAction]s will be swallowed, meaning they will not go
  /// through the rest of your middleware to the [Store]'s [Reducer].
  void thunkMiddlewareInjector<State>(
      Store<State> store,
      dynamic action,
      NextDispatcher next,
      ) {
    if (action is ThunkInjectedAction<Deps, State>) {
      action(deps)(store);
    } else {
      next(action);
    }
  }
}

/// A function that requires some dependencies to run and returns a ThunkAction.
///
/// ThunkAction is another function that can be dispatched as an action to a
/// Redux [Store] and intercepted by the the [thunkMiddleware]. It can be used
/// to delay the dispatch of an action, or to dispatch only if a certain
/// condition is met.
///
/// The combination of both things ensures we can delay actions that have some
/// required dependencies to run, and assume they'll run just if the
/// dependencies are passed.
///
/// The ThunkFunction receives a [Store], which it can use to get the latest
/// state if need be, or dispatch actions at the appropriate time.
typedef ThunkAction<State> ThunkInjectedAction<Deps, State>(Deps deps);
