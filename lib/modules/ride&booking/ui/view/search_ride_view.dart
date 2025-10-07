import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/widgets/reactive_buttons/save_button.dart';
import 'package:ttrueno_fo827e642a0c4/core/notifiers/snackbar_notifier.dart';
import 'package:ttrueno_fo827e642a0c4/modules/notification/screen/notification_screen.dart';
import 'package:ttrueno_fo827e642a0c4/modules/profile/controller/profile_data_controller.dart';
import 'package:ttrueno_fo827e642a0c4/modules/profile/ui/widget/greeting_user_widget.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/controller/search_and_filter_controller.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/ui/view/create_ride_view.dart';
import 'package:ttrueno_fo827e642a0c4/modules/ride&booking/ui/view/search_result_view.dart';
import '../../../../core/notifiers/button_status_notifier.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gap.dart';
import '../../../../core/theme/text_style.dart';
import '../widget/location_input.dart';

class SearchScreenView extends StatefulWidget {
  const SearchScreenView({super.key});

  @override
  State<SearchScreenView> createState() => _SearchScreenViewState();
}

class _SearchScreenViewState extends State<SearchScreenView> with AutomaticKeepAliveClientMixin{
  late final SearchRideController searchRideController;
  final ProcessStatusNotifier processStatusNotifier = ProcessStatusNotifier(initialStatus: EnabledStatus());
  
  int passengers = 1;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    debugPrint('SearchScreenView initState');
    searchRideController = Get.find<SearchRideController>();    
    Get.find<ProfileDataController>().getCurrentUserProfile();
  }

  @override
  void dispose() {
    //searchRideController.dispose();
    // _dateController.dispose();
    // _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/1111111.png',
              fit: BoxFit.cover,
              gaplessPlayback: true,
            ),
          ),
          // Greeting section
          Positioned(
            top: 60,
            left: 24,
            right: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GreetingUserWidget(),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.notifications_none,
                        size: 28,
                        color: AppColors.primaryTextblack,
                      ),
                    ),
                  ],
                ),
                Gap.h4,
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Welcome back to'.tr(),
                        style: TextStyle(color: AppColors.primaryTextblack),
                      ),
                      TextSpan(
                        text: ' ',
                        style: TextStyle(color: AppColors.primaryTextblack),
                      ),
                      TextSpan(
                        text: 'Hoplift'.tr(),
                        style: TextStyle(color: AppColors.primaryTextblack),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.62,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 0,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap.h32,
                          LocationInputs(
                            fromController: searchRideController.fromController,
                            toController: searchRideController.toController,
                            onSelectingFromLocation: (locationAddress) {
                              searchRideController.fromLocation = locationAddress;
                            },
                            onSelectingToLocation: (locationAddress) {
                              searchRideController.toLocation = locationAddress;
                            },
                          ),
                          Gap.h24,
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: searchRideController.dateController,
                                  readOnly: true,
                                  onTap:() => searchRideController.selectDate(context),
                                  decoration: InputDecoration(
                                    prefixIcon: IconButton(
                                      icon: const Icon(
                                        Icons.calendar_today_outlined,
                                      ),
                                      onPressed:() => searchRideController.selectDate(context),
                                    ),
                                    hintText: 'Date'.tr(),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
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
                              Gap.w8,
                              Expanded(
                                child: TextField(
                                  controller: searchRideController.timeController,
                                  readOnly: true,
                                  onTap:()async => searchRideController.selectTime(context),
                                  decoration: InputDecoration(
                                    prefixIcon: IconButton(
                                      icon: const Icon(
                                        Icons.watch_later_outlined,
                                      ),
                                      onPressed:()async => searchRideController.selectTime(context),
                                    ),
                                    hintText: 'Time'.tr(),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 20,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
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
                          Gap.h16,
                          Row(
                            children: [
                              const Icon(Icons.person_outline, size: 28),
                              Gap.w12,
                              Text(
                                "Passengers".tr(),
                                style: AppText.mdRegular_16_400.copyWith(
                                  color: AppColors.primaryTextblack,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  searchRideController.decrementPassengers();
                                },
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                              Container(
                                height: 35,
                                width: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey[200]!,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                alignment: Alignment.center,
                                child: Obx(
                                  ()=> Text(
                                    '${searchRideController.passengers.value}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  searchRideController.incrementPassengers();
                                },
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                            ],
                          ),
                          Gap.h24,
                          ///////////
                          RSaveButton(
                            key: UniqueKey(),
                            saveText: 'Search'.tr(),
                            loadingText: "Search".tr(),
                            buttonStatusNotifier: processStatusNotifier,
                            onSaveTap: () => searchRideController.searchRide(
                              snackbarNotifier: SnackbarNotifier(context: context),
                              processStatusNotifier: processStatusNotifier,
                            ),
                            onDone: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchResultsView(),
                                ),
                              );
                            },
                          ),
                          
                          Gap.h16,
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateRideView(),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              side: BorderSide(color: AppColors.primarybutton),
                            ),
                            child: Text(
                              'Create Ride'.tr(),
                              style: AppText.lgMedium_18_500.copyWith(
                                color: AppColors.primarybutton,
                              ),
                            ),
                          ),
                          Gap.h24,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
