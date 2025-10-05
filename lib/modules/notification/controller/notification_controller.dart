import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttrueno_fo827e642a0c4/core/base/failure.dart';
import 'package:ttrueno_fo827e642a0c4/core/utils/helpers/handle_fold.dart';
import 'package:ttrueno_fo827e642a0c4/core/notifiers/button_status_notifier.dart';
import 'package:ttrueno_fo827e642a0c4/init_dependency.dart';
import 'package:ttrueno_fo827e642a0c4/modules/notification/interface/notification_interface.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  final notifications = <NotificationModel>[].obs;
  final ProcessStatusNotifier processStatusNotifier = ProcessStatusNotifier();

  final isLoading = false.obs;

  NotificationController() {
    getAllNotification();
  }

  Future<bool> markAsRead(int index) async {
    if (index < 0 || index >= notifications.length) return false;

    final old = notifications[index];
    if (old.isRead) return false;

    final lr = await serviceLocator<NotificationInterface>()
        .singleNotificationRead(old.id);

    return lr.fold(
      (error) {
        return false;
      },
      (success) {
        notifications[index] = old.copyWith(
          isRead: true,
          updatedAt: DateTime.now(),
        );
        notifications.refresh();
        return true;
      },
    );
  }
  Future<void> readAllNotification() async {
    final lr = await serviceLocator<NotificationInterface>()
        .allNotificationRead();

    lr.fold(
      (error) {
        debugPrint("error >> ${error.toString()}");
      },
      (success) {
        for (var i = 0; i < notifications.length; i++) {
          final n = notifications[i];
          if (!n.isRead) {
            notifications[i] = n.copyWith(
              isRead: true,
              updatedAt: DateTime.now(),
            );
          }
          notifications.refresh();
          update();
        }
      },
    );
  }

  void toggleExpand(int index) {
    notifications.refresh();
  }

  void markAsReadById(String id) {
    final idx = notifications.indexWhere((n) => n.id == id);
    if (idx != -1) markAsRead(idx);
  }

  Future<void> getAllNotification() async {
    processStatusNotifier.setLoading();
    isLoading.value = true;
    await serviceLocator<NotificationInterface>().getAllNotification().then((
      lr,
    ) {
      handleFold(
        either: lr,
        processStatusNotifier: processStatusNotifier,
        onError: (error) {
          debugPrint("error >> ${error.toString()}");
          if (error.failure == Failure.forbidden) ();
        },
        onSuccess: (data) {
          notifications.value = data;
          print("data >> ${data.length}");
          notifications.refresh();
          update();
        },
      );
    });
    isLoading.value = false;
  }
}
