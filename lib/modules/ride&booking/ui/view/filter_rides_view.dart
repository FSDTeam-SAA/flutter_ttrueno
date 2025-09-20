
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/controller/search_and_filter_controller.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/ui/widget/location_input.dart';

import '../../../../core/common/widgets/reactive_buttons/save_button.dart';
import '../../../../core/notifiers/snackbar_notifier.dart';

class FilterRidesView extends StatefulWidget {
  const FilterRidesView({super.key});

  @override
  State<FilterRidesView> createState() => _FilterRidesViewState();
}

class _FilterRidesViewState extends State<FilterRidesView> {
  final SearchRideController searchRideController = Get.find<SearchRideController>();

  double departureDistanceFlex = 0;
  double arrivalDistanceFlex = 0;
  double departureTimeFlex = 1;
  double arrivalTimeFlex = 1;

  final List<double> allowedDistances = [
    0.1,
    0.2,
    0.3,
    0.4,
    0.5,
    0.6,
    0.7,
    0.8,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
  ];

  final List<int> allowedTimes = [0, 15, 30, 45, 60, 120, 180, 240, 300];

  @override
  void initState() {
    super.initState();

    departureDistanceFlex = _distanceToSlider(0.2);
    arrivalDistanceFlex = _distanceToSlider(0.2);
    departureTimeFlex = 1;
    arrivalTimeFlex = 1;

  }

  double _sliderToDistance(double value) {
    int index = (value * (allowedDistances.length - 1)).round();
    return allowedDistances[index];
  }

  double _distanceToSlider(double distance) {
    int index = allowedDistances.indexOf(distance);
    if (index == -1) return 0;
    return index / (allowedDistances.length - 1);
  }

  double _snapSliderToNearest(double value) {
    int index = (value * (allowedDistances.length - 1)).round();
    return index / (allowedDistances.length - 1);
  }

  String _formatDistance(double km) {
    if (km < 1) return "${(km * 1000).round()} m";
    return "${km.toStringAsFixed(0)} km";
  }

  String _formatAllowedTime(int minutes) {
    if (minutes < 60) return "$minutes min";
    int h = minutes ~/ 60;
    int m = minutes % 60;
    return m > 0 ? "${h}h ${m}m" : "${h}h";
  }


  Widget buildDepartureFlexibility() {
    double currentKm = _sliderToDistance(departureDistanceFlex);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Departure Flexibility".tr(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Gap.h16,
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 8,
                  activeTrackColor: AppColors.primarybutton,
                  inactiveTrackColor: AppColors.progressBg,
                  thumbColor: Colors.white,
                  thumbShape: CustomThumbShape(),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
                ),
                child: Slider(
                  value: departureDistanceFlex,
                  min: 0,
                  max: 1,
                  onChanged: (v) {
                    setState(() {
                      departureDistanceFlex = _snapSliderToNearest(v);
                    });
                  },
                ),
              ),
            ),
            Gap.w16,
            Text(
              _formatDistance(currentKm),
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        Gap.h24,
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 8,
                  activeTrackColor: AppColors.primarybutton,
                  inactiveTrackColor: AppColors.progressBg,
                  thumbColor: Colors.white,
                  thumbShape: CustomThumbShape(),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
                  tickMarkShape: SliderTickMarkShape.noTickMark,
                ),
                child: Slider(
                  value: departureTimeFlex,
                  min: 0,
                  max: (allowedTimes.length - 1).toDouble(),
                  divisions: allowedTimes.length - 1,
                  onChanged: (v) {
                    setState(() {
                      departureTimeFlex = v.roundToDouble();
                    });
                  },
                ),
              ),
            ),
            Gap.w16,
            Text(
              _formatAllowedTime(allowedTimes[departureTimeFlex.toInt()]),
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildArrivalFlexibility() {
    double currentKm = _sliderToDistance(arrivalDistanceFlex);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Arrival Flexibility".tr(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Gap.h16,
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 8,
                  activeTrackColor: AppColors.primarybutton,
                  inactiveTrackColor: AppColors.progressBg,
                  thumbColor: Colors.white,
                  thumbShape: CustomThumbShape(),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
                ),
                child: Slider(
                  value: arrivalDistanceFlex,
                  min: 0,
                  max: 1,
                  onChanged: (v) {
                    setState(() {
                      arrivalDistanceFlex = _snapSliderToNearest(v);
                    });
                  },
                ),
              ),
            ),
            Gap.w16,
            Text(
              _formatDistance(currentKm),
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        Gap.h24,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Filters".tr(),
          style: AppText.xlSemiBold_20_600.copyWith(
            color: AppColors.primaryTextblack,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              searchRideController.resetForm(context);
            },
            child: Text(
              "Reset".tr(),
              style: AppText.lgMedium_18_400.copyWith(
                color: AppColors.primarybutton,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            LocationInputs(
              fromController: searchRideController.fromController,
              toController: searchRideController.toController,
              onSelectingFromLocation: (locationAddress) {
                searchRideController.fromLocation = locationAddress;
              },
              onSelectingToLocation: (locationAddress) {
                searchRideController.toLocation = locationAddress;
              },
            ),
            Gap.h40,
            // ... rest of your UI unchanged
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchRideController.dateController,
                    readOnly: true,
                    onTap:()async => searchRideController.selectDate(context),
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today_outlined),
                        onPressed: ()async => searchRideController.selectDate(context),
                      ),
                      hintText: 'Date'.tr(),
                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: AppColors.primarybutton,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                Gap.w12,
                Expanded(
                  child: TextField(
                    controller: searchRideController.timeController,
                    readOnly: true,
                    onTap: ()async => searchRideController.selectTime(context),
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.watch_later_outlined),
                        onPressed: ()async => searchRideController.selectTime(context)
                      ),
                      hintText: 'Time'.tr(),
                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: AppColors.primarybutton,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap.h40,
            Row(
              children: [
                const Icon(Icons.person_outline, size: 28),
                Gap.w12,
                Text(
                  "Seat availabile".tr(),
                  style: AppText.mdRegular_16_400.copyWith(
                    color: AppColors.primaryTextblack,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    if (searchRideController.passengers > 1) setState(() => searchRideController.passengers--);
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Container(
                  height: 35,
                  width: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[200]!, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Obx(
                    ()=> Text(
                      '${searchRideController.passengers}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    searchRideController.incrementPassengers();
                  },
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            Gap.h24,
            buildDepartureFlexibility(),
            Gap.h40,
            buildArrivalFlexibility(),
            Gap.h80,
            ///////////
            RSaveButton(
              key: UniqueKey(),
              saveText: 'Apply'.tr(),
              loadingText: "Apply".tr(),
              buttonStatusNotifier:
                  searchRideController.processStatusNotifier,
              onSaveTap: () => searchRideController.searchRide(
                snackbarNotifier: SnackbarNotifier(context: context)
              ),
              onDone: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}


class CustomThumbShape extends RoundSliderThumbShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(16, 16);
}
