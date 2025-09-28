import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttrueno_fo827e642a0c4/core/utils/helpers/auth_role.dart';
import 'package:ttrueno_fo827e642a0c4/modules/profile/controller/profile_data_controller.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/controller/search_and_filter_controller.dart';
import 'core/common/controller/inbox_controller.dart';
import 'core/constants/api_endpoints.dart';
import 'core/notifiers/snackbar_notifier.dart';
import 'core/services/app_pigeon/app_pigeon.dart';
import 'init_dependency.dart';
import 'main.dart';
import 'modules/auth/interface/auth_inerface.dart';
import 'modules/ride&booking/controller/my_booking_controller.dart';
import 'routing/route_names.dart';

class AppManager extends GetxController {
  StreamSubscription? _authStreamSubscription;
  /// Initializes the stream to listen to auth status
  AppManager() {
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
            initializeControllers();
            await serviceLocator<AppPigeon>().socketInit(
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

  initializeControllers() {
    if(Get.isRegistered<SearchRideController>()) {
      Get.delete<SearchRideController>();
    }
    if(Get.isRegistered<ProfileDataController>()) {
      Get.delete<ProfileDataController>();
    }
    if(Get.isRegistered<InboxController>()) {
      Get.delete<InboxController>();
    }
    if(Get.isRegistered<MyBookingController>()) {
      Get.delete<MyBookingController>();
    }
    Get.put(SearchRideController());
    Get.put(ProfileDataController());
    Get.put(InboxController());
    Get.put(MyBookingController());
  }

  Stream<AuthStatus?> getAuthStream({SnackbarNotifier? snackbarNotifier}) {
    return serviceLocator<AuthInterface>().authStream();
  }
}
