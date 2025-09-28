import 'package:flutter/widgets.dart';
import 'package:ttrueno_fo827e642a0c4/core/notifiers/button_status_notifier.dart';
import '../../../core/utils/helpers/handle_fold.dart';
import '../../../core/notifiers/snackbar_notifier.dart';
import '../../../init_dependency.dart';
import '../interface/ride_interface.dart';

class LeaveRideController {
  LeaveRideController({required this.rideId, required this.onLeaveSuccess});
  final String rideId;
  final VoidCallback onLeaveSuccess;
  final ProcessStatusNotifier stn = ProcessStatusNotifier(initialStatus: EnabledStatus());

  Future<void> leaveRide({
    required SnackbarNotifier? snackbarNotifier,
  }) async{
    await serviceLocator<RideInterface>().finishRide(rideId: rideId).then((lr){
      handleFold(
        either: lr,
        processStatusNotifier: stn,
        successSnackbarNotifier: snackbarNotifier,
        onSuccess: (data) {
          onLeaveSuccess();
        },
      );

      Future.delayed(const Duration(seconds: 1)).then((_) {
        stn.setEnabled();
      });
    });
  }
}

