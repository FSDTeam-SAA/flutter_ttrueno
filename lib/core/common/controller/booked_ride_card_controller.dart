import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttrueno_fo827e642a0c4/core/notifiers/button_status_notifier.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/controller/leave_ride_controller.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/booking.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/ride_model.dart';

import '../../../modules/profile/controller/profile_data_controller.dart';
import '../../../modules/ride&booking/controller/finish_ride_controller.dart';
import '../../../modules/ride&booking/controller/join_ride_controller.dart';
import '../../../modules/ride&booking/model/enum/status.dart';
import '../../notifiers/snackbar_notifier.dart';
import '../model/rider.dart';

class BookedRideCardActionController {
  BookedRideCardActionController({required this.booking, required this.onLeaveSuccess, required this.onFinishRideSuccess}) {
    final String currentUserId = Get.find<ProfileDataController>().userProfile.value?.id ?? "";
    for(final rider in booking.ride.participants){
      if(rider.userId == currentUserId) eligibleForChat.value = true;
      riders.add(rider);
    }
    finishRideController = FinishRideController(rideId: booking.id, onFinishRideSuccess: onFinishRideSuccess);
    leaveRideController = LeaveRideController(rideId: booking.id, onLeaveSuccess: onLeaveSuccess);
    joinRideController = JoinRideController(rideId: booking.id, onJoinSuccess: onJoinSuccess);
    // eligibility to finish, rate-ride
    if(booking.status == Status.active) {
      eligibleToFinish = true;
      eligibleForChat.value = true;
    }
    if(booking.status == Status.completed) {
      eligibleForRatingRide = true;
      eligibleForChat.value = false;
      eligibleToFinish = false;
    }
  }

  final Booking booking;
  final VoidCallback onLeaveSuccess;
  final VoidCallback onFinishRideSuccess;

  RxBool eligibleForChat = RxBool(false);
  bool eligibleToFinish = false;
  bool eligibleForRatingRide = false;
  RxList<Rider> riders = RxList([]);

  late ProcessStatusNotifier leaveStn = leaveRideController.stn;
  late ProcessStatusNotifier finishRideStn = finishRideController.stn;
  late final FinishRideController finishRideController;
  late final LeaveRideController leaveRideController;
  late final JoinRideController joinRideController;

  Future<void> leaveRide({
    required SnackbarNotifier? snackbarNotifier
  }) async{
    leaveRideController.leaveRide(snackbarNotifier: snackbarNotifier);
  }

  Future<void> finishRide({
    required SnackbarNotifier? snackbarNotifier,
  }) async{
    finishRideController.finishRide(snackbarNotifier: snackbarNotifier);
  }

  void onJoinSuccess(Rider rider) {
    riders.add(rider);
    eligibleForChat.value = true;
  }

}


