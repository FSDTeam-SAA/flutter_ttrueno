import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride/model/location_address.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride/model/post_ride_model.dart';

import '../../../core/notifiers/button_status_notifier.dart';

class PostRideController {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final ProcessStatusNotifier processStatusNotifier = ProcessStatusNotifier(initialStatus: EnabledStatus());
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  int passengers = 1;
  int? selectedBaggageIndex;

  final List<String> baggageTypes = ['Large', 'Small', 'None'];

  PostRideController() {
    _initializeDefaultValues();
  }

  Future<void> _initializeDefaultValues() async {
    final now = DateTime.now();
    selectedDate = now;
    selectedTime = TimeOfDay.fromDateTime(now);
    dateController.text =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    timeController.text = selectedTime!.format(navigatorKey.currentContext!);
    passengers = 1;
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
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );
    if (picked != null) {
      selectedDate = picked;
      dateController.text =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
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
      timeController.text = picked.format(context);
    }
  }

  void incrementPassengers() {
    passengers++;
  }

  void decrementPassengers() {
    if (passengers > 1) passengers--;
  }

  void selectBaggage(int index) {
    selectedBaggageIndex = index;
  }

  void resetForm(BuildContext context) async {
    final now = DateTime.now();
    selectedDate = now;
    dateController.text =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    selectedTime = TimeOfDay.fromDateTime(now);
    timeController.text = selectedTime!.format(context);
    passengers = 1;
    selectedBaggageIndex = null;
    fromController.clear();
    toController.clear();
    await _setCurrentLocation();
  }

  PostRideModel createRideModel() {
    final departureTime = selectedDate != null && selectedTime != null
        ? DateTime(
            selectedDate!.year,
            selectedDate!.month,
            selectedDate!.day,
            selectedTime!.hour,
            selectedTime!.minute,
          ).toIso8601String()
        : null;

    return PostRideModel(
      startLocation: LocationAdress(
        address: fromController.text,
      ),
      endLocation: LocationAdress(
        address: toController.text,
      ),
      departureTime: departureTime,
      seatCount: passengers,
      pinnedNote: selectedBaggageIndex != null ? baggageTypes[selectedBaggageIndex!] : null,
    );
  }

  Future<bool> submitRide(BuildContext context) async {
    // Validate inputs
    if (fromController.text.isEmpty || toController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in both locations'.tr())),
      );
      return false;
    }
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select date and time'.tr())),
      );
      return false;
    }

    // Create the ride model
    final rideModel = createRideModel();

    // TODO: Implement API call or database storage logic here
    // For now, we'll just print the JSON representation
    print(rideModel.toJson());

    return true;
  }

  void dispose() {
    fromController.dispose();
    toController.dispose();
    dateController.dispose();
    timeController.dispose();
  }

  // GlobalKey for accessing context in stateless scenarios
  static final navigatorKey = GlobalKey<NavigatorState>();
}