import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/instance_manager.dart';
import 'package:ttrueno_fo827e642a0c4/core/notifiers/button_status_notifier.dart';

import '../../../modules/profile/controller/profile_data_controller.dart';
import '../../../modules/ride&booking/model/enum/baggage_type_enum.dart';
import '../../../modules/ride&booking/ui/view/join_ride_bottomsheet.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_gap.dart';
import '../model/rider.dart';
import 'cache/smart_network_image.dart';

class RidersListWidget extends StatefulWidget {
  final Function(BaggageType) onJoin;
  final ProcessStatusNotifier joinRideStn;
  final bool allowJoin;
  final RxList<Rider> riders;
  const RidersListWidget({super.key, required this.allowJoin, required this.riders, required this.onJoin, required this.joinRideStn});

  @override
  State<RidersListWidget> createState() => _RidersListWidgetState();
}

class _RidersListWidgetState extends State<RidersListWidget> {
  String currentUserId = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentUserId = Get.find<ProfileDataController>().userProfile.value?.id ?? "";
  }
  
  @override
  Widget build(BuildContext context) {
    List<Widget> slots = [];
    int maxUsers = 4;

    for (var rider in widget.riders) {
      slots.add(
        _buildProfile(
          rider.profileImage,
          rider.userId == currentUserId ? "You" : rider.name,
          rider.avgRating.toString(),
          {rider.baggageType},
        ),
      );
    }

    int totalUsers = widget.riders.length;
    int remainingSlots = maxUsers - totalUsers;

    if(widget.allowJoin) {
      for (int i = 0; i < remainingSlots; i++) {
        slots.add(_buildAddButton());
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...slots
      ],
    );
  }

  void _showJoinBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return JoinRideBottomsheet(onJoin: widget.onJoin, pstn: widget.joinRideStn);
      },
    );
  }

  Widget _buildAddButton() {
    return InkWell(
      onTap: () {
        if (widget.allowJoin) {
          _showJoinBottomSheet();
        }
      },
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
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
    String imagePath,
    String name,
    String rating,
    Set<BaggageType> baggageTypes,
  ) {
    return Column(
      children: [
        SmartNetworkImage.circle(
          imageUrl: imagePath,
          diameter: 36,
          fit: BoxFit.cover,
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