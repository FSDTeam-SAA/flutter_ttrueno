import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/state_manager.dart';
import 'package:ttrueno_fo827e642a0c4/core/notifiers/snackbar_notifier.dart';
import 'package:ttrueno_fo827e642a0c4/core/services/debug/debug_service.dart';
import 'package:ttrueno_fo827e642a0c4/init_dependency.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/interface/ride_interface.dart';
import 'package:ttrueno_fo827e642a0c4/modules/location/model/location_address.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/ride_model.dart';
import '../../../core/helpers/handle_fold.dart';
import '../../../core/notifiers/button_status_notifier.dart';
import '../../../main.dart';
import '../model/filter_ride_req_param.dart';

class SearchRideController extends GetxController{
  SearchRideController() {
    _initializeDefaultValues();
  }
  final RxList<RideModel> searchResults = RxList<RideModel>();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  LocationAdress? fromLocation;
  LocationAdress? toLocation;
  DateTime? _selectedDateTime;
  DateTime? get selectedDateTime => _selectedDateTime;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  RxInt passengers = RxInt(1);
  RxDouble departureFlexKm = RxDouble(.2);
  RxDouble arrivalFlexKm = RxDouble(.2);
  RxInt departureFlexMinutes = RxInt(15);

  Future<void> _initializeDefaultValues() async {
    final now = DateTime.now();
    selectedDate = now;
    selectedTime = TimeOfDay.fromDateTime(now);
    dateController.text =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    timeController.text = selectedTime!.format(navigatorKey.currentContext!);
    passengers.value = 1;
    await _setCurrentLocation();
  }

  Future<void> _setCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }
    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      final place = placemarks.first;
      String address =
          "${place.street ?? ''}, ${place.subLocality ?? ''}, ${place.locality ?? ''}, ${place.country ?? ''}";
      fromController.text = address;
      fromLocation = LocationAdress(
        lat: position.latitude,
        lng: position.longitude,
        address: address,
      );
    }
  }


  Future<void> selectDate(BuildContext context) async {
    debugPrint("Selecting date");
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );
    if (picked != null) {
      selectedDate = picked;
      _selectedDateTime = DateTime(picked.year, picked.month, picked.day, selectedTime?.hour ?? 0, selectedTime?.minute ?? 0);
      dateController.text =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    } else {
      debugPrint("Date not selected");
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final initialTime = selectedTime ?? TimeOfDay.now();
    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null) {
      selectedTime = picked;
      _selectedDateTime = DateTime(selectedDate?.year ?? 0, selectedDate?.month ?? 0, selectedDate?.day ?? 0, picked.hour, picked.minute);
      if(context.mounted) timeController.text = picked.format(context);
    }
  }

  void incrementPassengers() {
    passengers++;
  }

  void decrementPassengers() {
    if (passengers > 1) passengers--;
  }

  void resetForm(BuildContext context) async {
    final now = DateTime.now();
    selectedDate = now;
    dateController.text =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    selectedTime = TimeOfDay.fromDateTime(now);
    timeController.text = selectedTime!.format(context);
    passengers.value = 1;
    fromController.clear();
    toController.clear();
    arrivalFlexKm.value = .2;
    departureFlexKm.value = .2;
    departureFlexMinutes.value = 15;
    await _setCurrentLocation();
  }

  Future<void> searchRide({
    SnackbarNotifier? snackbarNotifier,
    ProcessStatusNotifier? processStatusNotifier,
  }) async {
    // Validate inputs
    if (fromLocation == null || toLocation == null) {
      snackbarNotifier?.notify(message: 'Please fill in both locations'.tr());
      return;
    }
    if (selectedDate == null || selectedTime == null) {
      snackbarNotifier?.notify(message: 'Please select date and time'.tr());
      return;
    }
    ControllerDebugger().dekhao("Searching Ride...");
    processStatusNotifier?.setLoading();
    await serviceLocator<RideInterface>().filterRide(
      params: FilterRideReqParam(
        arrivalFlexKm: arrivalFlexKm.value,
        departureFlexKm: departureFlexKm.value,
        departureFlexMinutes: departureFlexMinutes.value,
        fromLat: fromLocation!.lat ?? 0.0,
        fromLng: fromLocation!.lng ?? 0.0,
        toLat: toLocation!.lat ?? 0.0,
        toLng: toLocation!.lng ?? 0.0,
        departureTime: DateTime(
          selectedDate!.year,
          selectedDate!.month,
          selectedDate!.day,
          selectedTime!.hour,
          selectedTime!.minute,
        ),
        passengers: passengers.value
      )
    ).then((lr) {
      handleFold(
        either: lr,
        processStatusNotifier: processStatusNotifier,
        //successSnackbarNotifier: snackbarNotifier,
        errorSnackbarNotifier: snackbarNotifier,
        onSuccess: (data) {
          
          if (data.isEmpty) {
            snackbarNotifier?.notify(message: 'No rides found'.tr());
          }
          searchResults.value = data;
          searchResults.refresh();
        },
      );
    });
    Future.delayed(Duration(seconds: 3)).then((_){processStatusNotifier?.setEnabled();});
  }

  

  @override
  void dispose() {
    super.dispose();
    fromController.dispose();
    toController.dispose();
    dateController.dispose();
    timeController.dispose();
  }
}

