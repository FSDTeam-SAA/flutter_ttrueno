import 'package:get/get.dart';
import 'package:ttrueno_fo827e642a0c4/core/helpers/handle_fold.dart';
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
    joinRideController = JoinRideController(rideId: ride.id, onJoinSuccess: (rider) {
      riders.add(rider);
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

  ProcessStatusNotifier leaveStn = ProcessStatusNotifier(initialStatus: EnabledStatus());
  ProcessStatusNotifier joinRideStn = ProcessStatusNotifier(initialStatus: EnabledStatus());
  ProcessStatusNotifier finishRideStn = ProcessStatusNotifier(initialStatus: EnabledStatus());
  late final JoinRideController joinRideController;
  
  Future<void> leaveRide({
    required SnackbarNotifier? snackbarNotifier
  }) async{
    leaveStn.setLoading();
    await serviceLocator<RideInterface>().leaveRide(rideId: ride.id).then((lr){
      handleFold(
        either: lr,
        processStatusNotifier: leaveStn,
        errorSnackbarNotifier: snackbarNotifier,
        onSuccess: (data) {
          final index = riders.indexWhere((element) => element.userId == Get.find<ProfileDataController>().userProfile.value?.id);
          if(index >= 0) riders.removeAt(index);
          final index2 = ride.participants.indexWhere((element) => element.userId == Get.find<ProfileDataController>().userProfile.value?.id);
          if(index2 >= 0) ride.participants.removeAt(index);
          snackbarNotifier?.notify(message: "You left the ride successfully");
        },
      );
    });
  }

  Future<void> joinRide({
    required SnackbarNotifier? snackbarNotifier,
    required BaggageType baggageType
  }) async{
    joinRideStn.setLoading();
    await serviceLocator<RideInterface>().joinRide(
      param: JoinRideReqParam(rideId: ride.id, baggageType: baggageType)
    ).then((lr){
      handleFold(
        either: lr,
        processStatusNotifier: joinRideStn,
        errorSnackbarNotifier: snackbarNotifier,
        onSuccess: (data) {
          riders.add(data.joinedRider);
          ride.participants.add(data.joinedRider);
          riders.refresh();
          snackbarNotifier?.notify(message: "You joined the ride successfully");
        },
      );
    });
  }

  Future<void> finishRide({
    required SnackbarNotifier? snackbarNotifier,
  }) async{
    finishRideStn.setLoading();
    await serviceLocator<RideInterface>().finishRide(
      rideId: ride.id
    ).then((lr){
      handleFold(
        either: lr,
        processStatusNotifier: finishRideStn,
        errorSnackbarNotifier: snackbarNotifier,
        onSuccess: (data) {
          snackbarNotifier?.notify(message: "You completed the ride successfully. Thanks for riding with us");
        },
      );
    });
  }

}


