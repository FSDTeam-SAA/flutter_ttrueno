import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttrueno_fo827e642a0c4/core/notifiers/button_status_notifier.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/controller/leave_ride_controller.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/ride_model.dart';

import '../../../modules/profile/controller/profile_data_controller.dart';
import '../../../modules/ride&booking/controller/finish_ride_controller.dart';
import '../../../modules/ride&booking/model/enum/status.dart';
import '../../notifiers/snackbar_notifier.dart';
import '../model/rider.dart';

class BookedRideCardActionController {
  BookedRideCardActionController({required this.ride, required this.onLeaveSuccess, required this.onFinishRideSuccess}) {
    final String currentUserId = Get.find<ProfileDataController>().userProfile.value?.id ?? "";
    for(final rider in ride.participants){
      if(rider.userId == currentUserId) eligibleForChat.value = true;
      riders.add(rider);
    }
    finishRideController = FinishRideController(rideId: ride.id, onFinishRideSuccess: onFinishRideSuccess);
    leaveRideController = LeaveRideController(rideId: ride.id, onLeaveSuccess: onLeaveSuccess);
    // eligibility to finish, rate-ride
    if(currentUserId == ride.creator?.id) {
      eligibleToFinish = true;
    }
    if(ride.status == Status.completed) {
      eligibleForRatingRide = true;
    }
  }

  final RideModel ride;
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

}


