import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/controller/change_baggage_controller.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/controller/join_ride_controller.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/controller/kickout_rider_controller.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/controller/leave_ride_controller.dart';
import '../../../modules/message/ui/widget/alart_message_widget.dart';
import '../../../modules/message/ui/widget/change_baggage_type.dart';
import '../../../modules/profile/controller/profile_data_controller.dart';
import '../../../modules/ride&booking/model/enum/baggage_type_enum.dart';
import '../../../modules/ride&booking/ui/view/change_baggage_bottom_sheet.dart';
import '../../../modules/ride&booking/ui/view/join_ride_bottomsheet.dart';
import '../../notifiers/snackbar_notifier.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_gap.dart';
import '../model/rider.dart';
import 'cache/smart_network_image.dart';

/// This widget is used to display a list of riders in a ride.
/// 
/// If you want to allow users to join the ride, set [allowJoin] to true and provide
/// a callback function [onJoin] to handle the join action. You should also provide a
/// [joinRideController] to manage the state of the join

class RidersListWidget extends StatefulWidget {
  final JoinRideController joinRideController;
  final LeaveRideController? leaveRideController;
  final KickoutRiderController? kickoutRiderController;
  final ChangeBaggageController? changeBaggageController;
  final bool allowJoin;
  final double avatarSize;
  final RxList<Rider> riders;
  final int seatBooked;
  const RidersListWidget({
    super.key,
    this.avatarSize = 55,
    required this.allowJoin,
    required this.riders,
    required this.joinRideController,
    this.changeBaggageController,
    this.leaveRideController,
    this.kickoutRiderController,
    required this.seatBooked
  });

  @override
  State<RidersListWidget> createState() => _RidersListWidgetState();
}

class _RidersListWidgetState extends State<RidersListWidget> {

  String currentUserId = "";
  final int maxUsers = 4;
  late double avatarSize;
  double containerWidth = 80;
  double spacing = 8;

  @override
  void initState() {
    super.initState();
    currentUserId = Get.find<ProfileDataController>().userProfile.value?.id ?? "";
    avatarSize = widget.avatarSize;
  }

  calculateSpace(BoxConstraints constraints) {
    containerWidth = max(0, min(containerWidth, (constraints.maxWidth - ((maxUsers - 1) * spacing)) / maxUsers));
    spacing = max(spacing, (constraints.maxWidth - ((containerWidth * (maxUsers)))) / (maxUsers - 1));
    avatarSize = min(avatarSize, containerWidth);
  }
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        
        // return Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     spacing: spacing,
        //     children: [
        //       ...slots
        //     ],
        //   );
        return ObxValue(
          (data){
            List<Widget> slots = [];
            calculateSpace(constraints);
            for (var rider in widget.riders) {
              slots.add(
                SizedBox(
                  width: containerWidth,
                  child: _buildProfile(
                    rider,
                    rider.profileImage,
                    rider.userId == currentUserId ? "You" : rider.name,
                    rider.avgRating.toString(),
                    {rider.baggageType},
                  ),
                ),
              );
            }
      
            int totalUsers = widget.riders.length;
            int remainingSlots = maxUsers - totalUsers;
      
            if(widget.allowJoin) {
              for (int i = 0; i < remainingSlots; i++) {
                slots.add(SizedBox(width: containerWidth, child: _buildAddButton()));
              }
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spacing,
              children: [
                ...slots
              ],
            );

          },
          widget.riders
        );
      }
    );
  }

  void _onLongPress(Rider rider) {
    debugPrint("Long press on ${rider.name}");
    if (rider.userId == currentUserId) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if(widget.leaveRideController != null) ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Leave Ride'),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) {
                      return ConfirmActionBottomSheet(
                        message: 'Are you sure you want to leave the ride?',
                        confirmButtonText: 'Leave',
                        cancelButtonText: 'Not Now',
                        onConfirm: () async{
                          if(widget.leaveRideController == null) {
                            Navigator.pop(context);
                            return;
                          }
                            widget.leaveRideController
                                ?.leaveRide(
                                  snackbarNotifier: SnackbarNotifier(
                                    context: context,
                                  ),
                                )
                                .then((_) {
                            if(context.mounted) Navigator.pop(context);
                          });
                          // Add leave logic here
                        },
                        onCancel: () {
                          // Add cancel logic here
                        },
                        confirmStn: widget.leaveRideController!.stn,
                      );
                    },
                  );
                },
              ),
               ListTile(
                leading: const Icon(Icons.work_outline),
                title: const Text('Change Baggage'),
                onTap: () async {

                  Navigator.pop(context);
                  if(widget.changeBaggageController == null) return;
                  await showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) {
                      return ChangeBaggageBottomSheet(
                        changeBaggageController: widget.changeBaggageController!,
                        riderId: rider.userId,
                        initialBaggageType: rider.baggageType,
                      );
                    },
                  );
                },
              ),
              
              SizedBox(height: 50),
            ],
          );
        },
      );
    } else {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return ConfirmActionBottomSheet(
            message: 'Are you sure you want to vote to kick out ${rider.name}',
            confirmButtonText: 'Kick Out',
            cancelButtonText: 'Not Now',
            onConfirm: () async{
              await widget.kickoutRiderController?.kickRider(riderId: rider.userId, snackbarNotifier: SnackbarNotifier(context: context)).then((_) {
                if(context.mounted) Navigator.pop(context);
              });
            },
            onCancel: () {
              // Add cancel logic here
              Navigator.pop(context);
            },
            confirmStn: widget.kickoutRiderController!.stn,
          );
        },
      );
    }
  }

  void _showJoinBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return JoinRideBottomsheet(
          joinRideController: widget.joinRideController,
          seatBooked: widget.seatBooked,
        );
      },
    );
  }

  Widget _buildAddButton() {
    return InkWell(
      onTap: () {
        debugPrint("Join Ride tapped >> ${widget.allowJoin}");
        if (widget.allowJoin) {
          _showJoinBottomSheet();
        }
      },
      child: Column(
        children: [
          Container(
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400, width: 2),
            ),
            child: Icon(Icons.add, color: Colors.grey.shade600, size: 20),
          ),
          Gap.h4,
          Text("Join", style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildProfile(
    Rider rider,
    String imagePath,
    String name,
    String rating,
    Set<BaggageType> baggageTypes,
  ) {
    return Column(
      children: [
        InkWell(
          onLongPress: () {
            _onLongPress(rider);
          },
          child: SmartNetworkImage.circle(
            imageUrl: imagePath,
            diameter: avatarSize,
            fit: BoxFit.cover,
          ),
        ),
        Gap.h4,
        Text(
          name,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 12),
            Text(rating, style: const TextStyle(fontSize: 12)),
          ],
        ),
        Gap.h4,
        //if (!baggageTypes.contains('No Baggage') && baggageTypes.isNotEmpty)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: baggageTypes.map((type) {
            String iconPath;
            iconPath = type.assetImagePath();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Image.asset(
                iconPath,
                width: 14,
                height: 14,
                color: AppColors.primaryTextblack,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
