// // import 'package:flutter/material.dart';
// // import 'package:ttrueno_fo827e642a0c4/car_divaider_widget.dart';
// // import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';

// // class User {
// //   final String name;
// //   final String avatarAsset;
// //   final double rating;
// //   final String? icon1Asset;
// //   final String? icon2Asset;

// //   User({
// //     required this.name,
// //     required this.avatarAsset,
// //     required this.rating,
// //     this.icon1Asset,
// //     this.icon2Asset,
// //   });
// // }

// // class BookingCard extends StatelessWidget {
// //   final String dateTime;
// //   final String fromLocation;
// //   final String toLocation;
// //   final List<User> users;
// //   final List<Widget> actionButtons;

// //   const BookingCard({
// //     super.key,
// //     required this.dateTime,
// //     required this.fromLocation,
// //     required this.toLocation,
// //     required this.users,
// //     required this.actionButtons,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       color: AppColors.white,
// //       margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
// //       elevation: 2.0,
// //       child: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Container(
// //               padding: const EdgeInsets.symmetric(
// //                 horizontal: 8.0,
// //                 vertical: 4.0,
// //               ),
// //               decoration: BoxDecoration(
// //                 color: Colors.blue.shade700,
// //                 borderRadius: BorderRadius.circular(8.0),
// //               ),
// //               child: Text(
// //                 dateTime,
// //                 style: const TextStyle(
// //                   color: Colors.white,
// //                   fontWeight: FontWeight.bold,
// //                   fontSize: 14.0,
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 12.0),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 _locationColumn('From', fromLocation, CrossAxisAlignment.start),
// //                 _locationColumn('To', toLocation, CrossAxisAlignment.start),
// //               ],
// //             ),
// //             CarDivider(),
// //             const SizedBox(height: 16.0),
// //             SingleChildScrollView(
// //               scrollDirection: Axis.horizontal,
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                 children: users
// //                     .map(
// //                       (user) => Padding(
// //                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //                         child: buildUserAvatar(user),
// //                       ),
// //                     )
// //                     .toList(),
// //               ),
// //             ),

// //             const SizedBox(height: 20.0),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceAround,
// //               children: actionButtons,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   static Column _locationColumn(
// //     String title,
// //     String location,
// //     CrossAxisAlignment align,
// //   ) {
// //     return Column(
// //       crossAxisAlignment: align,
// //       children: [
// //         Text(title, style: const TextStyle(fontSize: 12.0, color: Colors.grey)),
// //         const SizedBox(height: 4.0),
// //         Text(
// //           location,
// //           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget buildUserAvatar(User user) {
// //     return Column(
// //       children: [
// //         CircleAvatar(
// //           radius: 28.0,
// //           backgroundImage: AssetImage(user.avatarAsset),
// //           backgroundColor: Colors.grey[200],
// //         ),
// //         const SizedBox(height: 6.0),
// //         Text(
// //           user.name,
// //           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
// //         ),
// //         const SizedBox(height: 2.0),
// //         Row(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             const Icon(Icons.star, color: Colors.amber, size: 14.0),
// //             Text(
// //               user.rating.toStringAsFixed(1),
// //               style: const TextStyle(fontSize: 12.0, color: Colors.grey),
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 4.0),
// //         Row(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             if (user.icon1Asset != null)
// //               Image.asset(
// //                 user.icon1Asset!,
// //                 width: 14,
// //                 height: 14,
// //                 color: AppColors
// //                     .primaryTextblack, // Optional: applies tint if image supports it
// //               ),
// //             const SizedBox(width: 4),
// //             if (user.icon2Asset != null)
// //               Image.asset(
// //                 user.icon2Asset!,
// //                 width: 14,
// //                 height: 14,
// //                 color: AppColors.primaryTextblack, // Optional
// //               ),
// //           ],
// //         ),
// //       ],
// //     );
// //   }
// // }

// // class CancelledWidget extends StatefulWidget {
// //   const CancelledWidget({super.key});

// //   @override
// //   State<CancelledWidget> createState() => _ActiveWidgetState();
// // }

// // class _ActiveWidgetState extends State<CancelledWidget>
// //     with SingleTickerProviderStateMixin {
// //   late TabController _tabController;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _tabController = TabController(length: 3, vsync: this);
// //   }

// //   @override
// //   void dispose() {
// //     _tabController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final users2 = [
// //       User(
// //         name: 'John',
// //         avatarAsset: 'assets/images/user3.png',
// //         rating: 4.5,
// //         icon2Asset: 'assets/images/largebaggage.png',
// //       ),
// //       User(
// //         name: 'Smith',
// //         avatarAsset: 'assets/images/user4.png',
// //         rating: 4.5,
// //         icon2Asset: 'assets/images/empty.png',
        
