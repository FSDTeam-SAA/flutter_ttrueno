
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/controller/inbox_controller.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/model/rider.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/widgets/cache/smart_network_image.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/widgets/riders_list.dart';
import 'package:ttrueno_fo827e642a0c4/core/utils/helpers/auth_role.dart';
import 'package:ttrueno_fo827e642a0c4/core/services/app_pigeon/app_pigeon.dart';
import '../../../app/app_manager.dart';
import 'car_divider_widget.dart';
import '../../../modules/message/ui/widget/alart_message_widget.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_gap.dart';

class ChatRideCardWidget extends StatefulWidget {
  final ActiveRideChatController activeRide;
  
  const ChatRideCardWidget({super.key, required this.activeRide});

  @override
  State<ChatRideCardWidget> createState() => _ChatRideCardWidgetState();
}

class _ChatRideCardWidgetState extends State<ChatRideCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _LocationHeader(
          fromLocation: widget.activeRide.ride.value.startLocation.address ?? "",
          toLocation: widget.activeRide.ride.value.endLocation.address ?? "",
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: [
              Text(
                DateFormat.yMMMMEEEEd().format(widget.activeRide.ride.value.departureTime),
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryTextblack,
                ),
              ),
              Gap.w12,
              Text(
                DateFormat.Hm().format(widget.activeRide.ride.value.departureTime),
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryTextblack,
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: CarDivider(),
        ),
        Gap.h12,
        RidersListWidget(allowJoin: true, avatarSize: 50, riders: widget.activeRide.participants),
        // _UserAvatarsRow(
        //   joinedUsers: widget.activeRide.value.participants,
        // ),
      ],
    );
  }
}

class _LocationHeader extends StatelessWidget {
  final String fromLocation;
  final String toLocation;
  const _LocationHeader({required this.fromLocation, required this.toLocation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'From'.tr(),
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                Text(
                  fromLocation,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'To'.tr(),
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                Text(
                  toLocation,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UserAvatarsRow extends StatelessWidget {
  final List<Rider> joinedUsers;
  //final Function(String userName, Set<String> baggage) onBaggageChange;

  const _UserAvatarsRow({
    required this.joinedUsers,
    //required this.onBaggageChange,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
         mainAxisAlignment: MainAxisAlignment.start,
         spacing: max(0, min(16, (constraints.maxWidth - (70 * (joinedUsers.length - 1)))/(joinedUsers.length - 1))),
          children: joinedUsers
              .map(
                (user) => SizedBox(
                  width: 70,
                  child: _UserAvatar(
                    avatarSize: 50,
                    name: user.name,
                    rating: user.avgRating.toDouble(),
                    imageAsset: user.profileImage,
                    isCurrentUser: (Get.find<AppManager>().authStatus is! Authenticated) ? false : user.userId == (Get.find<AppManager>().authStatus as Authenticated).auth.userId,
                    baggage: {user.baggageType.toString()},
                  ),
                ),
              )
              .toList(),
        );
      }
    );
  }
}

class _UserAvatar extends StatelessWidget {
  final double avatarSize;
  final String name;
  final double rating;
  final String imageAsset;
  final bool isCurrentUser;
  final Set<String> baggage;

  const _UserAvatar({
    required this.avatarSize,
    required this.name,
    required this.rating,
    required this.imageAsset,
    this.isCurrentUser = false,
    required this.baggage,
  });

  void _onLongPress(BuildContext context) {
    if (isCurrentUser) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
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
                        onConfirm: () {
                          Navigator.pop(context);
                          // Add leave logic here
                        },
                        onCancel: () {
                          // Add cancel logic here
                        },
                      );
                    },
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.work_outline),
                title: const Text('Change Baggage'),
                onTap: () async {
                  // Navigator.pop(context);

                  // final updatedBaggage =
                  //     await showModalBottomSheet<Set<String>?>(
                  //       context: context,
                  //       isScrollControlled: true,
                  //       shape: const RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.vertical(
                  //           top: Radius.circular(20),
                  //         ),
                  //       ),
                  //       builder: (context) => BaggageChangeSheet(
                  //         initialSelectedBaggage: baggage,
                  //         initialSelected: '',
                  //       ),
                  //     );

                  // if (updatedBaggage != null) {
                  //   onBaggageChange(name, updatedBaggage);
                  // }
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
            message: 'Are you sure you want to vote to kick out $name?',
            confirmButtonText: 'Kick Out',
            cancelButtonText: 'Not Now',
            onConfirm: () {
              Navigator.pop(context);
              // Add kick out logic here
            },
            onCancel: () {
              // Add cancel logic here
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _onLongPress(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SmartNetworkImage.circle(
            imageUrl: imageAsset,
            diameter: avatarSize,
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, size: 14, color: Colors.amber),
              const SizedBox(width: 2),
              Text(
                '$rating',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          if (baggage.isNotEmpty) ...[
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: baggage.map((type) {
                final iconPath = (type == 'Large')
                    ? 'assets/images/largebaggage.png'
                    : (type == 'Small')
                    ? 'assets/images/smallbaggage.png'
                    : 'assets/images/empty.png';
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Image.asset(
                    iconPath,
                    width: 16,
                    height: 16,
                    color: AppColors.primaryTextblack,
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }
}