// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:ttrueno_fo827e642a0c4/car_divaider_widget.dart';
// import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
// import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';

// class ShareExperienceScreen extends StatefulWidget {
//   const ShareExperienceScreen({super.key});

//   @override
//   State<ShareExperienceScreen> createState() => _ShareExperienceScreenState();
// }

// class _ShareExperienceScreenState extends State<ShareExperienceScreen> {
//   final Map<String, double> ratings = {
//     'John': 4.0,
//     'Smith': 3.0,
//     'Alex': 5.0,
//     'Anna': 4.0,
//   };

//   final passengers = [
//     {'name': 'John', 'image': 'assets/images/user1.png'},
//     {'name': 'Smith', 'image': 'assets/images/user2.png'},
//     {'name': 'Alex', 'image': 'assets/images/user3.png'},
//     {'name': 'Anna', 'image': 'assets/images/user4.png'},
//   ];

//   void handleSubmit() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Ratings submitted successfully!")),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: const BackButton(),
//         title: const Text("Share Experience"),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0.5,
//         foregroundColor: Colors.black,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             rideInfoCard(),
//             const SizedBox(height: 20),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 "Share your experience with your fellow passengers",
//                 style: AppText.lgMedium_18_400.copyWith(
//                   color: AppColors.primaryTextblack,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: ListView.separated(
//                 itemCount: passengers.length,
//                 separatorBuilder: (_, __) => const SizedBox(height: 12),
//                 itemBuilder: (context, index) {
//                   final passenger = passengers[index];
//                   final name = passenger['name']!;
//                   final ratingValue = ratings[name]!;

//                   return Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Column(
//                         children: [
//                           CircleAvatar(
//                             radius: 24,
//                             backgroundImage: AssetImage(passenger['image']!),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             name,
//                             style: const TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           const SizedBox(height: 2),
//                           Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               const Icon(
//                                 Icons.star,
//                                 size: 14,
//                                 color: Colors.amber,
//                               ),
//                               const SizedBox(width: 2),
//                               Text(
//                                 ratingValue.toString(),
//                                 style: const TextStyle(fontSize: 12),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 2),
//                           Image.asset(
//                             'assets/images/largebaggage.png',
//                             width: 14,
//                             height: 14,
//                             color: AppColors.primaryTextblack,
//                           ),
//                         ],
//                       ),
//                       const SizedBox(width: 16),
//                       Expanded(
//                         child: RatingBar.builder(
//                           initialRating: ratingValue,
//                           minRating: 1,
//                           direction: Axis.horizontal,
//                           allowHalfRating: false,
//                           itemCount: 5,
//                           itemSize: 24,
//                           itemBuilder: (context, _) =>
//                               const Icon(Icons.star, color: Colors.amber),
//                           onRatingUpdate: (rating) {
//                             setState(() {
//                               ratings[name] = rating;
//                             });
//                           },
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 16),
//             SizedBox(
//               width: double.infinity,
//               height: 52,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primarybutton,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 onPressed: handleSubmit,
//                 child: Text(
//                   "Submit",
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget rideInfoCard() {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//             decoration: BoxDecoration(
//               color: AppColors.primarybutton,
//               borderRadius: BorderRadius.circular(6),
//             ),
//             child: const Text(
//               "23 Feb 2025 at 10:00 AM",
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//           const SizedBox(height: 12),
//           Row(
//             children: const [
//               Expanded(
//                 child: Text.rich(
//                   TextSpan(
//                     children: [
//                       TextSpan(
//                         text: "From\n",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                       TextSpan(
//                         text: "Dublin Airport T1",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: "To\n",
//                           style: TextStyle(color: Colors.grey),
//                         ),
//                         TextSpan(
//                           text: "Connell St 175",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     textAlign: TextAlign.start,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           CarDivider(),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ttrueno_fo827e642a0c4/car_divaider_widget.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';

class ShareExperienceScreen extends StatefulWidget {
  const ShareExperienceScreen({super.key});

  @override
  State<ShareExperienceScreen> createState() => _ShareExperienceScreenState();
}

class _ShareExperienceScreenState extends State<ShareExperienceScreen> {
  final Map<String, double> ratings = {
    'John': 4.0,
    'Smith': 3.0,
    'Alex': 5.0,
    'Anna': 4.0,
  };

  final passengers = [
    {
      'name': 'John',
      'image': 'assets/images/user1.png',
      'icon1': 'assets/images/smallbaggage.png',
      'icon2': 'assets/images/largebaggage.png',
    },
    {
      'name': 'Smith',
      'image': 'assets/images/user2.png',
      'icon1': null,
      'icon2': 'assets/images/largebaggage.png',
    },
    {
      'name': 'Alex',
      'image': 'assets/images/user3.png',
      'icon1': null,
      'icon2': 'assets/images/empty.png',
    },
    {
      'name': 'Anna',
      'image': 'assets/images/user4.png',
      'icon1': 'assets/images/smallbaggage.png',
      'icon2': null,
    },
  ];

  void handleSubmit() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Ratings submitted successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Share Experience"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            rideInfoCard(),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Share your experience with your fellow passengers",
                style: AppText.lgMedium_18_400.copyWith(
                  color: AppColors.primaryTextblack,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: passengers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final passenger = passengers[index];
                  final name = passenger['name']!;
                  final ratingValue = ratings[name]!;
                  final icon1 = passenger['icon1'];
                  final icon2 = passenger['icon2'];

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: AssetImage(passenger['image']!),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star,
                                size: 14,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                ratingValue.toString(),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (icon1 != null)
                                Image.asset(
                                  icon1,
                                  width: 14,
                                  height: 14,
                                  color: AppColors.primaryTextblack,
                                ),
                              if (icon1 != null && icon2 != null)
                                const SizedBox(width: 4),
                              if (icon2 != null)
                                Image.asset(
                                  icon2,
                                  width: 14,
                                  height: 14,
                                  color: AppColors.primaryTextblack,
                                ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: RatingBar.builder(
                          initialRating: ratingValue,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemSize: 24,
                          itemBuilder: (context, _) =>
                              const Icon(Icons.star, color: Colors.amber),
                          onRatingUpdate: (rating) {
                            setState(() {
                              ratings[name] = rating;
                            });
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primarybutton,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: handleSubmit,
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rideInfoCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primarybutton,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              "23 Feb 2025 at 10:00 AM",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "From\n",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextSpan(
                        text: "Dublin Airport T1",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "To\n",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                          text: "Connell St 175",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ],
          ),
          CarDivider(),
        ],
      ),
    );
  }
}
