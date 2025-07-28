import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/car_divaider_widget.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';
import 'package:ttrueno_fo827e642a0c4/features/message/presentation/screen/message_screen.dart';

import '../../../message/presentation/widget/alart_message_widget.dart';

class User {
  final String name;
  final String avatarAsset;
  final double rating;
  final String? icon1Asset;
  final String? icon2Asset;
  final Set<String>? baggageTypes;

  User({
    required this.name,
    required this.avatarAsset,
    required this.rating,
    this.icon1Asset,
    this.icon2Asset,
    this.baggageTypes,
  });
}

class BookingCard extends StatefulWidget {
  final String dateTime;
  final String fromLocation;
  final String toLocation;
  final List<User> users;
  final List<Widget> actionButtons;
  final bool allowJoin;
  final int maxUsers;

  const BookingCard({
    super.key,
    required this.dateTime,
    required this.fromLocation,
    required this.toLocation,
    required this.users,
    required this.actionButtons,
    this.allowJoin = false,
    this.maxUsers = 4,
  });

  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  List<User> joinedUsers = [];
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
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildBaggageImageIcon(
                        imagePath: 'assets/images/largebaggage.png',
                        label: 'Large',
                        isSelected: selectedBaggageTypes.contains('Large'),
                        onTap: () {
                          setModalState(() {
                            toggleBaggage('Large');
                          });
                        },
                      ),
                      _buildBaggageImageIcon(
                        imagePath: 'assets/images/smallbaggage.png',
                        label: 'Small',
                        isSelected: selectedBaggageTypes.contains('Small'),
                        onTap: () {
                          setModalState(() {
                            toggleBaggage('Small');
                          });
                        },
                      ),
                      _buildBaggageImageIcon(
                        imagePath: 'assets/images/empty.png',
                        label: 'No Baggage',
                        isSelected: selectedBaggageTypes.contains('No Baggage'),
                        onTap: () {
                          setModalState(() {
                            toggleBaggage('No Baggage');
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
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
                              joinedUsers.add(
                                User(
                                  name: "You",
                                  avatarAsset: "assets/images/user6.png",
                                  rating: 5.0,
                                  baggageTypes: Set<String>.from(
                                    selectedBaggageTypes,
                                  ),
                                ),
                              );
                            });
                            selectedBaggageTypes.clear();
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: Text(
                            "Join Ride",
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
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            child: Image.asset(
              imagePath,
              width: 24,
              height: 24,
              color: isSelected ? AppColors.primarybutton : Colors.grey,
            ),
          ),
          //const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.primaryTextblack,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return InkWell(
      onTap: widget.allowJoin ? () => _showJoinBottomSheet() : null,
      child: Column(
        children: [
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400, width: 2),
              //color: Colors.grey.shade100,
            ),
            child: Icon(
              Icons.add,
              color: widget.allowJoin
                  ? Colors.grey.shade600
                  : Colors.grey.shade400,
              size: 24,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Join',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          // Empty space for rating
          const SizedBox(height: 16),
          // Empty space for baggage icons
          const SizedBox(height: 18),
        ],
      ),
    );
  }

  List<Widget> _buildUserSlots() {
    List<Widget> slots = [];

    // Add existing users
    for (var user in widget.users) {
      slots.add(buildUserAvatar(user));
    }

    // Add joined users
    for (var user in joinedUsers) {
      slots.add(buildUserAvatar(user));
    }

    // Add remaining add buttons
    int totalUsers = widget.users.length + joinedUsers.length;
    int remainingSlots = widget.maxUsers - totalUsers;

    for (int i = 0; i < remainingSlots; i++) {
      slots.add(_buildAddButton());
    }

    return slots;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 2.0,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _locationColumn(
                      'From',
                      widget.fromLocation,
                      CrossAxisAlignment.start,
                    ),
                    _locationColumn(
                      'To',
                      widget.toLocation,
                      CrossAxisAlignment.start,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                CarDivider(),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildUserSlots(),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: widget.actionButtons,
                ),
              ],
            ),
          ),
          Positioned(
            top: 16,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.blue.shade700,
                borderRadius: BorderRadius.only(
                  //topLeft: Radius.circular(12),
                  bottomRight: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Text(
                widget.dateTime,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Column _locationColumn(
    String title,
    String location,
    CrossAxisAlignment align,
  ) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(title, style: const TextStyle(fontSize: 16.0, color: Colors.grey)),
        const SizedBox(height: 4.0),
        Text(
          location,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      ],
    );
  }

  Widget buildUserAvatar(User user) {
    return Column(
      children: [
        CircleAvatar(
          radius: 17.5,
          backgroundImage: AssetImage(user.avatarAsset),
          backgroundColor: Colors.white,
        ),
        const SizedBox(height: 6.0),
        Text(
          user.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
        ),
        const SizedBox(height: 2.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 14.0),
            Text(
              user.rating.toStringAsFixed(1),
              style: const TextStyle(fontSize: 12.0, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (user.baggageTypes != null && user.baggageTypes!.isNotEmpty)
              ...user.baggageTypes!.map((type) {
                String imagePath;
                switch (type) {
                  case 'Large':
                    imagePath = 'assets/images/largebaggage.png';
                    break;
                  case 'Small':
                    imagePath = 'assets/images/smallbaggage.png';
                    break;
                  case 'No Baggage':
                    imagePath = 'assets/images/empty.png';
                    break;
                  default:
                    return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Image.asset(
                    imagePath,
                    width: 14,
                    height: 14,
                    color: AppColors.primaryTextblack,
                  ),
                );
              }).toList()
            else ...[
              if (user.icon1Asset != null)
                Image.asset(
                  user.icon1Asset!,
                  width: 14,
                  height: 14,
                  color: AppColors.primaryTextblack,
                ),
              const SizedBox(width: 4),
              if (user.icon2Asset != null)
                Image.asset(
                  user.icon2Asset!,
                  width: 14,
                  height: 14,
                  color: AppColors.primaryTextblack,
                ),
            ],
          ],
        ),
      ],
    );
  }
}

