import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttrueno_fo827e642a0c4/core/api_handler/failure.dart';
import 'package:ttrueno_fo827e642a0c4/core/api_handler/success.dart';
import 'package:ttrueno_fo827e642a0c4/core/helpers/handle_fold.dart';
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

  @override
  void onInit() {
    super.onInit();
    // fetchNotifications();
  }

  // Future<void> fetchNotifications() async {
  //   isLoading.value = true;
  //   try {
  //     await Future.delayed(const Duration(milliseconds: 1000));

  //     // final response = <Map<String, dynamic>>[
  //     //   {
  //     //     "_id": "6878d95515a5d526008627c6",
  //     //     "user": "687647cad8f4d4d11ac510fa",
  //     //     "type": "join",
  //     //     "ride": "68775eae6bcc46f5d724cdaf",
  //     //     "message": "You have been added to a ride group.",
  //     //     "isRead": false,
  //     //     "expiresAt": "2025-07-24T11:07:01.773Z",
  //     //     "createdAt": "2025-07-17T11:07:01.774Z",
  //     //     "updatedAt": "2025-07-17T11:07:01.774Z",
  //     //   },
  //     //   {
  //     //     "_id": "6878d71415a5d526008627af",
  //     //     "user": "687647cad8f4d4d11ac510fa",
  //     //     "type": "join",
  //     //     "ride": "6878d6ef15a5d5260086278f",
  //     //     "message":
  //     //         "You successfully joined the ride.Your ride has been cancelled.The ride is finished. Please rate your companions.The ride is finished. Please rate your companions.The ride is finished. Please rate your companions.",
  //     //     "isRead": false,
  //     //     "expiresAt": "2025-07-24T10:57:24.541Z",
  //     //     "createdAt": "2025-07-17T10:57:24.542Z",
  //     //     "updatedAt": "2025-07-17T10:57:24.542Z",
  //     //   },
  //     //   {
  //     //     "_id": "6878d54515a5d52600862720",
  //     //     "user": "687647cad8f4d4d11ac510fa",
  //     //     "type": "finish",
  //     //     "ride": "6878d50915a5d5260086270a",
  //     //     "message": "The ride is finished. Please rate your companions.",
  //     //     "isRead": false,
  //     //     "expiresAt": "2025-07-24T10:49:41.284Z",
  //     //     "createdAt": "2025-07-17T10:49:41.285Z",
  //     //     "updatedAt": "2025-07-17T10:49:41.285Z",
  //     //   },
  //     //   {
  //     //     "_id": "1",
  //     //     "user": "user_123",
  //     //     "type": "join",
  //     //     "ride": "ride_001",
  //     //     "message":
  //     //         "You successfully joined the ride.Your ride has been cancelled.The ride is finished. Please rate your companions.The ride is finished. Please rate your companions.The ride is finished. Please rate your companions.",
  //     //     "isRead": false,
  //     //     "expiresAt": "2025-07-24T11:07:01.773Z",
  //     //     "createdAt": "2025-07-17T11:07:01.774Z",
  //     //     "updatedAt": "2025-07-17T11:07:01.774Z",
  //     //   },
  //     //   {
  //     //     "_id": "2",
  //     //     "user": "user_456",
  //     //     "type": "general",
  //     //     "ride": "ride_002",
  //     //     "message":
  //     //         "Your ride has been cancelled.The ride is finished. Please rate your companions.The ride is finished. Please rate your companions.The ride is finished. Please rate your companions.",
  //     //     "isRead": true,
  //     //     "expiresAt": "2025-07-24T10:57:24.541Z",
  //     //     "createdAt": "2025-07-17T10:57:24.542Z",
  //     //     "updatedAt": "2025-07-17T10:57:24.542Z",
  //     //   },
  //     //   {
  //     //     "_id": "3",
  //     //     "user": "user_789",
  //     //     "type": "finish",
  //     //     "ride": "ride_003",
  //     //     "message":
  //     //         "The ride is finished. Please rate your companions.The ride is finished. Please rate your companions.The ride is finished. Please rate your companions.",
  //     //     "isRead": false,
  //     //     "expiresAt": "2025-07-24T10:50:32.729Z",
  //     //     "createdAt": "2025-07-17T10:50:32.730Z",
  //     //     "updatedAt": "2025-07-17T10:50:32.730Z",
  //     //   },
  //     //   {
  //     //     "_id": "4",
  //     //     "user": "user_123",
  //     //     "type": "join",
  //     //     "ride": "ride_004",
  //     //     "message": "You booked a seat in a ride.",
  //     //     "isRead": true,
  //     //     "expiresAt": "2025-07-24T10:49:41.284Z",
  //     //     "createdAt": "2025-07-17T10:49:41.285Z",
  //     //     "updatedAt": "2025-07-17T10:49:41.285Z",
  //     //   },
  //     //   {
  //     //     "_id": "5",
  //     //     "user": "user_456",
  //     //     "type": "general",
  //     //     "ride": "ride_005",
  //     //     "message":
  //     //         "You left the ride.The ride is finished. Please rate your companions.The ride is finished. Please rate your companions.The ride is finished. Please rate your companions.",
  //     //     "isRead": false,
  //     //     "expiresAt": "2025-07-24T10:16:19.792Z",
  //     //     "createdAt": "2025-07-17T10:16:19.792Z",
  //     //     "updatedAt": "2025-07-17T10:16:19.792Z",
  //     //   },
  //     //   {
  //     //     "_id": "6",
  //     //     "user": "user_789",
  //     //     "type": "join",
  //     //     "ride": "ride_006",
  //     //     "message":
  //     //         "You joined a new ride group.You joined a new ride group.You joined a new ride group.You joined a new ride group.You joined a new ride group.",
  //     //     "isRead": true,
  //     //     "expiresAt": "2025-07-24T10:12:09.384Z",
  //     //     "createdAt": "2025-07-17T10:12:09.384Z",
  //     //     "updatedAt": "2025-07-17T10:12:09.384Z",
  //     //   },
  //     //   {
  //     //     "_id": "7",
  //     //     "user": "user_111",
  //     //     "type": "general",
  //     //     "ride": "ride_007",
  //     //     "message":
  //     //         "Your driver is on the way.The ride is finished. Please rate your companions.The ride is finished. Please rate your companions.The ride is finished. Please rate your companions.",
  //     //     "isRead": false,
  //     //     "expiresAt": "2025-07-24T10:11:02.900Z",
  //     //     "createdAt": "2025-07-17T10:11:02.901Z",
  //     //     "updatedAt": "2025-07-17T10:11:02.901Z",
  //     //   },
  //     //   {
  //     //     "_id": "8",
  //     //     "user": "user_222",
  //     //     "type": "join",
  //     //     "ride": "ride_008",
  //     //     "message":
  //     //         "You successfully joined the ride.The ride is finished. Please rate your companions.The ride is finished. Please rate your companions.The ride is finished. Please rate your companions.",
  //     //     "isRead": true,
  //     //     "expiresAt": "2025-07-24T10:05:09.248Z",
  //     //     "createdAt": "2025-07-17T10:05:09.248Z",
  //     //     "updatedAt": "2025-07-17T10:05:09.248Z",
  //     //   },
  //     //   {
  //     //     "_id": "9",
  //     //     "user": "user_333",
  //     //     "type": "general",
  //     //     "ride": "ride_009",
  //     //     "message":
  //     //         "Your payment was successful.The ride is finished. Please rate your companions.The ride is finished. Please rate your companions.The ride is finished. Please rate your companions.",
  //     //     "isRead": false,
  //     //     "expiresAt": "2025-07-24T10:02:18.031Z",
  //     //     "createdAt": "2025-07-17T10:02:18.032Z",
  //     //     "updatedAt": "2025-07-17T10:02:18.032Z",
  //     //   },
  //     //   {
  //     //     "_id": "10",
  //     //     "user": "user_444",
  //     //     "type": "join",
  //     //     "ride": "ride_010",
  //     //     "message":
  //     //         "You joined a premium ride.The ride is finished. Please rate your companions.The ride is finished. Please rate your companions.The ride is finished. Please rate your companions.",
  //     //     "isRead": true,
  //     //     "expiresAt": "2025-07-24T09:29:06.115Z",
  //     //     "createdAt": "2025-07-17T09:29:06.115Z",
  //     //     "updatedAt": "2025-07-17T09:29:06.115Z",
  //     //   },
  //     // ];

  //     notifications.value = response
  //         .map((e) => NotificationModel.fromJson(e))
  //         .toList();
  //   } catch (e, st) {
  //     print('Error fetching notifications: $e\n$st');
  //     notifications.clear();
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

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

  void markAllAsRead() {
    for (var i = 0; i < notifications.length; i++) {
      final n = notifications[i];
      if (!n.isRead) {
        notifications[i] = n.copyWith(isRead: true, updatedAt: DateTime.now());
      }
    }
    notifications.refresh();
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
          notifications.value = data ?? [];
          print("data >> ${data?.length}");
          notifications.refresh();
          update();
        },
      );
    });
    isLoading.value = false;
  }
}
