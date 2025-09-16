import 'dart:async';
import 'package:flutter/material.dart';
import 'core/notifiers/snackbar_notifier.dart';
import 'core/services/app_pigeon/app_pigeon.dart';
import 'init_dependency.dart';
import 'main.dart';
import 'modules/auth/interface/auth_inerface.dart';
import 'routing/route_names.dart';

class AuthRoutingController extends ChangeNotifier {
  StreamSubscription? _authStreamSubscription;

  AuthRoutingController() {
    _init();
  }

  _init() {
    debugPrint("listening to auth stream");
    _authStreamSubscription = getAuthStream().listen((authStatus) {
      debugPrint("(In AuthRoutingController)Auth status: $authStatus");
      if (authStatus != null) {
        _authStatus = authStatus;
        if (_authStatus is UnAuthenticated) {
          debugPrint("Navigating to login");
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            RouteNames.login,
            (route) => false,
          );
        } else if (_authStatus is Authenticated) {
          debugPrint("Navigating to home");
          navigatorKey.currentState?.pushNamedAndRemoveUntil(
            RouteNames.home,
            (route) => false,
          );
        }
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _authStreamSubscription?.cancel();
    super.dispose();
  }

  AuthStatus _authStatus = AuthLoading();
  AuthStatus get authStatus => _authStatus;

  Stream<AuthStatus?> getAuthStream({SnackbarNotifier? snackbarNotifier}) {
    return serviceLocator<AuthInterface>().authStream();
  }
}
