import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';
import 'package:ttrueno_fo827e642a0c4/features/booking/presentation/widget/active_widget.dart';
import 'package:ttrueno_fo827e642a0c4/features/booking/presentation/widget/cancelled_widget.dart';

import '../widget/complete_widget.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Booking',
          style: AppText.xl2Medium_22_500.copyWith(
            color: AppColors.primaryTextblack,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primarybutton,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.primarybutton,
          tabs: [
            Tab(text: 'Active (2)'),
            Tab(text: 'Completed (3)'),
            Tab(text: 'Cancelled (1)'),
          ],
        ),
      ),
      body: TabBarView(
        
        controller: _tabController,
        children: [
          ActiveWidget(),
          CompleteWidget(),
          CancelledWidget(),
        ],
      ),
    );
  }
}
