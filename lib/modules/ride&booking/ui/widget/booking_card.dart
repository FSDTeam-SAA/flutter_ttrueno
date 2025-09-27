
// import 'package:flutter/material.dart';

// import '../../../../core/common/model/rider.dart';

// class BookingCard extends StatefulWidget {
//   final String dateTime;
//   final String fromLocation;
//   final String toLocation;
//   final List<Rider> riders;
//   final List<Widget> actionButtons;
//   final bool allowJoin;
//   final int maxUsers;

//   const BookingCard({
//     super.key,
//     required this.dateTime,
//     required this.fromLocation,
//     required this.toLocation,
//     required this.riders,
//     this.actionButtons = const [], // ✅ default empty
//     this.allowJoin = false,
//     this.maxUsers = 4,
//   });

//   @override
//   State<BookingCard> createState() => _BookingCardState();
// }

// class _BookingCardState extends State<BookingCard> {
//   final Set<String> selectedBaggageTypes = {};

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
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     "Select Baggage Type",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   const SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       _buildBaggageImageIcon(
//                         imagePath: 'assets/images/largebaggage.png',
//                         label: 'Large',
//                         isSelected: selectedBaggageTypes.contains('Large'),
//                         onTap: () {
//                           setModalState(() {
//                             toggleBaggage('Large');
//                           });
//                         },
//                       ),
//                       _buildBaggageImageIcon(
//                         imagePath: 'assets/images/smallbaggage.png',
//                         label: 'Small',
//                         isSelected: selectedBaggageTypes.contains('Small'),
//                         onTap: () {
//                           setModalState(() {
//                             toggleBaggage('Small');
//                           });
//                         },
//                       ),
//                       _buildBaggageImageIcon(
//                         imagePath: 'assets/images/empty.png',
//                         label: 'No Baggage',
//                         isSelected: selectedBaggageTypes.contains('No Baggage'),
//                         onTap: () {
//                           setModalState(() {
//                             toggleBaggage('No Baggage');
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 24),
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
//                             if (selectedBaggageTypes.isEmpty) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(
//                                     "Please select a baggage type.",
//                                   ),
//                                 ),
//                               );
//                               return;
//                             }
//                             selectedBaggageTypes.clear();
//                             Navigator.pop(context);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                           ),
//                           child: Text(
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
//     if (selectedBaggageTypes.contains('No Baggage') && type != 'No Baggage') {
//       selectedBaggageTypes.remove('No Baggage');
//     }
//     if (selectedBaggageTypes.contains(type)) {
//       selectedBaggageTypes.remove(type);
//     } else {
//       selectedBaggageTypes.add(type);
//     }
//   }

//   Widget _buildBaggageImageIcon({
//     required String imagePath,
//     required String label,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.all(12),
//             child: Image.asset(
//               imagePath,
//               width: 24,
//               height: 24,
//               color: isSelected ? AppColors.primarybutton : Colors.grey,
//             ),
//           ),
//           const SizedBox(height: 4),
//         ],
//       ),
//     );
//   }

//   Widget _buildAddButton() {
//     return InkWell(
//       onTap: widget.allowJoin ? () => _showJoinBottomSheet() : null,
//       child: Column(
//         children: [
//           Container(
//             width: 35,
//             height: 35,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(color: Colors.grey.shade400, width: 2),
//               //color: Colors.grey.shade100,
//             ),
//             child: Icon(
//               Icons.add,
//               color: widget.allowJoin
//                   ? Colors.grey.shade600
//                   : Colors.grey.shade400,
//               size: 24,
//             ),
//           ),
//           const SizedBox(height: 6),
//           // Text(
//           //   'Join',
//           //   style: TextStyle(
//           //     fontSize: 12,
//           //     color: Colors.grey.shade600,
//           //     fontWeight: FontWeight.w500,
//           //   ),
//           // ),
//           const SizedBox(height: 2),
//           // Empty space for rating
//           const SizedBox(height: 16),
//           // Empty space for baggage icons
//           const SizedBox(height: 18),
//         ],
//       ),
//     );
//   }

//   List<Widget> _buildUserSlots() {
//     List<Widget> slots = [];

//     // Add existing users
//     for (var rider in widget.riders) {
//       slots.add(buildUserAvatar(rider));
//     }

//     // Add remaining add buttons
//     int totalUsers = widget.riders.length;
//     int remainingSlots = widget.maxUsers - totalUsers;

//     for (int i = 0; i < remainingSlots; i++) {
//       slots.add(_buildAddButton());
//     }

//     return slots;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: AppColors.white,
//       margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
//       elevation: 2.0,
//       child: Stack(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Gap.h32,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _locationColumn(
//                       'From'.tr(),
//                       widget.fromLocation,
//                       CrossAxisAlignment.start,
//                     ),
//                     _locationColumn(
//                       'To'.tr(),
//                       widget.toLocation,
//                       CrossAxisAlignment.start,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 CarDivider(),
//                 const SizedBox(height: 16.0),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: _buildUserSlots(),
//                 ),
//                 const SizedBox(height: 20.0),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: widget.actionButtons,
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             top: 16,
//             left: 0,
//             child: Container(
//               padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//               decoration: BoxDecoration(
//                 color: Colors.blue.shade700,
//                 borderRadius: BorderRadius.only(
//                   //topLeft: Radius.circular(12),
//                   bottomRight: Radius.circular(8),
//                   topRight: Radius.circular(8),
//                 ),
//               ),
//               child: Text(
//                 widget.dateTime,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   static Column _locationColumn(
//     String title,
//     String location,
//     CrossAxisAlignment align,
//   ) {
//     return Column(
//       crossAxisAlignment: align,
//       children: [
//         Text(title, style: const TextStyle(fontSize: 16.0, color: Colors.grey)),
//         const SizedBox(height: 4.0),
//         Text(
//           location,
//           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
//         ),
//       ],
//     );
//   }

//   Widget buildUserAvatar(Rider rider) {
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 17.5,
//           backgroundImage: AssetImage(rider.profileImage),
//           backgroundColor: Colors.white,
//         ),
//         const SizedBox(height: 6.0),
//         Text(
//           rider.name,
//           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
//         ),
//         const SizedBox(height: 2.0),
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(Icons.star, color: Colors.amber, size: 14.0),
//             Text(
//               rider.avgRating.toStringAsFixed(1),
//               style: const TextStyle(fontSize: 12.0, color: Colors.grey),
//             ),
//           ],
//         ),
//         const SizedBox(height: 4.0),
//         Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 2.0),
//               child: Image.asset(
//                 rider.baggageType.assetImagePath(),
//                 width: 14,
//                 height: 14,
//                 color: AppColors.primaryTextblack,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
