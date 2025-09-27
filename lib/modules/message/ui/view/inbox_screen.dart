import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/widgets/cache/smart_network_image.dart';
import 'package:ttrueno_fo827e642a0c4/core/helpers/extensions.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';
import 'package:ttrueno_fo827e642a0c4/modules/message/ui/view/message_screen.dart';

import '../../../../core/common/controller/inbox_controller.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> with AutomaticKeepAliveClientMixin{
  
  late final InboxController chatListController;
  double chatHeadWidthOffsetFromLeft({required double containerWidth, required double chatHeadDiameter, required int index, required int totalItems}) {
    final minOverLayOffset = 16;
    final togetherHeadsWidth = (chatHeadDiameter * totalItems) - (minOverLayOffset * (totalItems - 1));
    debugPrint("togetherHeadsWidth: $togetherHeadsWidth, containerWidth: $containerWidth");
    final minusVal = togetherHeadsWidth - containerWidth;
    final finalOverlayOffset = minOverLayOffset + ((minusVal <= 0) ? 0 : (minusVal / max(1, (totalItems - 1))));
    final double emptySpace = containerWidth - ((totalItems * chatHeadDiameter) - ((totalItems - 1) * finalOverlayOffset));
    final double leftOffset = emptySpace + ((index * chatHeadDiameter) - (max(0, (index)) * finalOverlayOffset));
    debugPrint("leftOffset: $leftOffset");
    return leftOffset;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatListController = Get.find<InboxController>();
    chatListController.init();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          'Inbox'.tr(),
          style: AppText.xl2Medium_22_500.copyWith(
            color: AppColors.primaryTextblack,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(()=>
        ListView.separated(
          itemCount: chatListController.rideChats.length,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          separatorBuilder: (context, index) =>
              Divider(height: 1, color: Colors.grey.shade300),
          itemBuilder: (context, index) {
            final rideChat = chatListController.rideChats[index];
            final participants = chatListController.rideChats[index].participants;
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MessageScreen(
                    activeRideChatController: rideChat,
                  )),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text Section
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          
                          spacing: 4,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: constraints.maxWidth * 0.6,
                                  child: Row(
                                    spacing: 6,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(child: Text(rideChat.ride.value.startLocation.address ?? "..", maxLines: 2, style: TextStyle(fontSize: 18, color: AppColors.primaryTextblack),)),
                                      
                                      Text("To ".tr(),style: TextStyle(fontSize: 18, color: AppColors.primaryTextblack),),
                                      
                                      Flexible(child: Text(rideChat.ride.value.endLocation.address ?? "..", maxLines: 2, style: TextStyle(fontSize: 18, color: AppColors.primaryTextblack),)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: constraints.maxWidth * 0.4,
                                  height: 50,
                                  child: Stack(
                                    children: List.generate(participants.length, (i) {
                                      return Positioned(
                                          left: chatHeadWidthOffsetFromLeft(
                                            containerWidth: constraints.maxWidth * 0.4,
                                            chatHeadDiameter: 48,
                                            index: i,
                                            totalItems: participants.length,
                                          ),
                                        child: SmartNetworkImage.circle(
                                          diameter: 48,
                                          imageUrl: participants[i].profileImage,
                                        )
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                            Flexible(
                              child: Row(
                                children: [
                                  Text(
                                    DateFormat.MMMEd().format(rideChat.ride.value.departureTime), style: TextStyle(fontSize: 16, color: AppColors.primaryTextblack),
                                  ),
                                  Gap.w12,
                                  Text(
                                    DateFormat.Hm().format(rideChat.ride.value.departureTime),style: TextStyle(fontSize: 16, color: AppColors.primaryTextblack),
                                  ),
                                ],
                              ),
                            ),
                            
                            SizedBox(
                              width: constraints.maxWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Row(
                                      children: [
                                        // Icon(
                                        //   Icons.done_all,
                                        //   size: 16,
                                        //   color: Colors.deepPurple,
                                        // ),
                                        // SizedBox(width: 4),
                                        Flexible(
                                          child: Obx(
                                            ()=> Text(
                                              (rideChat.messages.isNotEmpty) ? rideChat.messages.last.message : "...",
                                              maxLines: 2,
                                              style: AppText.lgMedium_18_400.copyWith(
                                                color: AppColors.secondaryTextblack,
                                              ),
                                            ),
                                          ),
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      rideChat.messages.isNotEmpty
                                          ? rideChat.messages.first.updatedAt
                                                .toChatTimeString()
                                          : '..:.. am/pm',
                                      style: TextStyle(fontSize: 12, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
