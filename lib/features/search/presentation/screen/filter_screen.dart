// // import 'package:flutter/material.dart';
// // import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
// // import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';
// // import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';
// // import 'package:ttrueno_fo827e642a0c4/features/search/presentation/widget/custom_thumb_shap.dart';

// // class FilterRidesScreen extends StatefulWidget {
// //   const FilterRidesScreen({super.key});

// //   @override
// //   State<FilterRidesScreen> createState() => _FilterRidesScreenState();
// // }

// // class _FilterRidesScreenState extends State<FilterRidesScreen> {
// //   final TextEditingController fromController = TextEditingController();
// //   final TextEditingController toController = TextEditingController();
// //   final TextEditingController _dateController = TextEditingController();
// //   final TextEditingController _timeController = TextEditingController();

// //   DateTime? _selectedDate;
// //   int passengers = 1;

// //   double departureDistanceFlex = 2;
// //   double departureTimeFlex = 30;
// //   double arrivalFlex = 30;

// //   Future<void> _selectDate() async {
// //     DateTime now = DateTime.now();
// //     final DateTime? picked = await showDatePicker(
// //       context: context,
// //       initialDate: _selectedDate ?? now,
// //       firstDate: now,
// //       lastDate: DateTime(now.year + 2),
// //     );

// //     if (picked != null) {
// //       setState(() {
// //         _selectedDate = picked;
// //         _dateController.text =
// //             "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Filter Rides"),
// //         centerTitle: true,
// //         actions: [
// //           TextButton(
// //             onPressed: () {
// //               // Reset filters
// //               fromController.clear();
// //               toController.clear();
// //               setState(() {
// //                 passengers = 1;
// //                 departureDistanceFlex = 2;
// //                 departureTimeFlex = 30;
// //                 arrivalFlex = 30;
// //               });
// //             },
// //             child: Text("Reset"),
// //           ),
// //         ],
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16),
// //         child: ListView(
// //           children: [
// //             _LocationInputs(),
// //             Gap.h40,
// //             Row(
// //               children: [
// //                 Expanded(
// //                   child: TextField(
// //                     controller: _dateController,
// //                     readOnly: true,
// //                     decoration: InputDecoration(
// //                       prefixIcon: IconButton(
// //                         icon: const Icon(Icons.calendar_today_outlined),
// //                         onPressed: _selectDate,
// //                       ),
// //                       hintText: 'Date',
// //                       contentPadding: EdgeInsets.symmetric(vertical: 20),
// //                       enabledBorder: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(20),
// //                         borderSide: BorderSide(color: Colors.grey.shade300),
// //                       ),
// //                       focusedBorder: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(20),
// //                         borderSide: BorderSide(
// //                           color: AppColors.primarybutton,
// //                           width: 2,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 Gap.w12,
// //                 Expanded(
// //                   child: TextField(
// //                     controller: _timeController,
// //                     readOnly: false, // Allows manual input
// //                     keyboardType: TextInputType.datetime,
// //                     decoration: InputDecoration(
// //                       prefixIcon: GestureDetector(
// //                         onTap: () async {
// //                           final TimeOfDay? pickedTime = await showTimePicker(
// //                             context: context,
// //                             initialTime: TimeOfDay.now(),
// //                           );
// //                           if (pickedTime != null) {
// //                             final formattedTime = pickedTime.format(context);
// //                             _timeController.text = formattedTime;
// //                           }
// //                         },
// //                         child: const Icon(Icons.watch_later_outlined),
// //                       ),
// //                       hintText: 'Time',
// //                       contentPadding: EdgeInsets.symmetric(vertical: 20),
// //                       enabledBorder: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(20),
// //                         borderSide: BorderSide(color: Colors.grey.shade300),
// //                       ),
// //                       focusedBorder: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(20),
// //                         borderSide: BorderSide(
// //                           color: AppColors.primarybutton,
// //                           width: 2,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             Gap.h40,
// //             Row(
// //               children: [
// //                 Icon(Icons.person_outline, size: 28),
// //                 Gap.w12,
// //                 Text(
// //                   "Passengers",
// //                   style: AppText.mdRegular_16_400.copyWith(
// //                     color: AppColors.primaryTextblack,
// //                   ),
// //                 ),
// //                 Spacer(),
// //                 IconButton(
// //                   onPressed: () {
// //                     if (passengers > 1) {
// //                       setState(() => passengers--);
// //                     }
// //                   },
// //                   icon: Icon(Icons.remove_circle_outline),
// //                 ),
// //                 Container(
// //                   height: 35,
// //                   width: 80,
// //                   decoration: BoxDecoration(
// //                     color: Colors.transparent,
// //                     border: Border.all(color: Colors.grey[200]!, width: 2),
// //                     borderRadius: BorderRadius.circular(20),
// //                   ),
// //                   alignment: Alignment.center,
// //                   child: Text(
// //                     '$passengers',
// //                     style: const TextStyle(
// //                       fontSize: 16,
// //                       fontWeight: FontWeight.w600,
// //                     ),
// //                   ),
// //                 ),

