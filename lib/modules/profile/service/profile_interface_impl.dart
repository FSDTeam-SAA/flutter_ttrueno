import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:ttrueno_fo827e642a0c4/core/api_handler/failure.dart';
import 'package:ttrueno_fo827e642a0c4/core/api_handler/success.dart';
import 'package:ttrueno_fo827e642a0c4/core/helpers/typedefs.dart';
import 'package:ttrueno_fo827e642a0c4/core/network/api_client.dart';
import 'package:ttrueno_fo827e642a0c4/core/network/api_endpoints.dart';
import 'package:ttrueno_fo827e642a0c4/modules/profile/interface/profile_interface.dart';
import 'package:ttrueno_fo827e642a0c4/modules/profile/model/change_password_param.dart';

import '../../../core/helpers/format_response_data.dart';

final class ProfileInterfaceImpl extends ProfileInterface {
  final ApiClient apiClient;

  ProfileInterfaceImpl(this.apiClient);

  @override
  FutureRequest<Success> changePassword(ChangePassowrdParam params) async {
    return await asyncTryCatch(
      tryFunc: () async {
        debugPrint("ChangePassword Request: ${params.toJson()}");

        final response = await apiClient.post(
          ApiEndpoints.changePassword,
          data: params.toJson(),
        );

        return Success(message: extractSuccessMessage(response));
      },
    );
  }
  
  // @override
  // FutureRequest<Success> resetPassword(ChangePassowrdParam params) {
  //   // TODO: implement resetPassword
  //   throw UnimplementedError();
  // }
}
