import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/widgets/reactive_buttons/save_button.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/widgets/textfields/location_textfield.dart';
import 'package:ttrueno_fo827e642a0c4/core/notifiers/snackbar_notifier.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';
import 'package:ttrueno_fo827e642a0c4/modules/location/model/location_address.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/controller/create_ride_controller.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/enum/baggage_type_enum.dart';

import '../widget/location_input.dart';

class CreateRideView extends StatefulWidget {
  const CreateRideView({super.key});

  @override
  State<CreateRideView> createState() => _CreateRideViewState();
}

class _CreateRideViewState extends State<CreateRideView> {

  late final PostRideController _createRideScreenController;

  @override
  void initState() {
    super.initState();
    _createRideScreenController = PostRideController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post Ride".tr(),
          style: AppText.xlSemiBold_20_600.copyWith(
            color: AppColors.primaryTextblack,
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: () async {
              _createRideScreenController.resetForm(context);
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
              fromController: _createRideScreenController.fromController,
              toController: _createRideScreenController.toController,
              onSelectingFromLocation: (locationAddress) {
                _createRideScreenController.fromLocation = locationAddress;
              },
              onSelectingToLocation: (locationAddress) {
                _createRideScreenController.toLocation = locationAddress;
              },
            ),
            Gap.h40,
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _createRideScreenController.dateController,
                    readOnly: true,
                    onTap: ()=> _createRideScreenController.selectDate(context),
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today_outlined),
                        onPressed: ()=> _createRideScreenController.selectDate(context),
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
                    controller: _createRideScreenController.timeController,
                    readOnly: true,
                    onTap: ()=> _createRideScreenController.selectTime(context),
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.watch_later_outlined),
                        onPressed: ()=> _createRideScreenController.selectTime(context),
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
                  "seats available".tr(),
                  style: AppText.lgMedium_18_500.copyWith(
                    color: AppColors.primaryTextblack,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    if (_createRideScreenController.seatAvailable.value > 1) setState(() => _createRideScreenController.seatAvailable--);
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
                  child: Text(
                    '${_createRideScreenController.seatAvailable}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() => _createRideScreenController.seatAvailable++),
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            BaggageSelector(
              onBaggageSelected: (p0) {
                setState(() => _createRideScreenController.selectedBaggageIndex = p0);
              },
            ),
            Gap.h24,
            //buildDepartureFlexibility(),
            Gap.h40,
            //buildArrivalFlexibility(),
            Gap.h80,
            // SizedBox(
            //   width: double.infinity,
            //   height: 51,
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: AppColors.primarybutton,
            //       foregroundColor: Colors.white,
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //     ),
            //     child: Text(
            //       'Create'.tr(),
            //       style: AppText.lgMedium_18_500.copyWith(
            //                     color: AppColors.white,
            //                   ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 52,
              child: RSaveButton(
                height: 50,
                borderRadius: BorderRadius.circular(20),
                key: UniqueKey(),
                buttonStatusNotifier:
                    _createRideScreenController.processStatusNotifier,
                saveText: 'Create'.tr(),
                loadingText: "Creating.....".tr(),
                onSaveTap: () async {
                  _createRideScreenController.submitRide(
                    snackbarNotifier: SnackbarNotifier(context: context)
                  );
                },
                onDone: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BaggageSelector extends StatefulWidget {
  final void Function(BaggageType) onBaggageSelected;
  const BaggageSelector({super.key, required this.onBaggageSelected});

  @override
  // ignore: library_private_types_in_public_api
  _BaggageSelectorState createState() => _BaggageSelectorState();
}

class _BaggageSelectorState extends State<BaggageSelector> {
  int? selectedIndex;

  final List<String> baggageImages = BaggageType.values.map((type) => type.assetImagePath()).toList();

  final List<String> baggageLabels = BaggageType.values.map((type) => type.name).toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap.h40,
        Text(
          "Please select your baggage type".tr(),
          style: AppText.xlSemiBold_20_400.copyWith(
            color: AppColors.primaryTextblack,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300, width: 2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(baggageImages.length, (index) {
              final isSelected = selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  widget.onBaggageSelected(BaggageType.values[index]);
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ColorFiltered(
                      colorFilter: isSelected
                          ? const ColorFilter.mode(
                              AppColors.primarybutton,
                              BlendMode.srcIn,
                            )
                          : const ColorFilter.mode(
                              Colors.grey,
                              BlendMode.srcIn,
                            ),
                      child: Image.asset(
                        baggageImages[index],
                        width: 28,
                        height: 28,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      baggageLabels[index],
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected
                            ? AppColors.primarybutton
                            : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
