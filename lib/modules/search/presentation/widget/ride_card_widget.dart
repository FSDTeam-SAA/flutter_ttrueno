import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/car_divider_widget.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/model/rider.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/widgets/cache/smart_network_image.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';
import 'package:ttrueno_fo827e642a0c4/modules/profile/model/user_profile.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/enum/baggage_type_enum.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/model/ride_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../message/ui/view/message_screen.dart';

class RideCard extends StatefulWidget {
  final String date;
  final String time;
  final String fromLocation;
  final String toLocation;
  final RideModel ride;

  const RideCard({
    super.key,
    required this.date,
    required this.time,
    required this.fromLocation,
    required this.toLocation, required this.ride,
  });

  @override
  State<RideCard> createState() => _RideCardState();
}

class _RideCardState extends State<RideCard> {
  final List<Map<String, dynamic>> joinedUsers = [];
  final int maxUsers = 4;

  String? selectedBaggageType;

  final List<Map<String, dynamic>> existingUsers = [
    {
      "image": "assets/images/user5.png",
      "name": "John",
      "rating": "4.5",
      "baggage": <String>{'Small'},
    },
    {
      "image": "assets/images/user3.png",
      "name": "Smith",
      "rating": "4.5",
      "baggage": <String>{'Medium'},
    },
  ];

  void _showJoinBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Select Baggage Type".tr(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Gap.h16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBaggageImageIcon(
                        imagePath: 'assets/images/largebaggage.png',
                        isSelected: selectedBaggageType == 'Large',
                        label: 'Large'.tr(),
                        onTap: () {
                          setModalState(() {
                            toggleBaggage('Large');
                          });
                        },
                      ),
                      Gap.h16,
                      _buildBaggageImageIcon(
                        imagePath: 'assets/images/smallbaggage.png',
                        isSelected: selectedBaggageType == 'Small',
                        label: 'Suitcase'.tr(),
                        onTap: () {
                          setModalState(() {
                            toggleBaggage('Small');
                          });
                        },
                      ),
                      Gap.h16,
                      _buildBaggageImageIcon(
                        imagePath: 'assets/images/empty.png',
                        isSelected: selectedBaggageType == 'No Baggage',
                        label: 'None'.tr(),
                        onTap: () {
                          setModalState(() {
                            toggleBaggage('No Baggage');
                          });
                        },
                      ),
                    ],
                  ),
                  Gap.h24,
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context, null),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: AppColors.primarybutton,
                              width: 1.5,
                            ),
                          ),
                          child: Text("Not Now".tr()),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (selectedBaggageType == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Please select a baggage type.".tr(),
                                  ),
                                ),
                              );
                              return;
                            }
                            setState(() {
                              joinedUsers.add({
                                "image": "assets/images/user1.png",
                                "name": "You",
                                "rating": "5.0",
                                "baggage": {selectedBaggageType!},
                              });
                            });
                            selectedBaggageType = null;
                            // Navigator.pop(context);
                            Future.delayed(
                              const Duration(milliseconds: 300),
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MessageScreen(),
                                  ),
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: Text(
                            "Join Ride".tr(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void toggleBaggage(String type) {
    if (selectedBaggageType == type) {
      selectedBaggageType = null;
    } else {
      selectedBaggageType = type;
    }
  }

  Widget _buildBaggageImageIcon({
    required String imagePath,
    required bool isSelected,
    required VoidCallback onTap,
    required String label,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 28,
            height: 28,
            color: isSelected ? AppColors.primarybutton : Colors.grey,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? AppColors.primarybutton
                  : AppColors.primaryTextblack,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return InkWell(
      onTap: () => _showJoinBottomSheet(),
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

  List<Widget> _buildUserSlots(List<Rider> participants) {
    List<Widget> slots = [];

    for (var rider in participants) {
      slots.add(
        _buildProfile(
          rider.profileImage,
          rider.name,
          rider.avgRating.toString(),
          {rider.baggageType},
        ),
      );
    }

    for (var user in joinedUsers) {
      slots.add(
        _buildProfile(
          user["image"]!,
          user["name"]!,
          user["rating"]!,
          user["baggage"]!,
        ),
      );
    }

    int totalUsers = existingUsers.length + joinedUsers.length;
    int remainingSlots = maxUsers - totalUsers;

    for (int i = 0; i < remainingSlots; i++) {
      slots.add(_buildAddButton());
    }

    return slots;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildUserSlots(widget.ride.participants),
                ),
                Gap.h8,
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
          radius: 36,
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
