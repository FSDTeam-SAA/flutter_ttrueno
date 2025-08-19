import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ttrueno_fo827e642a0c4/car_divaider_widget.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';

import '../../../../core/theme/app_gap.dart';

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
        title: Text("Share Experience".tr()),
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
            Gap.h20,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Share your experience with your follow passengers".tr(),
                style: AppText.lgMedium_18_400.copyWith(
                  color: AppColors.primaryTextblack,
                ),
              ),
            ),
            Gap.h16,
            Expanded(
              child: ListView.separated(
                itemCount: passengers.length,
                separatorBuilder: (_, __) => Gap.h12,
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
                          Gap.h4,
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Gap.h4,
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star,
                                size: 14,
                                color: Colors.amber,
                              ),
                              Gap.w4,
                              Text(
                                ratingValue.toString(),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          Gap.h4,
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
                                Gap.w4,
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
            Gap.h16,
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
                child: Text(
                  "Submit".tr(),
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
            child: Text(
              "23 Feb 2025 at 10:00 AM",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Gap.h12,
          Row(
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "From\n".tr(),
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
                          text: "To\n".tr(),
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
