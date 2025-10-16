import 'package:get/get.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/model/rider.dart';
import 'package:ttrueno_fo827e642a0c4/app/init_dependency.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/interface/ride_interface.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/enum/baggage_type_enum.dart';

import '../../../core/utils/helpers/handle_fold.dart';
import '../../../core/notifiers/button_status_notifier.dart';
import '../../../core/notifiers/snackbar_notifier.dart';
import '../model/join_ride_req_param.dart';

class JoinRideController {
  JoinRideController({required this.rideId, required this.onJoinSuccess});
  
  final ProcessStatusNotifier stn = ProcessStatusNotifier(initialStatus: EnabledStatus());
  Rx<BaggageType> baggageType = Rx<BaggageType>(BaggageType.small);
  final String rideId;
  final void Function(List<Rider> rider) onJoinSuccess;

  Future<void> joinRide({
    required SnackbarNotifier? snackbarNotifier,
    required int seatBooked,
  }) async{
    if(baggageType.value == null){
      return;
    }
    stn.setLoading();
    await serviceLocator<RideInterface>().joinRide(
      param: JoinRideReqParam(rideId: rideId, baggageType: baggageType.value!, seatBooked: seatBooked)
    ).then((lr){
      handleFold(
        either: lr,
        processStatusNotifier: stn,
        successSnackbarNotifier: snackbarNotifier,
        onSuccess: (data) {
          data.toString();
          onJoinSuccess(data.joinedRiders);
        },
      );
      Future.delayed(const Duration(seconds: 1)).then((_) {
        stn.setEnabled();
      });
    });
  }
}