import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:ttrueno_fo827e642a0c4/core/notifiers/snackbar_notifier.dart';
import 'package:ttrueno_fo827e642a0c4/init_dependency.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/interface/booking_interface.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/enum/status.dart';
import '../../../core/common/controller/booked_ride_card_controller.dart';
import '../../../core/utils/helpers/handle_fold.dart';

class MyBookingController extends GetxController{
  MyBookingController({this.snackbarNotifier});
  final RxList<BookedRideCardActionController> completedBookings = <BookedRideCardActionController>[].obs; 
  final RxList<BookedRideCardActionController> activeBookings = <BookedRideCardActionController>[].obs; 
  final SnackbarNotifier? snackbarNotifier;
  bool _isLoading = false;
  RxString errorMessage = ''.obs;
  bool get isLoading => _isLoading;

  RxList<BookedRideCardActionController> rideCardControllers = <BookedRideCardActionController>[].obs;
  final GlobalKey<AnimatedListState> activeBookingListKey = GlobalKey();
  final GlobalKey<AnimatedListState> completedBookingListKey = GlobalKey();

  int _fetchCount = 0;

  _onLeaveSuccess() {
    myBookings();
  }

  _onFinishRideSuccess() {
    myBookings();
  }

  Future<void> myBookings({
    SnackbarNotifier? snackbarNotifier
  }) async{
    
    _isLoading = true;
    completedBookings.clear();
    activeBookings.clear();
    rideCardControllers.clear();
    _fetchCount += 1;
    update();
    if(_fetchCount > 1) {
      snackbarNotifier?.notifySuccess(message:  "Refreshing bookings...".tr());
    }
    await Future.delayed(const Duration(seconds: 1));
    await serviceLocator<BookingInterface>().getMyBookings().then((lr) {
      handleFold(
        either: lr,
        onSuccess: (data) {
          for (var element in data) {
            if(element.status == Status.completed) {
              completedBookings.add(
                BookedRideCardActionController(ride: element.ride, onLeaveSuccess: _onLeaveSuccess, onFinishRideSuccess: _onFinishRideSuccess)
              );
            }
            if(element.status == Status.active) {
              activeBookings.add(
                BookedRideCardActionController(ride: element.ride, onLeaveSuccess: _onLeaveSuccess, onFinishRideSuccess: _onFinishRideSuccess)
              );
            }
            
          }
          activeBookings.sort((a, b) => b.ride.departureTime.compareTo(a.ride.departureTime));
          completedBookings.sort((a, b) => b.ride.departureTime.compareTo(a.ride.departureTime));
          activeBookings.refresh();
          completedBookings.refresh();
          rideCardControllers = List.generate(data.length, (index) => BookedRideCardActionController(
            ride: data[index].ride,
            onFinishRideSuccess: _onFinishRideSuccess,
            onLeaveSuccess: _onLeaveSuccess,
          )).obs;
          
        },
        onError: (message) {
          errorMessage.value = message.uiMessage;
        },
      );
    });
    _isLoading = false;
    update();
  }

}
