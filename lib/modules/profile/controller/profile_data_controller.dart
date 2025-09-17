import 'package:get/get.dart';
import 'package:ttrueno_fo827e642a0c4/auth_routing_controller.dart';
import 'package:ttrueno_fo827e642a0c4/modules/profile/model/user_profile.dart';

import '../../../core/services/app_pigeon/app_pigeon.dart';

class ProfileDataController extends GetxController {
  UserProfile? userProfile;

  Future<void> getCurrentUserProfile() async {
    if(Get.find<AuthRoutingController>().authStatus is Authenticated) {
      // first extract the auth from the auth status (Authenticated)

      // Then call backend api to get the user profile

      // Then do >> userProfile = fetchedProfileData.
    }
  }
}