// //                 IconButton(
// //                   onPressed: () {
// //                     setState(() => passengers++);
// //                   },
// //                   icon: Icon(Icons.add_circle_outline),
// //                 ),
// //               ],
// //             ),
// //             Gap.h24,
// //             Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   "Departure Flexibility",
// //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //                 ),
// //                 Gap.h12,
// //                 Row(
// //                   crossAxisAlignment: CrossAxisAlignment.center,
// //                   children: [
// //                     Expanded(
// //                       child: SliderTheme(
// //                         data: SliderTheme.of(context).copyWith(
// //                           trackHeight: 8,
// //                           activeTrackColor: AppColors.primarybutton,
// //                           inactiveTrackColor: AppColors.progressBg,
// //                           thumbColor: Colors.white,
// //                           thumbShape: CustomThumbShape(),
// //                           overlayShape: RoundSliderOverlayShape(
// //                             overlayRadius: 0,
// //                           ),
// //                         ),
// //                         child: Slider(
// //                           value: departureDistanceFlex,
// //                           min: 0,
// //                           max: 10,
// //                           label: "${departureDistanceFlex.round()} km",
// //                           onChanged: (value) {
// //                             setState(() => departureDistanceFlex = value);
// //                           },
// //                         ),
// //                       ),
// //                     ),
// //                     Gap.w24,
// //                     Text(
// //                       "${departureDistanceFlex.round()} km",
// //                       style: const TextStyle(fontSize: 14),
// //                     ),
// //                   ],
// //                 ),
// //                 Gap.h16,
// //                 Row(
// //                   crossAxisAlignment: CrossAxisAlignment.center,
// //                   children: [
// //                     Expanded(
// //                       child: SliderTheme(
// //                         data: SliderTheme.of(context).copyWith(
// //                           trackHeight: 8,
// //                           activeTrackColor: AppColors.primarybutton,
// //                           inactiveTrackColor: AppColors.progressBg,
// //                           thumbColor: Colors.white,
// //                           thumbShape: CustomThumbShape(),
// //                           overlayShape: const RoundSliderOverlayShape(
// //                             overlayRadius: 0,
// //                           ),
// //                         ),
// //                         child: Slider(
// //                           value: departureTimeFlex,
// //                           min: 0,
// //                           max: 180,
// //                           label: "${departureTimeFlex.round()} min",
// //                           onChanged: (value) {
// //                             setState(() => departureTimeFlex = value);
// //                           },
// //                         ),
// //                       ),
// //                     ),
// //                     Gap.w8,
// //                     Text(
// //                       "${departureTimeFlex.round()} min",
// //                       style: const TextStyle(fontSize: 14),
// //                     ),
// //                   ],
// //                 ),
// //                 Gap.h40,
// //                 Text(
// //                   "Arrival Flexibility",
// //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
// //                 ),
// //                 Gap.h12,
// //                 Row(
// //                   children: [
// //                     Expanded(
// //                       child: SliderTheme(
// //                         data: SliderTheme.of(context).copyWith(
// //                           trackHeight: 8,
// //                           activeTrackColor: AppColors.primarybutton,
// //                           inactiveTrackColor: AppColors.progressBg,
// //                           thumbColor: Colors.white,
// //                           thumbShape: CustomThumbShape(),
// //                           overlayShape: const RoundSliderOverlayShape(
// //                             overlayRadius: 0,
// //                           ),
// //                         ),
// //                         child: Slider(
// //                           value: arrivalFlex,
// //                           min: 0,
// //                           max: 60,
// //                           label: "${arrivalFlex.round()} Km",
// //                           onChanged: (value) {
// //                             setState(() => arrivalFlex = value);
// //                           },
// //                         ),
// //                       ),
// //                     ),
// //                     Gap.w8,
// //                     Text(
// //                       "${arrivalFlex.round()} Km",
// //                       style: const TextStyle(fontSize: 14),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),

