import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:ttrueno_fo827e642a0c4/core/helpers/auth_role.dart';
import 'core/constants/api_endpoints.dart';
import 'core/notifiers/snackbar_notifier.dart';
import 'core/services/app_pigeon/app_pigeon.dart';
import 'core/services/app_services.dart';
import 'init_dependency.dart';
import 'main.dart';
import 'modules/auth/interface/auth_inerface.dart';
import 'routing/route_names.dart';

class AuthRoutingController extends GetxController {
  StreamSubscription? _authStreamSubscription;

  AuthRoutingController() {
    _init();
  }

  _init() {
    debugPrint("listening to auth stream");
    _authStreamSubscription = getAuthStream().listen((authStatus) async{
      debugPrint("(In AuthRoutingController)Auth status: $authStatus");
      if(authStatus != null) {
          _authStatus = authStatus; 
          if(_authStatus is UnAuthenticated) {
            navigatorKey.currentState?.pushNamedAndRemoveUntil(RouteNames.login, (route) => false);
          } else if(_authStatus is Authenticated) {
            await AppServices.appPigeon.socketInit(
              SocketConnetParamX(
                token: null,
                socketUrl: ApiEndpoints.socketUrl,
                joinId: (_authStatus as Authenticated).auth.userId,
              )
            );
            navigatorKey.currentState?.pushNamedAndRemoveUntil(RouteNames.home, (route) => false);
          }
          update();
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
