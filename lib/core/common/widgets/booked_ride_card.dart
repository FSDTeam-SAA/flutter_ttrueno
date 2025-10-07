import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/controller/booked_ride_card_controller.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/widgets/car_divider_widget.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/widgets/reactive_buttons/r_icon.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/widgets/riders_list.dart';
import 'package:ttrueno_fo827e642a0c4/core/notifiers/snackbar_notifier.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/enum/status.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/ride_model.dart';
import '../../../modules/ride&booking/ui/view/share_experience_screen.dart';
import '../../theme/app_colors.dart';
import '../../theme/text_style.dart';
import '../../../modules/message/ui/widget/alart_message_widget.dart';
import '../../../modules/profile/controller/profile_data_controller.dart';

class BookedRideCard extends StatefulWidget {
  final double elevation;
  final String date;
  final String time;
  final String fromLocation;
  final String toLocation;
  final RideModel ride;
  final bool allowJoin;
  final bool showCompleteRideOption = false;
  final BookedRideCardActionController bookedRideCardActionController;
  const BookedRideCard({
    super.key,
    this.elevation = 2,
    required this.date,
    required this.time,
    required this.fromLocation,
    required this.toLocation, required this.ride,
    required this.allowJoin,
    required this.bookedRideCardActionController,
  });

  factory BookedRideCard.fromRide(RideModel ride, BookedRideCardActionController bookedRideCardActionController, {double? elevation, required bool allowJoin}) {
    return BookedRideCard(
      date: DateFormat.yMd().format(ride.departureTime),
      time: DateFormat.Hm().format(ride.departureTime),
      fromLocation: ride.startLocation.address ?? "..",
      toLocation: ride.endLocation.address ?? "..",
      ride: ride,
      elevation: elevation ?? 0,
      allowJoin: allowJoin,
      bookedRideCardActionController: bookedRideCardActionController,
    );
  }

  @override
  State<BookedRideCard> createState() => _BookedRideCardState();
}

class _BookedRideCardState extends State<BookedRideCard> {
  late final BookedRideCardActionController bookedRideCardController;
  late final String currentUserId;
  final List<Map<String, dynamic>> joinedUsers = [];
  final int maxUsers = 4;

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUserId = Get.find<ProfileDataController>().userProfile.value?.id ?? "";
    bookedRideCardController = widget.bookedRideCardActionController;
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: widget.elevation,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Gap.h12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "From",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          Text(
                            widget.fromLocation,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "To",
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          Text(
                            widget.toLocation,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gap.h12,
                const CarDivider(),
                Gap.h20,
                RidersListWidget(
                  allowJoin: widget.allowJoin,
                  riders: bookedRideCardController.riders,
                  joinRideStn: bookedRideCardController.joinRideController.stn,
                  onJoin: (p0) {
                    bookedRideCardController.joinRideController.baggageType.value = p0;
                    bookedRideCardController.joinRideController.joinRide(snackbarNotifier: SnackbarNotifier(context: context));
                  },
                ),
                Gap.h8,
                Divider(color: Colors.grey.shade300, thickness: 1),
                SizedBox(
                  width: double.infinity,
                  height: 120,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildLeaveAndChatOption(),
                      _buildFinishRideOption(),
                    ],
                  ),
                ),
                if(bookedRideCardController.eligibleForRatingRide) _buildRateRideWidget(),
              ],
            ),
          ),
          Positioned(
            top: 16,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: const BoxDecoration(
                color: AppColors.primarybutton,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  bottomRight: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Text(
                "${widget.date} at ${widget.time}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildFinishRideOption() {
    
    return Expanded(
      child: Opacity(
          opacity: bookedRideCardController.eligibleToFinish ? 1.0 : 0.3,
          child: OutlinedButton.icon(
            onPressed: () {
              bookedRideCardController.finishRide(snackbarNotifier: SnackbarNotifier(context: context));
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide.none,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12.0),
            ),
            icon: RIcon(
              key: UniqueKey(),
              iconWidget: Icon(
                Icons.check_box_outlined,
                size: 24,
                color: Colors.green,
              ),
              loadingStateWidget: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
              processStatusNotifier: bookedRideCardController.finishRideStn,
            ),
            label: Text(
              'Finish Ride'.tr(),
              style: AppText.xl2Medium_22_500.copyWith(
                color: Colors.green,
              ),
            ),
          ),
        ),
    );
  }

  Widget _buildLeaveAndChatOption() {
    final opacityValue = bookedRideCardController.booking.ride.departureTime.isAfter(DateTime.now()) ? 1 : 0.5;
    debugPrint(opacityValue.toString());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Opacity(
          opacity: opacityValue.toDouble(),
          child: TextButton.icon(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                builder: (context) => ConfirmActionBottomSheet(
                  message: 'Are you sure?'.tr(),
                  confirmButtonText: 'Confirm'.tr(),
                  cancelButtonText: 'Cancel'.tr(),
                  onConfirm: () {
                    bookedRideCardController.leaveRide(snackbarNotifier: SnackbarNotifier(context: context));
                    // Navigator.pop(
                    //   context,
                    // );
                  },
                  onCancel: () {
                    // Navigator.pop(
                    //   context,
                    // );
                  },
                ),
              );
            },
            icon: RIcon(
              key: UniqueKey(),
              iconWidget: Image.asset(
                'assets/images/leave.png',
                width: 24,
                height: 24,
              ),
              loadingStateWidget: SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              ),
              processStatusNotifier: bookedRideCardController.leaveStn,
            ),
            label: Text(
              'Leave'.tr(),
              style: AppText.xl2Medium_22_300.copyWith(
                color: Colors.red,
              ),
            ),
          ),
        ),

        TextButton.icon(
          onPressed: () {
            
          },
          icon: Image.asset(
            'assets/images/chat1.png',
            width: 24,
            height: 24,
          ),
          label: Text(
            'Chat'.tr(),
            style: AppText.xl2Medium_22_300.copyWith(
              color: AppColors.primaryTextblack,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRateRideWidget() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShareExperienceScreen(),
                ), 
            );},
            icon: Image.asset(
              'assets/images/like.png',
              width: 24,
              height: 24,
            ),
          
            label: Text(
              'Rate your ride'.tr(),
              style: AppText.xl2Medium_22_300.copyWith(
                color: AppColors.primaryTextblack,
              ),
            ),
          );
      },
    );
  }

}
