import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';
import 'package:ttrueno_fo827e642a0c4/modules/message/ui/view/message_screen.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  final List<List<String>> userGroups = const [
    ['user1.png', 'user2.png', 'user3.png', 'user5.png'],
    ['user4.png', 'user5.png', 'user1.png', 'user1.png'],
    ['user7.png', 'user3.png', 'user4.png', 'user1.png'],
    ['user7.png', 'user6.png', 'user2.png', 'user1.png'],
  ];

  @override
  Widget build(BuildContext context) {
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
      body: ListView.separated(
        itemCount: userGroups.length,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        separatorBuilder: (context, index) =>
            Divider(height: 1, color: Colors.grey.shade300),
        itemBuilder: (context, index) {
          final groupUsers = userGroups[index];

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MessageScreen()),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Dhaka",style: TextStyle(fontSize: 18, color: AppColors.primaryTextblack),),
                            Gap.w12,
                            Text("To ".tr(),style: TextStyle(fontSize: 18, color: AppColors.primaryTextblack),),
                            Gap.w12,
                            Text("Islamabad",style: TextStyle(fontSize: 18, color: AppColors.primaryTextblack),),
                          ],
                        ),
                        Gap.h4,
                        Row(
                          children: [
                            Text(
                              "01/09/2025",style: TextStyle(fontSize: 16, color: AppColors.primaryTextblack),
                            ),
                            Gap.w12,
                            Text(
                              "06:10 am",style: TextStyle(fontSize: 16, color: AppColors.primaryTextblack),
                            ),
                          ],
                        ),
                        Gap.h4,
                        Row(
                          children: [
                            Icon(
                              Icons.done_all,
                              size: 16,
                              color: Colors.deepPurple,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Okay Thanks!',
                              style: AppText.lgMedium_18_400.copyWith(
                                color: AppColors.secondaryTextblack,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gap.w12,
                  Column(
                    children: [
                      SizedBox(
                        height: 44,
                        width: (groupUsers.length - 1) * 16 + 64,
                        child: Stack(
                          children: List.generate(groupUsers.length, (i) {
                            return Positioned(
                              left: i * 24.0,
                              child: CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage(
                                  'assets/images/${groupUsers[i]}',
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      Gap.h8,
                      Text(
                        '06:10 am',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
