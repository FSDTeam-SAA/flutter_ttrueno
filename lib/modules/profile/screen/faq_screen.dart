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
            'HopLift connects you with people heading in the same direction, allowing you to share rides in taxis or other ride services and split the cost.',
      },
      {
        'question': 'Is the HopLift App free?',
        'answer':
            'Yes, HopLift is free to download and use. You only pay for your share of the ride, which you book and pay for outside of the app.',
      },
      {
        'question': 'How do I join or create a ride?',
        'answer':
            'Simply enter your destination and desired departure time to see a list of matching rides. You can either join an existing ride or create a new one for others to join.',
      },
      {
        'question': 'How do filters work when searching for rides?',
        'answer':
            'After your initial search, you can tap the filter icon to adjust your search parameters. You can modify the flexibility of your departure and arrival times, as well as the pickup and drop-off locations, to find the best match for your needs.',
      },
      {
        'question': 'Can I choose who joins my ride?',
        'answer':
            'Currently, any user can join a ride as long as there are available seats.',
      },
      {
        'question': 'How do I chat with my ride group?',
        'answer':
            "Once you've joined a ride, a group chat will be available. You can access it through your inbox or the 'Bookings' section of the app.",
      },
      {
        'question': 'Luggage',
        'answer':
            "When you join a ride, you can specify the type of luggage you're traveling with. This is for informational purposes, so it's always a good idea to confirm with your fellow riders in the group chat to ensure there will be enough space for everyone's belongings. You can update your luggage information at any time from within the chat.",
      },
      {
        'question': 'Can I leave a ride group after joining or create it?',
        'answer':
            "Yes. If you created a ride and no one has joined yet, you can tap 'Leave Ride' to delete it. If you've joined an existing ride, or if others have joined the ride you created, you can leave by tapping the icon in the top right corner of the chat screen.",
      },
      {
        'question': 'How Can I delete a ride',
        'answer':
            "You can only delete a ride you've created if no one else has joined. To do so, tap the'Leave Ride' button in the chat. If others have joined, you can no longer delete theride, but you can leave the group.",
      },
      {
        'question': 'Can I remove users from a trip?',
        'answer':
            'Yes. In the chat, press and hold the profile picture of the user you wish to remove. A confirmation message will appear. At least half of the other riders in the group must confirm the removal for the user to be removed',
      },
      {
        'question': 'Can I rate other users?',
        'answer':
            'Yes, after your trip is complete, you will be prompted to rate your fellow riders on a scale of 1 to 5 stars.',
      },
      {
        'question': 'What if no one joins my ride?',
        'answer':
            'If no one joins your ride by the departure time, the ride will be automatically canceled. You will receive a notification so you can make alternative travel arrangements.',
      },
      {
        'question': 'How can I log out from Hoplift?',
        'answer':
            'Go to your "Profile," tap "Settings," and then select "Log Out" at the bottom of the screen.',
      },
      {
        'question': 'How do I delete my account?',
        'answer':
            'In "Settings, " select "Delete Account. " Please note that this action is permanent and will remove your profile and all associated data.',
      },
      {
        'question': 'Is my personal data safe?',
        'answer':
            "We are committed to protecting your personal data. We collect information necessary to provide our service, such as your name, contact information, and ride history. This data is used to improve your experience, ensure your safety, and for communication purposes. We have security measures in place to protect your information, and we do not sell your personal data to third parties. For more detailed information, please review our full Privacy Policy in the app's settings.",
      },
      {
        'question': 'What should I do if I have a problem with another user?',
        'answer':
            'If you have an issue with another user, you can report them through their profile. We take all reports seriously and will investigate accordingly. For emergencies, please contact local authorities immediately.',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'FAQ',
          style: AppText.lgMedium_18_500.copyWith(
            color: AppColors.primaryTextblack,
          ),
        ),
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
                  ),
                ],
              ),
              child: ExpansionTile(
                tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                collapsedIconColor: Colors.blue,
                iconColor: Colors.blue,
                title: Text(
                  item['question']!,
                  style: AppText.mdSemiBold_16_600.copyWith(
                    color: AppColors.primaryTextblack,
                  ),
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