// //             Gap.h80,
// //             SizedBox(
// //               width: double.infinity,
// //               height: 51,
// //               child: ElevatedButton(
// //                 onPressed: () {},
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: AppColors.primarybutton,
// //                   foregroundColor: Colors.white,
// //                   elevation: 0,
// //                   shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(20),
// //                   ),
// //                 ),
// //                 child: Text(
// //                   'Apply',
// //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class _LocationInputs extends StatelessWidget {
// //   const _LocationInputs();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Row(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Column(
// //           children: [
// //             Gap.h12,
// //             _buildCircleIcon(
// //               Image.asset('assets/images/down.png', width: 32, height: 32),
// //             ),
// //             _buildDashedLine(height: 40),
// //             _buildCircleIcon(
// //               Image.asset('assets/images/location.png', width: 32, height: 32),
// //             ),
// //           ],
// //         ),
// //         const SizedBox(width: 10),
// //         Expanded(
// //           child: Column(
// //             children: [
// //               _buildLocationField(label: 'From', hint: 'Enter Location'),
// //               const SizedBox(height: 15),
// //               _buildLocationField(label: 'Where to', hint: 'Enter Location'),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildCircleIcon(Image image) {
// //     return Container(
// //       padding: EdgeInsets.all(8),
// //       decoration: BoxDecoration(
// //         color: Color(0xFFF5F5F5),
// //         shape: BoxShape.circle,
// //       ),
// //       child: image,
// //     );
// //   }

