import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/car_divaider_widget.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';

import '../../../../core/theme/app_colors.dart';

class RideCard extends StatefulWidget {
  final String date;
  final String time;
  final String fromLocation;
  final String toLocation;

  const RideCard({
    super.key,
    required this.date,
    required this.time,
    required this.fromLocation,
    required this.toLocation,
  });

  @override
  State<RideCard> createState() => _RideCardState();
}

class _RideCardState extends State<RideCard> {
  final List<Map<String, dynamic>> joinedUsers = [];
  final Set<String> selectedBaggageTypes = {};

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
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Select Baggage Type",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Gap.h16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBaggageImageIcon(
                        imagePath: 'assets/images/largebaggage.png',
                        isSelected: selectedBaggageTypes.contains('Small'),
                        onTap: () {
                          setModalState(() {
                            toggleBaggage('Small');
                          });
                        },
                      ),
                      Gap.h16,
                      _buildBaggageImageIcon(
                        imagePath: 'assets/images/smallbaggage.png',
                        isSelected: selectedBaggageTypes.contains('Medium'),
                        onTap: () {
                          setModalState(() {
                            toggleBaggage('Medium');
                          });
                        },
                      ),
                      Gap.h16,
                      _buildBaggageImageIcon(
                        imagePath: 'assets/images/empty.png',
                        isSelected: selectedBaggageTypes.contains('No Baggage'),
                        onTap: () {
                          setModalState(() {
                            if (!selectedBaggageTypes.contains('No Baggage')) {
                              selectedBaggageTypes.clear();
                              selectedBaggageTypes.add('No Baggage');
                            } else {
                              selectedBaggageTypes.remove('No Baggage');
                            }
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
                          child: const Text("Not Now"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (selectedBaggageTypes.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Please select a baggage type.",
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
                                "baggage": Set<String>.from(
                                  selectedBaggageTypes,
                                ), // Store a copy of the selected baggage
                              });
                            });

                            selectedBaggageTypes.clear();
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text("Join Ride"),
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
    if (selectedBaggageTypes.contains('No Baggage') && type != 'No Baggage') {
      selectedBaggageTypes.remove('No Baggage');
    }

    if (selectedBaggageTypes.contains(type)) {
      selectedBaggageTypes.remove(type);
    } else {
      selectedBaggageTypes.add(type);
    }
  }

  Widget _buildBaggageImageIcon({
    required String imagePath,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Image.asset(
          imagePath,
          width: 24,
          height: 24,
          color: isSelected ? AppColors.primarybutton : Colors.grey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                color: AppColors.primarybutton,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "${widget.date} at ${widget.time}",
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            Gap.h12,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("From", style: TextStyle(color: Colors.grey)),
                    Text(
                      widget.fromLocation,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                //const Icon(Icons.directions_car, color: Colors.grey),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("To", style: TextStyle(color: Colors.grey)),
                    Text(
                      widget.toLocation,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            CarDivider(),
            Gap.h12,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildProfile("assets/images/user1.png", "John", "4.5", {}),
                _buildProfile("assets/images/user3.png", "Smith", "4.5", {}),
                for (var user in joinedUsers)
                  _buildProfile(
                    user["image"]!,
                    user["name"]!,
                    user["rating"]!,
                    user["baggage"]!,
                  ),
                IconButton(
                  icon: const Icon(
                    Icons.add_circle_outline,
                    size: 50,
                    color: Colors.grey,
                  ),
                  onPressed: _showJoinBottomSheet,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfile(
    String imagePath,
    String name,
    String rating,
    Set<String> baggageTypes,
  ) {
    return Column(
      children: [
        CircleAvatar(radius: 18, backgroundImage: AssetImage(imagePath)),
        Gap.h4,
        Text(name, style: const TextStyle(fontSize: 12)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 12),
            Text(rating, style: const TextStyle(fontSize: 12)),
          ],
        ),
        //if (!baggageTypes.contains('No Baggage') && baggageTypes.isNotEmpty)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: baggageTypes.map((type) {
            String imagePath;
            switch (type) {
              case 'Small':
                imagePath = 'assets/images/largebaggage.png';
                break;
              case 'Medium':
                imagePath = 'assets/images/smallbaggage.png';
                break;
              default:
                imagePath = 'assets/images/empty.png';
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Image.asset(
                imagePath,
                width: 18,
                height: 18,
                color: AppColors
                    .primaryTextblack, // Optional: remove if you want the original image color
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
