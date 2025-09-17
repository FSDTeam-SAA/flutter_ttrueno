import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:ttrueno_fo827e642a0c4/auth_routing_controller.dart';
import 'package:ttrueno_fo827e642a0c4/core/helpers/auth_role.dart';
import 'package:ttrueno_fo827e642a0c4/init_dependency.dart';
import 'package:ttrueno_fo827e642a0c4/modules/profile/interface/profile_interface.dart';
import 'package:ttrueno_fo827e642a0c4/modules/profile/model/user_profile.dart';

import '../../../core/api_handler/failure.dart';
import '../../../core/api_handler/success.dart';
import '../../../core/services/app_pigeon/app_pigeon.dart';

class ProfileDataController extends GetxController {
  Rx <UserProfile?> userProfile = Rx<UserProfile?>(null);
  
  Future<void> getCurrentUserProfile() async {
    if (Get.find<AuthRoutingController>().authStatus is Authenticated) {
      // first extract the auth from the auth status (Authenticated)
      final auth =
          (Get.find<AuthRoutingController>().authStatus as Authenticated).auth;

      final userid = auth.userId;

      // Then call backend api to get the user profile

      Either<DataCRUDFailure, Success<UserProfile>> lr =
          await serviceLocator<ProfileInterface>().getUserProfilebyId(userid);

      // Then do >> userProfile = fetchedProfileData.

      lr.fold((failure) {}, (success) {
        userProfile.value = success.data;
      });
    }
  }
}