// //       ),
// //       User(
// //         name: 'Alex',
// //         avatarAsset: 'assets/images/user5.png',
// //         rating: 4.5,
// //         icon1Asset: 'assets/images/smallbaggage.png',
// //         icon2Asset: 'assets/images/largebaggage.png',
// //       ),
// //       User(
// //         name: 'You',
// //         avatarAsset: 'assets/images/user7.png',
// //         rating: 4.5,
// //         icon1Asset: 'assets/images/smallbaggage.png',
// //       ),
// //     ];

// //     return Scaffold(
// //       body: TabBarView(
// //         controller: _tabController,
// //         children: [
// //           ListView(
// //             children: [
// //               BookingCard(
// //                 dateTime: '23 Feb 2025 at 10:00 AM',
// //                 fromLocation: 'Dublin Airport T1',
// //                 toLocation: 'Connell St 175',
// //                 users: users2,
// //                 actionButtons: [],
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:ttrueno_fo827e642a0c4/car_divaider_widget.dart';
// import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';
// import '../../../../core/theme/app_colors.dart';

// class RideCard extends StatefulWidget {
//   final String date;
//   final String time;
//   final String fromLocation;
//   final String toLocation;

//   const RideCard({
//     super.key,
//     required this.date,
//     required this.time,
//     required this.fromLocation,
//     required this.toLocation,
//   });

//   @override
//   State<RideCard> createState() => _RideCardState();
// }

// class _RideCardState extends State<RideCard> {
//   final List<Map<String, dynamic>> joinedUsers = [];
//   final int maxUsers = 4;

//   String? selectedBaggageType;

//   final List<Map<String, dynamic>> existingUsers = [
//     {
//       "image": "assets/images/user5.png",
//       "name": "John",
//       "rating": "4.5",
//       "baggage": <String>{'Small'}
//     },
//     {
//       "image": "assets/images/user3.png",
//       "name": "Smith",
//       "rating": "4.5",
//       "baggage": <String>{'Medium'}
//     },
//   ];

