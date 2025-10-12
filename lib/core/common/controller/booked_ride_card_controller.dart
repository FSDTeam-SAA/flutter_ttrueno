import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttrueno_fo827e642a0c4/core/notifiers/button_status_notifier.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/controller/kickout_rider_controller.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/controller/leave_ride_controller.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/booking.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/enum/baggage_type_enum.dart';
import '../../../modules/profile/controller/profile_data_controller.dart';
import '../../../modules/ride&booking/controller/change_baggage_controller.dart';
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

    finishRideController = FinishRideController(rideId: booking.ride.id, onFinishRideSuccess: onFinishRideSuccess);
    leaveRideController = LeaveRideController(rideId: booking.ride.id, onLeaveSuccess: onLeaveSuccess);
    joinRideController = JoinRideController(rideId: booking.ride.id, onJoinSuccess: onJoinSuccess);
    changeBaggageController = ChangeBaggageController(bookingId: booking.id, onBaggageChangeSuccess: onBaggageChangeSuccess); 
    kickoutRiderController = KickoutRiderController(rideId: booking.ride.id, onKickSuccess: () {});
    // eligibility to finish, rate-ride
    if(booking.status == Status.active && booking.ride.departureTime.isBefore(DateTime.now())) {
      eligibleToFinish = true;
    }
    if(booking.status == Status.completed) {
      eligibleForRatingRide = true;
      eligibleForChat.value = false;
      eligibleToFinish = false;
    }
    if(booking.ride.departureTime.isAfter(DateTime.now())) {
      eligibleToLeave.value = true;
    }
  }

  final Booking booking;
  final VoidCallback onLeaveSuccess;
  final VoidCallback onFinishRideSuccess;

  RxBool eligibleForChat = RxBool(false);
  RxBool eligibleToLeave = RxBool(false);
  bool eligibleToFinish = false;
  bool eligibleForRatingRide = false;
  RxList<Rider> riders = RxList([]);

  late ProcessStatusNotifier leaveStn = leaveRideController.stn;
  late ProcessStatusNotifier finishRideStn = finishRideController.stn;
  late final FinishRideController finishRideController;
  late final LeaveRideController leaveRideController;
  late final JoinRideController joinRideController;
  late final ChangeBaggageController changeBaggageController;
  late final KickoutRiderController kickoutRiderController;

  Future<void> leaveRide({
    required SnackbarNotifier? snackbarNotifier
  }) async{
    eligibleToLeave.value = booking.ride.departureTime.isAfter(DateTime.now());
    if(eligibleToLeave.value == false) return;
    return await leaveRideController.leaveRide(snackbarNotifier: snackbarNotifier);
  }

  Future<void> finishRide({
    required SnackbarNotifier? snackbarNotifier,
  }) async{
    await finishRideController.finishRide(snackbarNotifier: snackbarNotifier);
  }

  void onJoinSuccess(List<Rider> newRiders) {
    riders.addAll(newRiders);
    eligibleForChat.value = true;
  }

  void onBaggageChangeSuccess(BaggageType baggageType) {
    for(int i = 0; i < riders.length; i++) {
      if(riders[i].userId == Get.find<ProfileDataController>().userProfile.value?.id) {
        riders[i] = riders[i].copyWith(baggageType: baggageType);
      }
    }
    riders.refresh();
  }
}
