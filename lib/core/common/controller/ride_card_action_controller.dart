import 'package:get/get.dart';
import 'package:ttrueno_fo827e642a0c4/core/utils/helpers/handle_fold.dart';
import 'package:ttrueno_fo827e642a0c4/core/notifiers/button_status_notifier.dart';
import 'package:ttrueno_fo827e642a0c4/init_dependency.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/controller/join_ride_controller.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/interface/ride_interface.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/join_ride_req_param.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/ride_model.dart';

import '../../../modules/profile/controller/profile_data_controller.dart';
import '../../../modules/ride&booking/model/enum/baggage_type_enum.dart';
import '../../../modules/ride&booking/model/enum/status.dart';
import '../../notifiers/snackbar_notifier.dart';
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


  // Future<void> joinRide({
  //   required SnackbarNotifier? snackbarNotifier,
  //   required BaggageType baggageType
  // }) async{
  //   await joinRideController.joinRide(snackbarNotifier: snackbarNotifier);
  // }

}