//   void _showJoinBottomSheet() {
//     showModalBottomSheet(
//       context: context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setModalState) {
//             return Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Text(
//                     "Select Baggage Type",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   Gap.h16,
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       _buildBaggageImageIcon(
//                         imagePath: 'assets/images/largebaggage.png',
//                         isSelected: selectedBaggageType == 'Small',
//                         onTap: () {
//                           setModalState(() {
//                             toggleBaggage('Small');
//                           });
//                         },
//                       ),
//                       Gap.h16,
//                       _buildBaggageImageIcon(
//                         imagePath: 'assets/images/smallbaggage.png',
//                         isSelected: selectedBaggageType == 'Medium',
//                         onTap: () {
//                           setModalState(() {
//                             toggleBaggage('Medium');
//                           });
//                         },
//                       ),
//                       Gap.h16,
//                       _buildBaggageImageIcon(
//                         imagePath: 'assets/images/empty.png',
//                         isSelected: selectedBaggageType == 'No Baggage',
//                         onTap: () {
//                           setModalState(() {
//                             toggleBaggage('No Baggage');
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                   Gap.h24,
//                   Row(
//                     children: [
//                       Expanded(
//                         child: OutlinedButton(
//                           onPressed: () => Navigator.pop(context, null),
//                           style: OutlinedButton.styleFrom(
//                             side: const BorderSide(
//                               color: AppColors.primarybutton,
//                               width: 1.5,
//                             ),
//                           ),
//                           child: const Text("Not Now"),
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             if (selectedBaggageType == null) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text("Please select a baggage type."),
//                                 ),
//                               );
//                               return;
//                             }
//                             setState(() {
//                               joinedUsers.add({
//                                 "image": "assets/images/user1.png",
//                                 "name": "You",
//                                 "rating": "5.0",
//                                 "baggage": {selectedBaggageType!},
//                               });
//                             });
//                             selectedBaggageType = null;
//                             Navigator.pop(context);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                           ),
//                           child: const Text(
//                             "Join Ride",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   void toggleBaggage(String type) {
//     if (selectedBaggageType == type) {
//       selectedBaggageType = null;
//     } else {
//       selectedBaggageType = type;
//     }
//   }

//   Widget _buildBaggageImageIcon({
//     required String imagePath,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Image.asset(
//         imagePath,
//         width: 24,
//         height: 24,
//         color: isSelected ? AppColors.primarybutton : Colors.grey,
//       ),
//     );
//   }

//   Widget _buildAddButton() {
//     return InkWell(
//       onTap: () => _showJoinBottomSheet(),
//       child: Container(
//         width: 36,
//         height: 36,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(color: Colors.grey.shade400, width: 2),
//         ),
//         child: Icon(
//           Icons.add,
//           color: Colors.grey.shade600,
//           size: 20,
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildUserSlots() {
//     List<Widget> slots = [];

//     for (var user in existingUsers) {
//       slots.add(_buildProfile(
//         user["image"]!,
//         user["name"]!,
//         user["rating"]!,
//         user["baggage"]!,
//       ));
//     }

//     for (var user in joinedUsers) {
//       slots.add(_buildProfile(
//         user["image"]!,
//         user["name"]!,
//         user["rating"]!,
//         user["baggage"]!,
//       ));
//     }

//     int totalUsers = existingUsers.length + joinedUsers.length;
//     int remainingSlots = maxUsers - totalUsers;

//     for (int i = 0; i < remainingSlots; i++) {
//       slots.add(_buildAddButton());
//     }

//     return slots;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 2,
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 20),
//                 Gap.h12,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "From",
//                           style: TextStyle(color: Colors.grey, fontSize: 16),
//                         ),
//                         Text(
//                           widget.fromLocation,
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 16),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "To",
//                           style: TextStyle(color: Colors.grey, fontSize: 16),
//                         ),
//                         Text(
//                           widget.toLocation,
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 16),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Gap.h12,
//                 const CarDivider(),
//                 Gap.h20,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: _buildUserSlots(),
//                 ),
//                 Gap.h8,
//               ],
//             ),
//           ),
//           Positioned(
//             top: 16,
//             left: 0,
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//               decoration: const BoxDecoration(
//                 color: AppColors.primarybutton,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(0),
//                   bottomRight: Radius.circular(8),
//                   topRight: Radius.circular(8),
//                 ),
//               ),
//               child: Text(
//                 "${widget.date} at ${widget.time}",
//                 style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProfile(
//     String imagePath,
//     String name,
//     String rating,
//     Set<String> baggageTypes,
//   ) {
//     return Column(
//       children: [
//         CircleAvatar(radius: 18, backgroundImage: AssetImage(imagePath)),
//         Gap.h4,
//         Text(
//           name,
//           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.star, color: Colors.amber, size: 12),
//             Text(rating, style: const TextStyle(fontSize: 12)),
//           ],
//         ),
//         Gap.h4,
//         //if (!baggageTypes.contains('No Baggage') && baggageTypes.isNotEmpty)
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: baggageTypes.map((type) {
//               String iconPath;
//               switch (type) {
//                 case 'Small':
//                   iconPath = 'assets/images/largebaggage.png';
//                   break;
//                 case 'Medium':
//                   iconPath = 'assets/images/smallbaggage.png';
//                   break;
//                 default:
//                   iconPath = 'assets/images/empty.png';
//               }
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 2.0),
//                 child: Image.asset(
//                   iconPath,
//                   width: 14,
//                   height: 14,
//                   color: AppColors.primaryTextblack,
//                 ),
//               );
//             }).toList(),
//           ),
//       ],
//     );
//   }
// }

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/car_divider_widget.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';
import 'package:ttrueno_fo827e642a0c4/features/message/presentation/screen/message_screen.dart';

import '../screen/share_experience_screen.dart';

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
    this.actionButtons = const [], // ✅ default empty
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
          const SizedBox(height: 4),
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
          // Text(
          //   'Join',
          //   style: TextStyle(
          //     fontSize: 12,
          //     color: Colors.grey.shade600,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
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
                Gap.h32,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _locationColumn(
                      'From'.tr(),
                      widget.fromLocation,
                      CrossAxisAlignment.start,
                    ),
                    _locationColumn(
                      'To'.tr(),
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

class CompleteWidget extends StatefulWidget {
  const CompleteWidget({super.key});

  @override
  State<CompleteWidget> createState() => _CompleteWidgetState();
}

class _CompleteWidgetState extends State<CompleteWidget>
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
        name: 'Alex',
        avatarAsset: 'assets/images/user1.png',
        rating: 4.5,
        baggageTypes: {'No Baggage'},
      ),
      User(
        name: 'You',
        avatarAsset: 'assets/images/user6.png',
        rating: 4.5,
        baggageTypes: {'No Baggage'},
      ),
    ];

    final users2 = [
      User(
        name: 'John',
        avatarAsset: 'assets/images/user1.png',
        rating: 4.5,
        baggageTypes: {'No Baggage'},
      ),
      User(
        name: 'Smith',
        avatarAsset: 'assets/images/user2.png',
        rating: 4.5,
        baggageTypes: {'Small'},
      ),
      User(
        name: 'Alex',
        avatarAsset: 'assets/images/user3.png',
        rating: 4.5,
        baggageTypes: {'Large'},
      ),
      User(
        name: 'You',
        avatarAsset: 'assets/images/user6.png',
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
                  TextButton.icon(
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
                // actionButtons: [
                //   Expanded(
                //     child: OutlinedButton.icon(
                //       onPressed: () => print('Finish Ride tapped'),
                //       style: OutlinedButton.styleFrom(
                //         side: BorderSide.none,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(8.0),
                //         ),
                //         padding: const EdgeInsets.symmetric(vertical: 12.0),
                //       ),
                //       icon: const Icon(
                //         Icons.check_box_outlined,
                //         size: 24,
                //         color: Colors.green,
                //       ),
                //       label: Text(
                //         'Finish Ride',
                //         style: AppText.xl2Medium_22_500.copyWith(
                //           color: Colors.green,
                //         ),
                //       ),
                //     ),
                //   ),
                // ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
