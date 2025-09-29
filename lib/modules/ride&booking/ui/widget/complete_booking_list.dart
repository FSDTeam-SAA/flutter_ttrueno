
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/widgets/ride_card_widget.dart';
import '../../model/booking.dart';
import '../view/share_experience_screen.dart';


class CompleteWidget extends StatefulWidget {
  final RxList<Booking> bookings;
  const CompleteWidget({super.key, required this.bookings});

  @override
  State<CompleteWidget> createState() => _CompleteWidgetState();
}

class _CompleteWidgetState extends State<CompleteWidget> {

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
            return RideCard.fromRide(widget.bookings[index].ride, allowJoin: false,);
          },
        )
      ),
    
    );
  }
}
