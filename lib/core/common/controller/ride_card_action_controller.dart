import 'package:get/get.dart';
import 'package:ttrueno_fo827e642a0c4/core/notifiers/button_status_notifier.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/controller/change_baggage_controller.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/controller/join_ride_controller.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/ride_model.dart';

import '../../../modules/profile/controller/profile_data_controller.dart';
import '../../../modules/ride&booking/model/enum/status.dart';
import '../model/rider.dart';

class RideCardActionController {
  RideCardActionController({required this.ride}){
    final String currentUserId = Get.find<ProfileDataController>().userProfile.value?.id ?? "";
    for(final rider in ride.participants){
      if(rider.userId == currentUserId) eligibleForChat.value = true;
      riders.add(rider);
    }
    joinRideController = JoinRideController(rideId: ride.id, onJoinSuccess: (newRiders) {
      riders.addAll(newRiders);
    },);
    changeBaggageController = ChangeBaggageController(bookingId: ride.id, onBaggageChangeSuccess: (changedBaggage) {
      for(int i = 0; i < riders.length; i++) {
        if(riders[i].userId == currentUserId) {
          riders[i] = riders[i].copyWith(baggageType: changedBaggage);
        }
      }
      riders.refresh();
    },); 
    // eligibility to finish, rate-ride
    if(currentUserId == ride.creator?.id) {
      eligibleToFinish = true;
    }
    if(ride.status == Status.completed) {
      eligibleForRatingRide = true;
    }
  }

  final RideModel ride;

  RxBool eligibleForChat = RxBool(false);
  bool eligibleToFinish = false;
  bool eligibleForRatingRide = false;
  RxList<Rider> riders = RxList([]);

  ProcessStatusNotifier joinRideStn = ProcessStatusNotifier(initialStatus: EnabledStatus());
  late final JoinRideController joinRideController;
  late final ChangeBaggageController changeBaggageController;

  // Future<void> joinRide({
  //   required SnackbarNotifier? snackbarNotifier,
  //   required BaggageType baggageType
  // }) async{
  //   await joinRideController.joinRide(snackbarNotifier: snackbarNotifier);
  // }

}


