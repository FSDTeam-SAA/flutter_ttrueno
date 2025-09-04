// import 'package:flutter/material.dart';
// import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';

// class FaqScreen extends StatelessWidget {
//   const FaqScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final faqs = [
//       {
//         'question': 'What is HopLift?',
//         'answer':
//             'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
//       },
//       {
//         'question': 'Is the HopLift App free?',
//         'answer': 'Yes, the app is free to download and use with basic features.'
//       },
//       {
//         'question': 'How do I share ride?',
//         'answer': 'You can share a ride by clicking on the "Share Ride" button in the app.'
//       },
//       {
//         'question': 'How can I log out from Hoplift?',
//         'answer': 'Go to your profile and tap "Logout" at the bottom of the screen.'
//       },
//       {
//         'question': 'How to close Hoplift account?',
//         'answer': 'Contact our support team to request account closure.'
//       },
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('FAQ'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios),
//           onPressed: () => Navigator.pop(context),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: ListView.builder(
//         padding: EdgeInsets.all(16),
//         itemCount: faqs.length,
//         itemBuilder: (context, index) {
//           final item = faqs[index];
//           return Container(
//             margin:  EdgeInsets.only(bottom: 12),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(color: Colors.grey.shade300),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.06),
//                   blurRadius: 8,
//                   offset: Offset(0, 4),
//                 )
//               ],
//             ),
//             child: ExpansionTile(
//               tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//               collapsedIconColor: Colors.blue,
//               iconColor: Colors.blue,
//               title: Text(
//                 item['question']!,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.primaryTextblack,
//                 ),
//               ),
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   child: Text(
//                     item['answer']!,
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black54),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = [
      {
        'question': 'What is HopLift?',
        'answer':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
      },
      {
        'question': 'Is the HopLift App free?',
        'answer': 'Yes, the app is free to download and use with basic features.'
      },
      {
        'question': 'How do I share ride?',
        'answer': 'You can share a ride by clicking on the "Share Ride" button in the app.'
      },
      {
        'question': 'How can I log out from Hoplift?',
        'answer': 'Go to your profile and tap "Logout" at the bottom of the screen.'
      },
      {
        'question': 'How to close Hoplift account?',
        'answer': 'Contact our support team to request account closure.'
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.white, // ✅ set your custom background
      appBar: AppBar(
        title: Text('FAQ',style: AppText.lgMedium_18_500.copyWith(
            color: AppColors.primaryTextblack,
          ),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: AppColors.white, // ✅ consistent background
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: faqs.length,
          itemBuilder: (context, index) {
            final item = faqs[index];
            return Container(
              margin: EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.06),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: ExpansionTile(
                tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                collapsedIconColor: Colors.blue,
                iconColor: Colors.blue,
                title: Text(
                  item['question']!,
                  style: AppText.mdSemiBold_16_600.copyWith(
                    color: AppColors.primaryTextblack,)
                ),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      item['answer']!,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
