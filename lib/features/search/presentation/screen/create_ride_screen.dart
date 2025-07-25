import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';
import 'package:ttrueno_fo827e642a0c4/features/search/presentation/screen/filter_screen.dart';
import 'package:ttrueno_fo827e642a0c4/features/search/presentation/widget/ride_card_widget.dart';

import '../../../../core/theme/text_style.dart';
import '../../../post_ride/presentation/screen/post_ride_screen.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Top Bar', style: AppText.mdSemiBold_16_600.copyWith(
          color: AppColors.primaryTextblack,
        )),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/images/filter.png',
              width: 24,
              height: 24,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FilterRidesScreen()),
              );
            },
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Dublin Airport T1 to Connell St 175',
                      style: AppText.smMedium_14_600.copyWith(
                        color: AppColors.secondaryTextblack,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '23 Feb 2025 at 10:00 AM',
                      style: AppText.smMedium_14_600.copyWith(
                        color: AppColors.secondaryTextblack,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Gap.h12,
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [
                  RideCard(
                    date: '23 Feb 2025',
                    time: '10:00 AM',
                    fromLocation: 'Dublin Airport T1',
                    toLocation: 'Connell St 175',
                  ),
                  RideCard(
                    date: '23 Feb 2025',
                    time: '10:00 AM',
                    fromLocation: 'Dublin Airport T1',
                    toLocation: 'Connell St 175',
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                width: 185,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PostRideScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primarybutton,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Create Ride',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
