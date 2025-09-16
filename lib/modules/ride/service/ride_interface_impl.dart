// import 'package:ttrueno_fo827e642a0c4/core/api_handler/success.dart';
// import 'package:ttrueno_fo827e642a0c4/core/helpers/typedefs.dart';
// import 'package:ttrueno_fo827e642a0c4/modules/ride/interface/ride_interface.dart';
// import 'package:ttrueno_fo827e642a0c4/modules/ride/model/post_ride_model.dart';
// import 'package:ttrueno_fo827e642a0c4/modules/ride/model/ride_model.dart';

// final class RideInterfaceImpl extends RideInterface {
//   @override
//   FutureRequest<Success<RideModel>> createRide(PostRideModel params) {
//     throw UnimplementedError();
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:ttrueno_fo827e642a0c4/core/api_handler/success.dart';
import 'package:ttrueno_fo827e642a0c4/core/helpers/typedefs.dart';
import 'package:ttrueno_fo827e642a0c4/core/constants/api_endpoints.dart';
import 'package:ttrueno_fo827e642a0c4/core/helpers/format_response_data.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride/interface/ride_interface.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride/model/post_ride_model.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride/model/ride_model.dart';

import '../../../core/services/app_pigeon/app_pigeon.dart';

final class RideInterfaceImpl extends RideInterface {
  final AppPigeon apiClient;

  RideInterfaceImpl(this.apiClient);

  @override
  FutureRequest<Success<RideModel>> createRide(PostRideModel params) async {
    return await asyncTryCatch(
      tryFunc: () async {
        debugPrint("Sending ride data: ${params.toJson()}");

        final response = await apiClient.post(
          ApiEndpoints.createRide,
          data: params.toJson(),
        );

        final body = extractBodyData(response);
        debugPrint("Ride created response: $body");

        final ride = RideModel.fromJson(body);

        return Success<RideModel>(
          message: extractSuccessMessage(response),
          data: ride,
        );
      },
    );
  }
}

