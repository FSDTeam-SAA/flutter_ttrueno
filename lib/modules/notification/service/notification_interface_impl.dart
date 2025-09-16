import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:ttrueno_fo827e642a0c4/core/api_handler/success.dart';
import 'package:ttrueno_fo827e642a0c4/core/helpers/format_response_data.dart';
import 'package:ttrueno_fo827e642a0c4/core/helpers/typedefs.dart';
import 'package:ttrueno_fo827e642a0c4/core/constants/api_endpoints.dart';
import 'package:ttrueno_fo827e642a0c4/modules/notification/interface/notification_interface.dart';
import 'package:ttrueno_fo827e642a0c4/modules/notification/model/notification_model.dart';

import '../../../core/services/app_pigeon/app_pigeon.dart';

final class NotificationInterfaceImpl extends NotificationInterface {
  final AppPigeon apiClient;

  NotificationInterfaceImpl(this.apiClient);

  @override
  FutureRequest<Success<List<NotificationModel>>> getAllNotification() async {
    return await asyncTryCatch(
      tryFunc: () async {
        final Response response = await apiClient.get(
          ApiEndpoints.getUserNotifications,
        );
        debugPrint("response >> ${response.data}");
        // parse
        final data = response.data["data"] as List<dynamic>;
        final List<NotificationModel> notifications = [];

        for (int i = 0; i < data.length; i++) {
          notifications.add(NotificationModel.fromJson(data[i]));
        }
        // return
        return Success(
          message: extractSuccessMessage(response),
          data: notifications,
        );
      },
    );
  }
}
