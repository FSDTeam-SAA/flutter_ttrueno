import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/controller/my_booking_controller.dart';
import '../../../../core/common/widgets/ride_card_widget.dart';
import '../../model/booking.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final MyBookingController myBookingController = Get.find<MyBookingController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    myBookingController.myBookings();
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
          'Booking'.tr(),
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
            Tab(text: 'Active'.tr()),
            Tab(text: 'Completed'.tr()),
            //Tab(text: 'Cancelled'.tr()),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _ActiveBookingList(bookings: myBookingController.activeBookings,),
          _CompletedBookingList(
            bookings: myBookingController.completedBookings,
          ),
        ],
      ),
    );
  }
}



class _ActiveBookingList extends StatefulWidget {
  final RxList<Booking> bookings;
  const _ActiveBookingList({super.key, required this.bookings});

  @override
  State<_ActiveBookingList> createState() => _ActiveBookingListState();
}

class _ActiveBookingListState extends State<_ActiveBookingList> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      body: Obx(
        () => ListView.builder(
          itemCount: widget.bookings.length,
          itemBuilder: (context, index) {
            final booking = widget.bookings[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: RideCard.fromRide(
                widget.bookings[index].ride,
                allowJoin: true,
                elevation: 2,
              ),
            );
          },
        )
      ),
    
    );
  }
}


class _CompletedBookingList extends StatefulWidget {
  final RxList<Booking> bookings;
  const _CompletedBookingList({super.key, required this.bookings});

  @override
  State<_CompletedBookingList> createState() => _CompletedBookingListState();
}

class _CompletedBookingListState extends State<_CompletedBookingList> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      body: Obx(
        () => ListView.builder(
          itemCount: widget.bookings.length,
          itemBuilder: (context, index) {
            final booking = widget.bookings[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: RideCard.fromRide(
                widget.bookings[index].ride,
                allowJoin: false,
                elevation: 2,
              ),
            );
          },
        )
      ),
    
    );
  }
}
