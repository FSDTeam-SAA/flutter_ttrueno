import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';
import 'package:ttrueno_fo827e642a0c4/features/search/presentation/screen/filter_screen.dart';
import 'package:ttrueno_fo827e642a0c4/features/search/presentation/widget/filterchipwidget.dart';
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
        title: Text(
          'Top Bar',
          style: AppText.mdSemiBold_16_600.copyWith(
            color: AppColors.primaryTextblack,
          ),
        ),
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
                padding: EdgeInsets.symmetric(horizontal: 32),
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     // Ordenar
            //     TextButton.icon(
            //       onPressed: () {},
            //       icon: Icon(Icons.swap_vert, size: 24, color: Colors.black),
            //       label: Text('Ordenar', style: TextStyle(fontSize: 16, color: Colors.black)),
            //     ),

            //     // Filtrar with red dot
            //     Stack(
            //       alignment: Alignment.topRight,
            //       children: [
            //         TextButton.icon(
            //           onPressed: () {},
            //           icon: Icon(Icons.tune, size: 24, color: Colors.black),
            //           label: Text(
            //             'Filtrar',
            //             style: TextStyle(fontSize: 16,color: Colors.black),
            //           ),
            //         ),
            //       ],
            //     ),

            //     // Mapa
            //     TextButton.icon(
            //       onPressed: () {},
            //       icon: Icon(Icons.map_outlined, size: 24, color: Colors.black),
            //       label: Text('Mapa', style: TextStyle(fontSize: 16,color: Colors.black)),
            //     ),
            //   ],
            // ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // Departure Flex Distance
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      height:
                          48, // Adjust height as needed to fit your chip size
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            FilterChipWidget(
                              label: 'Departure Flex : 200 meters',
                            ),
                            SizedBox(width: 8),
                            FilterChipWidget(label: 'Departure Flex : 30 min'),
                            SizedBox(width: 8),
                            FilterChipWidget(
                              label: 'Arrival Flex : 200 meters',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

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
