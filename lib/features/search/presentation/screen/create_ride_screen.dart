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
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 0.0),
            //       child: ElevatedButton(
            //         onPressed: () {},
            //         style: ElevatedButton.styleFrom(
            //           padding: EdgeInsets.symmetric(
            //             horizontal: 12,
            //             vertical: 8,
            //           ),
            //           textStyle: TextStyle(fontSize: 12),
            //         ),
            //         child: Row(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             Icon(Icons.list, size: 16),
            //             SizedBox(width: 6),
            //             Text('All'),
            //           ],
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 4.0),
            //       child: ElevatedButton(
            //         onPressed: () {},
            //         style: ElevatedButton.styleFrom(
            //           padding: EdgeInsets.symmetric(
            //             horizontal: 12,
            //             vertical: 8,
            //           ),
            //           textStyle: TextStyle(fontSize: 12),
            //         ),
            //         child: Row(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             Icon(Icons.today, size: 16),
            //             SizedBox(width: 6),
            //             Text('Today'),
            //           ],
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 4.0),
            //       child: ElevatedButton(
            //         onPressed: () {},
            //         style: ElevatedButton.styleFrom(
            //           padding: EdgeInsets.symmetric(
            //             horizontal: 12,
            //             vertical: 8,
            //           ),
            //           textStyle: TextStyle(fontSize: 12),
            //         ),
            //         child: Row(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             Icon(Icons.schedule, size: 16),
            //             SizedBox(width: 6),
            //             Text('Upcoming'),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Ordenar
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.swap_vert, size: 24, color: Colors.black),
                  label: Text('Ordenar', style: TextStyle(fontSize: 16, color: Colors.black)),
                ),

                // Filtrar with red dot
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.tune, size: 24, color: Colors.black),
                      label: Text(
                        'Filtrar',
                        style: TextStyle(fontSize: 16,color: Colors.black),
                      ),
                    ),
                    // Positioned(
                    //   right: 12,
                    //   top: 6,
                    //   child: Container(
                    //     width: 8,
                    //     height: 8,
                    //     decoration: BoxDecoration(
                    //       color: Colors.red,
                    //       shape: BoxShape.circle,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),

                // Mapa
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.map_outlined, size: 24, color: Colors.black),
                  label: Text('Mapa', style: TextStyle(fontSize: 16,color: Colors.black)),
                ),
              ],
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
