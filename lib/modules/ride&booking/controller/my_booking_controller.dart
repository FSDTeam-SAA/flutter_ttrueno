import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/controller/ride_card_action_controller.dart';
import 'package:ttrueno_fo827e642a0c4/init_dependency.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/interface/booking_interface.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/booking.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/enum/status.dart';
import '../../../core/common/controller/booked_ride_card_controller.dart';
import '../../../core/helpers/handle_fold.dart';
import '../../../core/notifiers/snackbar_notifier.dart';
import '../interface/ride_interface.dart';

class MyBookingController extends GetxController{
  final RxList<Booking> completedBookings = <Booking>[].obs; 
  final RxList<Booking> activeBookings = <Booking>[].obs; 
  bool _isLoading = false;
  RxString errorMessage = ''.obs;
  bool get isLoading => _isLoading;

  RxList<BookedRideCardActionController> rideCardControllers = <BookedRideCardActionController>[].obs;
  final GlobalKey<AnimatedListState> _activeBookingListKey = GlobalKey();
  final GlobalKey<AnimatedListState> _completedBookingListKey = GlobalKey();

  
  Future<void> myBookings() async{
    _isLoading = true;
    update();
    await serviceLocator<BookingInterface>().getMyBookings().then((lr) {
      handleFold(
        either: lr,
        onSuccess: (data) {
          for (var element in data) {
            if(element.status == Status.completed) {
              completedBookings.add(element);
            }
            if(element.status == Status.active) {
              activeBookings.add(element);
            }
          }
          activeBookings.refresh();
          completedBookings.refresh();
        },
      );
    });
    _isLoading = false;
    update();
  }

}