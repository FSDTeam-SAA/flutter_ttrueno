import 'package:ttrueno_fo827e642a0c4/core/api_handler/success.dart';
import 'package:ttrueno_fo827e642a0c4/core/api_handler/trycatch.dart';
import 'package:ttrueno_fo827e642a0c4/core/helpers/typedefs.dart';
import 'package:ttrueno_fo827e642a0c4/modules/notification/model/notification_model.dart';

abstract base class NotificationInterface extends ErrorCatcher {
  FutureRequest<Success<List<NotificationModel>>> getAllNotification(
  );

  FutureRequest<Success> singleNotificationRead(String id);

  FutureRequest<Success> allNotificationRead();
}