class ActiveWidget extends StatefulWidget {
  const ActiveWidget({super.key});

  @override
  State<ActiveWidget> createState() => _ActiveWidgetState();
}

class _ActiveWidgetState extends State<ActiveWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final users1 = [
      User(
        name: 'John',
        avatarAsset: 'assets/images/user2.png',
        rating: 4.5,
        baggageTypes: {'Large'},
      ),
      User(
        name: 'Smith',
        avatarAsset: 'assets/images/user5.png',
        rating: 4.5,
        baggageTypes: {'Small'},
      ),
      User(
        name: 'You',
        avatarAsset: 'assets/images/user1.png',
        rating: 4.5,
        baggageTypes: {'No Baggage'},
      ),
    ];

    final users2 = [
      User(
        name: 'John',
        avatarAsset: 'assets/images/user3.png',
        rating: 4.5,
        baggageTypes: {'No Baggage'},
      ),
      User(
        name: 'Smith',
        avatarAsset: 'assets/images/user4.png',
        rating: 4.5,
        baggageTypes: {'Small'},
      ),
      User(
        name: 'Alex',
        avatarAsset: 'assets/images/user5.png',
        rating: 4.5,
        baggageTypes: {'Large'},
      ),
      User(
        name: 'You',
        avatarAsset: 'assets/images/user1.png',
        rating: 4.5,
        baggageTypes: {'Large'},
      ),
    ];

    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(
            children: [
              BookingCard(
                dateTime: '23 Feb 2025 at 10:00 AM',
                fromLocation: 'Dublin Airport T1',
                toLocation: 'Connell St 175',
                users: users1,
                allowJoin: true, // Allow joining this ride
                actionButtons: [
                  // TextButton.icon(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => ConfirmActionBottomSheet(
                  //           message: 'Are you sure?',
                  //           onConfirm: () {
                  //             "Confirm";
                  //           },
                  //           onCancel: () {
                  //             "Cancel";
                  //           },
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   icon: Image.asset(
                  //     'assets/images/leave.png',
                  //     width: 24,
                  //     height: 24,
                  //   ),
                  //   label: Text(
                  //     'Leave',
                  //     style: AppText.xl2Medium_22_300.copyWith(
                  //       color: Colors.red,
                  //     ),
                  //   ),
                  // ),
                  TextButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled:
                            true, // Optional: allows full height if needed
                        backgroundColor: Colors
                            .transparent, // Optional: if your widget has its own background
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        builder: (context) => ConfirmActionBottomSheet(
                          message: 'Are you sure?',
                          onConfirm: () {
                            // Add your confirm logic here
                            print("Confirm");
                            Navigator.pop(
                              context,
                            ); // Close the bottom sheet if needed
                          },
                          onCancel: () {
                            // Add your cancel logic here
                            print("Cancel");
                            Navigator.pop(
                              context,
                            ); // Close the bottom sheet if needed
                          },
                        ),
                      );
                    },
                    icon: Image.asset(
                      'assets/images/leave.png',
                      width: 24,
                      height: 24,
                    ),
                    label: Text(
                      'Leave',
                      style: AppText.xl2Medium_22_300.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  ),

                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessageScreen(),
                        ),
                      );
                    },
                    icon: Image.asset(
                      'assets/images/chat1.png',
                      width: 24,
                      height: 24,
                    ),
                    label: Text(
                      'Chat',
                      style: AppText.xl2Medium_22_300.copyWith(
                        color: AppColors.primaryTextblack,
                      ),
                    ),
                  ),
                ],
              ),
              Gap.h4,
              BookingCard(
                dateTime: '23 Feb 2025 at 10:00 AM',
                fromLocation: 'Dublin Airport T1',
                toLocation: 'Connell St 175',
                users: users2,
                allowJoin: false, // Don't allow joining this ride
                actionButtons: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => print('Finish Ride tapped'),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                      ),
                      icon: const Icon(
                        Icons.check_box_outlined,
                        size: 24,
                        color: Colors.green,
                      ),
                      label: Text(
                        'Finish Ride',
                        style: AppText.xl2Medium_22_500.copyWith(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