// //   Widget _buildDashedLine({required double height}) {
// //     return SizedBox(
// //       height: height,
// //       width: 1,
// //       child: LayoutBuilder(
// //         builder: (context, constraints) {
// //           final boxHeight = constraints.constrainHeight();
// //           final dashHeight = 4.0;
// //           final dashCount = (boxHeight / (2 * dashHeight)).floor();
// //           return Flex(
// //             direction: Axis.vertical,
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: List.generate(dashCount, (_) {
// //               return SizedBox(
// //                 height: dashHeight,
// //                 width: 1,
// //                 child: DecoratedBox(
// //                   decoration: BoxDecoration(color: Colors.grey.shade400),
// //                 ),
// //               );
// //             }),
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   Widget _buildLocationField({required String label, required String hint}) {
// //     return Container(
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(16),
// //         border: Border.all(color: Colors.grey.shade300),
// //       ),
// //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             label,
// //             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
// //           ),
// //           const SizedBox(height: 4),
// //           TextField(
// //             decoration: InputDecoration(
// //               hintText: hint,
// //               hintStyle: TextStyle(color: Colors.grey.shade500),
// //               border: InputBorder.none,
// //               isDense: true,
// //               contentPadding: EdgeInsets.zero,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }


// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
// import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';
// import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';
// import 'package:ttrueno_fo827e642a0c4/features/search/presentation/widget/custom_thumb_shap.dart';

// class FilterRidesScreen extends StatefulWidget {
//   const FilterRidesScreen({super.key});

//   @override
//   State<FilterRidesScreen> createState() => _FilterRidesScreenState();
// }

// class _FilterRidesScreenState extends State<FilterRidesScreen> {
//   final TextEditingController fromController = TextEditingController();
//   final TextEditingController toController = TextEditingController();
//   final TextEditingController _dateController = TextEditingController();
//   final TextEditingController _timeController = TextEditingController();

//   DateTime? _selectedDate;
//   int passengers = 1;

//   double departureDistanceFlex = 2;
//   double departureTimeFlex = 30;
//   double arrivalFlex = 30;

//   // Mock existing bookings for demonstration
//   List<Booking> existingBookings = [
//     Booking(23.780573, 90.279239, DateTime.now().add(Duration(hours: 1))),
//     // Add more if needed
//   ];

//   Future<void> _selectDate() async {
//     DateTime now = DateTime.now();
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate ?? now,
//       firstDate: now,
//       lastDate: DateTime(now.year + 2),
//     );

//     if (picked != null) {
//       setState(() {
//         _selectedDate = picked;
//         _dateController.text =
//             "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
//       });
//     }
//   }

//   void attemptBooking() {
//     if (_selectedDate == null || _timeController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please select date and time')),
//       );
//       return;
//     }

//     // Parse selected time
//     final timeParts = _timeController.text.split(RegExp(r'[:\s]'));
//     if (timeParts.length < 2) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Invalid time format')),
//       );
//       return;
//     }
//     int hour = int.tryParse(timeParts[0]) ?? 0;
//     int minute = int.tryParse(timeParts[1]) ?? 0;
//     bool isPm = _timeController.text.toLowerCase().contains('pm');
//     if (isPm && hour < 12) hour += 12;
//     if (!isPm && hour == 12) hour = 0;

//     DateTime newDestTime = DateTime(
//       _selectedDate!.year,
//       _selectedDate!.month,
//       _selectedDate!.day,
//       hour,
//       minute,
//     );

//     // NOTE: Replace these with real "to" location lat/lng values
//     double newDestLat = 23.7800; // dummy latitude
//     double newDestLng = 90.2790; // dummy longitude

//     bool hasConflict = existingBookings.any((booking) {
//       final distance = calculateDistance(
//         booking.destinationLat,
//         booking.destinationLng,
//         newDestLat,
//         newDestLng,
//       );
//       final timeDiff = newDestTime.difference(booking.destinationTime).inMinutes.abs();

//       return distance <= 1.0 && timeDiff <= 120; // within 1km and 2 hours
//     });

//     if (hasConflict) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Booking Conflict'),
//           content: const Text(
//             'You have already made a booking for that itinerary and date. '
//             'You need to leave your seat before picking a seat in a new ride',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//     } else {
//       // Proceed with booking logic
//       // For demo, just print and show snackbar
//       print('Booking allowed');
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Booking successful!')),
//       );
//     }
//   }

//   // Haversine formula to calculate distance in Km between two coordinates
//   double calculateDistance(
//       double lat1, double lng1, double lat2, double lng2) {
//     const earthRadius = 6371; // in km
//     final dLat = _degreeToRadian(lat2 - lat1);
//     final dLng = _degreeToRadian(lng2 - lng1);
//     final a = (sin(dLat / 2) * sin(dLat / 2)) +
//         cos(_degreeToRadian(lat1)) *
//             cos(_degreeToRadian(lat2)) *
//             (sin(dLng / 2) * sin(dLng / 2));
//     final c = 2 * atan2(sqrt(a), sqrt(1 - a));
//     return earthRadius * c;
//   }

//   double _degreeToRadian(double degree) => degree * pi / 180;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Filter Rides"),
//         centerTitle: true,
//         actions: [
//           TextButton(
//             onPressed: () {
//               // Reset filters
//               fromController.clear();
//               toController.clear();
//               _dateController.clear();
//               _timeController.clear();
//               setState(() {
//                 passengers = 1;
//                 departureDistanceFlex = 2;
//                 departureTimeFlex = 30;
//                 arrivalFlex = 30;
//                 _selectedDate = null;
//               });
//             },
//             child: const Text("Reset"),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: ListView(
//           children: [
//             _LocationInputs(),
//             Gap.h40,
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _dateController,
//                     readOnly: true,
//                     decoration: InputDecoration(
//                       prefixIcon: IconButton(
//                         icon: const Icon(Icons.calendar_today_outlined),
//                         onPressed: _selectDate,
//                       ),
//                       hintText: 'Date',
//                       contentPadding: const EdgeInsets.symmetric(vertical: 20),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide(color: Colors.grey.shade300),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide(
//                           color: AppColors.primarybutton,
//                           width: 2,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Gap.w12,
//                 Expanded(
//                   child: TextField(
//                     controller: _timeController,
//                     readOnly: false,
//                     keyboardType: TextInputType.datetime,
//                     decoration: InputDecoration(
//                       prefixIcon: GestureDetector(
//                         onTap: () async {
//                           final TimeOfDay? pickedTime = await showTimePicker(
//                             context: context,
//                             initialTime: TimeOfDay.now(),
//                           );
//                           if (pickedTime != null) {
//                             final formattedTime = pickedTime.format(context);
//                             _timeController.text = formattedTime;
//                           }
//                         },
//                         child: const Icon(Icons.watch_later_outlined),
//                       ),
//                       hintText: 'Time',
//                       contentPadding: const EdgeInsets.symmetric(vertical: 20),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide(color: Colors.grey.shade300),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide(
//                           color: AppColors.primarybutton,
//                           width: 2,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Gap.h40,
//             Row(
//               children: [
//                 const Icon(Icons.person_outline, size: 28),
//                 Gap.w12,
//                 Text(
//                   "Passengers",
//                   style: AppText.mdRegular_16_400.copyWith(
//                     color: AppColors.primaryTextblack,
//                   ),
//                 ),
//                 const Spacer(),
//                 IconButton(
//                   onPressed: () {
//                     if (passengers > 1) {
//                       setState(() => passengers--);
//                     }
//                   },
//                   icon: const Icon(Icons.remove_circle_outline),
//                 ),
//                 Container(
//                   height: 35,
//                   width: 80,
//                   decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     border: Border.all(color: Colors.grey[200]!, width: 2),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   alignment: Alignment.center,
//                   child: Text(
//                     '$passengers',
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     setState(() => passengers++);
//                   },
//                   icon: const Icon(Icons.add_circle_outline),
//                 ),
//               ],
//             ),
//             Gap.h24,
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Departure Flexibility",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//                 Gap.h12,
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: SliderTheme(
//                         data: SliderTheme.of(context).copyWith(
//                           trackHeight: 8,
//                           activeTrackColor: AppColors.primarybutton,
//                           inactiveTrackColor: AppColors.progressBg,
//                           thumbColor: Colors.white,
//                           thumbShape: CustomThumbShape(),
//                           overlayShape: const RoundSliderOverlayShape(
//                             overlayRadius: 0,
//                           ),
//                         ),
//                         child: Slider(
//                           value: departureDistanceFlex,
//                           min: 0,
//                           max: 10,
//                           label: "${departureDistanceFlex.round()} km",
//                           onChanged: (value) {
//                             setState(() => departureDistanceFlex = value);
//                           },
//                         ),
//                       ),
//                     ),
//                     Gap.w24,
//                     Text(
//                       "${departureDistanceFlex.round()} km",
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ],
//                 ),
//                 Gap.h16,
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: SliderTheme(
//                         data: SliderTheme.of(context).copyWith(
//                           trackHeight: 8,
//                           activeTrackColor: AppColors.primarybutton,
//                           inactiveTrackColor: AppColors.progressBg,
//                           thumbColor: Colors.white,
//                           thumbShape: CustomThumbShape(),
//                           overlayShape: const RoundSliderOverlayShape(
//                             overlayRadius: 0,
//                           ),
//                         ),
//                         child: Slider(
//                           value: departureTimeFlex,
//                           min: 0,
//                           max: 180,
//                           label: "${departureTimeFlex.round()} min",
//                           onChanged: (value) {
//                             setState(() => departureTimeFlex = value);
//                           },
//                         ),
//                       ),
//                     ),
//                     Gap.w8,
//                     Text(
//                       "${departureTimeFlex.round()} min",
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ],
//                 ),
//                 Gap.h40,
//                 const Text(
//                   "Arrival Flexibility",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//                 Gap.h12,
//                 Row(
//                   children: [
//                     Expanded(
//                       child: SliderTheme(
//                         data: SliderTheme.of(context).copyWith(
//                           trackHeight: 8,
//                           activeTrackColor: AppColors.primarybutton,
//                           inactiveTrackColor: AppColors.progressBg,
//                           thumbColor: Colors.white,
//                           thumbShape: CustomThumbShape(),
//                           overlayShape: const RoundSliderOverlayShape(
//                             overlayRadius: 0,
//                           ),
//                         ),
//                         child: Slider(
//                           value: arrivalFlex,
//                           min: 0,
//                           max: 60,
//                           label: "${arrivalFlex.round()} Km",
//                           onChanged: (value) {
//                             setState(() => arrivalFlex = value);
//                           },
//                         ),
//                       ),
//                     ),
//                     Gap.w8,
//                     Text(
//                       "${arrivalFlex.round()} Km",
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Gap.h80,
//             SizedBox(
//               width: double.infinity,
//               height: 51,
//               child: ElevatedButton(
//                 onPressed: attemptBooking,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primarybutton,
//                   foregroundColor: Colors.white,
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 child: const Text(
//                   'Apply',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Booking {
//   final double destinationLat;
//   final double destinationLng;
//   final DateTime destinationTime;

//   Booking(this.destinationLat, this.destinationLng, this.destinationTime);
// }

// class _LocationInputs extends StatelessWidget {
//   const _LocationInputs();

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           children: [
//             Gap.h12,
//             _buildCircleIcon(
//               Image.asset('assets/images/down.png', width: 32, height: 32),
//             ),
//             _buildDashedLine(height: 40),
//             _buildCircleIcon(
//               Image.asset('assets/images/location.png', width: 32, height: 32),
//             ),
//           ],
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: Column(
//             children: [
//               _buildLocationField(label: 'From', hint: 'Enter Location'),
//               const SizedBox(height: 15),
//               _buildLocationField(label: 'Where to', hint: 'Enter Location'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCircleIcon(Image image) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       decoration: const BoxDecoration(
//         color: Color(0xFFF5F5F5),
//         shape: BoxShape.circle,
//       ),
//       child: image,
//     );
//   }

//   Widget _buildDashedLine({required double height}) {
//     return SizedBox(
//       height: height,
//       width: 1,
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final boxHeight = constraints.constrainHeight();
//           const dashHeight = 4.0;
//           final dashCount = (boxHeight / (2 * dashHeight)).floor();
//           return Flex(
//             direction: Axis.vertical,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: List.generate(dashCount, (_) {
//               return SizedBox(
//                 height: dashHeight,
//                 width: 1,
//                 child: DecoratedBox(
//                   decoration: BoxDecoration(color: Colors.grey.shade400),
//                 ),
//               );
//             }),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildLocationField({required String label, required String hint}) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//           ),
//           const SizedBox(height: 4),
//           const TextField(
//             decoration: InputDecoration(
//               hintText: 'Enter Location',
//               border: InputBorder.none,
//               isDense: true,
//               contentPadding: EdgeInsets.zero,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';
import 'package:ttrueno_fo827e642a0c4/features/search/presentation/widget/custom_thumb_shap.dart';

class FilterRidesScreen extends StatefulWidget {
  const FilterRidesScreen({super.key});

  @override
  State<FilterRidesScreen> createState() => _FilterRidesScreenState();
}

class _FilterRidesScreenState extends State<FilterRidesScreen> {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  DateTime? _selectedDate;
  int passengers = 1;

  double departureDistanceFlex = 2;
  double departureTimeFlex = 30;
  double arrivalFlex = 30;

  Future<void> _selectDate() async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Widget buildDepartureFlexSliders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Departure Flexibility",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Gap.h12,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 8,
                  activeTrackColor: AppColors.primarybutton,
                  inactiveTrackColor: AppColors.progressBg,
                  thumbColor: Colors.white,
                  thumbShape: CustomThumbShape(),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 0,
                  ),
                ),
                child: Slider(
                  value: departureDistanceFlex,
                  min: 0,
                  max: 10,
                  label: "${departureDistanceFlex.round()} km",
                  onChanged: (value) {
                    setState(() => departureDistanceFlex = value);
                  },
                ),
              ),
            ),
            Gap.w24,
            Text(
              "${departureDistanceFlex.round()} km",
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
        Gap.h16,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 8,
                  activeTrackColor: AppColors.primarybutton,
                  inactiveTrackColor: AppColors.progressBg,
                  thumbColor: Colors.white,
                  thumbShape: CustomThumbShape(),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 0,
                  ),
                ),
                child: Slider(
                  value: departureTimeFlex,
                  min: 0,
                  max: 180,
                  label: "${departureTimeFlex.round()} min",
                  onChanged: (value) {
                    setState(() => departureTimeFlex = value);
                  },
                ),
              ),
            ),
            Gap.w8,
            Text(
              "${departureTimeFlex.round()} min",
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter Rides"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // Reset filters
              fromController.clear();
              toController.clear();
              setState(() {
                passengers = 1;
                departureDistanceFlex = 2;
                departureTimeFlex = 30;
                arrivalFlex = 30;
                _dateController.clear();
                _timeController.clear();
                _selectedDate = null;
              });
            },
            child: const Text("Reset"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const _LocationInputs(),
            Gap.h40,
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today_outlined),
                        onPressed: _selectDate,
                      ),
                      hintText: 'Date',
                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: AppColors.primarybutton,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                Gap.w12,
                Expanded(
                  child: TextField(
                    controller: _timeController,
                    readOnly: false, // Allows manual input
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      prefixIcon: GestureDetector(
                        onTap: () async {
                          final TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            final formattedTime = pickedTime.format(context);
                            setState(() {
                              _timeController.text = formattedTime;
                            });
                          }
                        },
                        child: const Icon(Icons.watch_later_outlined),
                      ),
                      hintText: 'Time',
                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: AppColors.primarybutton,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap.h40,
            Row(
              children: [
                const Icon(Icons.person_outline, size: 28),
                Gap.w12,
                Text(
                  "Passengers",
                  style: AppText.mdRegular_16_400.copyWith(
                    color: AppColors.primaryTextblack,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    if (passengers > 1) {
                      setState(() => passengers--);
                    }
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Container(
                  height: 35,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.grey[200]!, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$passengers',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() => passengers++);
                  },
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            Gap.h24,

            // Use the refactored departure sliders here:
            buildDepartureFlexSliders(),

            Gap.h40,
            Text(
              "Arrival Flexibility",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Gap.h12,
            Row(
              children: [
                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 8,
                      activeTrackColor: AppColors.primarybutton,
                      inactiveTrackColor: AppColors.progressBg,
                      thumbColor: Colors.white,
                      thumbShape: CustomThumbShape(),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 0,
                      ),
                    ),
                    child: Slider(
                      value: arrivalFlex,
                      min: 0,
                      max: 60,
                      label: "${arrivalFlex.round()} Km",
                      onChanged: (value) {
                        setState(() => arrivalFlex = value);
                      },
                    ),
                  ),
                ),
                Gap.w8,
                Text(
                  "${arrivalFlex.round()} Km",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),

            Gap.h80,
            SizedBox(
              width: double.infinity,
              height: 51,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Add your booking conflict check and apply logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primarybutton,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Apply',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationInputs extends StatelessWidget {
  const _LocationInputs();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Gap.h12,
            _buildCircleIcon(
              Image.asset('assets/images/down.png', width: 32, height: 32),
            ),
            _buildDashedLine(height: 40),
            _buildCircleIcon(
              Image.asset('assets/images/location.png', width: 32, height: 32),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            children: [
              _buildLocationField(label: 'From', hint: 'Enter Location'),
              const SizedBox(height: 15),
              _buildLocationField(label: 'Where to', hint: 'Enter Location'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCircleIcon(Image image) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5),
        shape: BoxShape.circle,
      ),
      child: image,
    );
  }

  Widget _buildDashedLine({required double height}) {
    return SizedBox(
      height: height,
      width: 1,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final boxHeight = constraints.constrainHeight();
          const dashHeight = 4.0;
          final dashCount = (boxHeight / (2 * dashHeight)).floor();
          return Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(dashCount, (_) {
              return const SizedBox(
                height: dashHeight,
                width: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.grey),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  Widget _buildLocationField({required String label, required String hint}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade500),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
