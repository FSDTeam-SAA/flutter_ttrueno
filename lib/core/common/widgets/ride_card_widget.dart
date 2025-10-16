import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/controller/ride_card_action_controller.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/widgets/car_divider_widget.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/widgets/riders_list.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';
import 'package:ttrueno_fo827e642a0c4/core/utils/extensions/datetime_ext.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/enum/status.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/ride_model.dart';
import '../../theme/app_colors.dart';

/// Usecases: Search or filtered rides, Chat screen ride preview
class RideCard extends StatefulWidget {
  final double elevation;
  final DateTime date;
  final String fromLocation;
  final String toLocation;
  final RideModel ride;
  final bool allowJoin;
  final bool showCompleteRideOption = false;
  final int seatBooked;
  const RideCard({
    super.key,
    this.elevation = 2,
    required this.date,
    required this.fromLocation,
    required this.toLocation, required this.ride,
    required this.allowJoin, required this.seatBooked,
  });

  factory RideCard.fromRide(RideModel ride, {double? elevation, required bool allowJoin, required int seatBooked}) {
    return RideCard(
      date: ride.departureTime,
      fromLocation: ride.startLocation.address ?? "..",
      toLocation: ride.endLocation.address ?? "..",
      ride: ride,
      elevation: elevation ?? 2,
      allowJoin: allowJoin,
      seatBooked: seatBooked,
    );
  }

  @override
  State<RideCard> createState() => _RideCardState();
}

class _RideCardState extends State<RideCard> {
  late final RideCardActionController rideCardController;
  late final String currentUserId;
  final List<Map<String, dynamic>> joinedUsers = [];
  final int maxUsers = 4;

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rideCardController = RideCardActionController(ride: widget.ride);
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
                  allowJoin: rideCardController.eligibleToJoin.value,
                  riders: rideCardController.riders,
                  joinRideController: rideCardController.joinRideController,
                  changeBaggageController: rideCardController.changeBaggageController,
                  seatBooked: widget.seatBooked,
                ),
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
                widget.date.dmyAth24,
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

}
