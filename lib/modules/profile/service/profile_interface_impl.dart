import 'package:flutter/foundation.dart';
import 'package:ttrueno_fo827e642a0c4/core/api_handler/success.dart';
import 'package:ttrueno_fo827e642a0c4/core/helpers/typedefs.dart';
import 'package:ttrueno_fo827e642a0c4/core/constants/api_endpoints.dart';
import 'package:ttrueno_fo827e642a0c4/modules/profile/interface/profile_interface.dart';
import 'package:ttrueno_fo827e642a0c4/modules/profile/model/change_password_param.dart';
import 'package:ttrueno_fo827e642a0c4/modules/profile/model/user_profile.dart';

import '../../../core/helpers/format_response_data.dart';
import '../../../core/services/app_pigeon/app_pigeon.dart';

final class ProfileInterfaceImpl extends ProfileInterface {
  final AppPigeon appPigeon;

  ProfileInterfaceImpl(this.appPigeon);

  @override
  FutureRequest<Success> changePassword(ChangePassowrdParam params) async {
    return await asyncTryCatch(
      tryFunc: () async {
        debugPrint("ChangePassword Request: ${params.toJson()}");

        final response = await appPigeon.post(
          ApiEndpoints.changePassword,
          data: params.toJson(),
        );

        return Success(message: extractSuccessMessage(response));
      },
    );
  }

  @override
  FutureRequest<Success<UserProfile>> getUserProfilebyId(String id) async {
    return await asyncTryCatch(
      tryFunc: () async {
        //response
        final response = await appPigeon.get(ApiEndpoints.getuserbyId(id));

        //parse
        final data = response.data["data"] as Map<String, dynamic>;
        final UserProfile userProfile = UserProfile.fromJson(data);

        var message = response.data['message'] as String;


        //return

        return Success(message: message, data: userProfile);

      },
    );
  }

  // @override
  // FutureRequest<Success> resetPassword(ChangePassowrdParam params) {
  //   // TODO: implement resetPassword
  //   throw UnimplementedError();
  // }
}
