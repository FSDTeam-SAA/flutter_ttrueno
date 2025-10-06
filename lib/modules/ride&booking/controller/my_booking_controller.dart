import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../core/notifiers/snackbar_notifier.dart';
import '../model/get_my_bookings_req_param.dart';
import '../../../core/common/controller/booked_ride_card_controller.dart';
import '../../../core/utils/helpers/handle_fold.dart';
import '../../../init_dependency.dart';
import '../interface/booking_interface.dart';
import '../model/enum/status.dart';


abstract class BookingController extends GetxController{
  final RxList<BookedRideCardActionController> bookings = <BookedRideCardActionController>[].obs; 
  bool _isLoading = false;
  RxString errorMessage = ''.obs;
  bool get isLoading => _isLoading;

  RxList<BookedRideCardActionController> rideCardControllers = <BookedRideCardActionController>[].obs;
  final GlobalKey<AnimatedListState> activeBookingListKey = GlobalKey();
  final GlobalKey<AnimatedListState> completedBookingListKey = GlobalKey();

  int _fetchCount = 0;

  _onLeaveSuccess() {
    getBookings();
  }

  _onFinishRideSuccess() {
    getBookings();
  }

  Future<void> getBookings({
    SnackbarNotifier? snackbarNotifier
  });
}


class ActiveBookingController extends BookingController {
  ActiveBookingController(this.snackbarNotifier);

  final SnackbarNotifier? snackbarNotifier;

  @override
  Future<void> getBookings({SnackbarNotifier? snackbarNotifier}) async{
    _isLoading = true;
    bookings.clear();
    rideCardControllers.clear();
    _fetchCount += 1;
    update();
    if(_fetchCount > 1) {
      snackbarNotifier?.notifySuccess(message:  "Refreshing bookings...".tr());
    }
    await Future.delayed(const Duration(seconds: 1));
    await serviceLocator<BookingInterface>().getMyBookings(GetMyBookingsReqParam.active()).then((lr) {
      handleFold(
        either: lr,
        onSuccess: (data) {
          for (var element in data) {
            if(element.status == Status.active) {
              bookings.add(
                BookedRideCardActionController(booking: element, onLeaveSuccess: _onLeaveSuccess, onFinishRideSuccess: _onFinishRideSuccess)
              );
            }
          }
          bookings.sort((a, b) => b.booking.ride.departureTime.compareTo(a.booking.ride.departureTime));
          bookings.refresh();
          rideCardControllers = List.generate(data.length, (index) => BookedRideCardActionController(
            booking: data[index],
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



class CompleteBookingController extends BookingController {
  CompleteBookingController(this.snackbarNotifier);

  final SnackbarNotifier? snackbarNotifier;

  @override
  Future<void> getBookings({SnackbarNotifier? snackbarNotifier}) async{
    
    _isLoading = true;
    bookings.clear();
    rideCardControllers.clear();
    _fetchCount += 1;
    update();
    if(_fetchCount > 1) {
      snackbarNotifier?.notifySuccess(message:  "Refreshing bookings...".tr());
    }
    await Future.delayed(const Duration(seconds: 1));
    await serviceLocator<BookingInterface>().getMyBookings(GetMyBookingsReqParam.active()).then((lr) {
      handleFold(
        either: lr,
        onSuccess: (data) {
          for (var element in data) {
            if(element.status == Status.completed) {
              bookings.add(
                BookedRideCardActionController(booking: element, onLeaveSuccess: _onLeaveSuccess, onFinishRideSuccess: _onFinishRideSuccess)
              );
            }
          }
          bookings.sort((a, b) => b.booking.ride.departureTime.compareTo(a.booking.ride.departureTime));
          bookings.refresh();
          rideCardControllers = List.generate(data.length, (index) => BookedRideCardActionController(
            booking: data[index],
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
