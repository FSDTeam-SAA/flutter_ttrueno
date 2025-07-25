import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';
import 'package:ttrueno_fo827e642a0c4/features/message/presentation/widget/alart_message_widget.dart';
import 'package:ttrueno_fo827e642a0c4/features/profile/screens/change_password_screen.dart';
import 'package:ttrueno_fo827e642a0c4/features/profile/screens/faq_screen.dart';
import 'package:ttrueno_fo827e642a0c4/features/profile/screens/help_center_screen.dart';
import 'package:ttrueno_fo827e642a0c4/features/profile/screens/language_screen.dart';

import '../../../core/theme/text_style.dart';
import 'account_info_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationEnabled = true;
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'My Profile',
          style: AppText.xl2Medium_22_500.copyWith(
            color: AppColors.primaryTextblack,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(
                          'assets/images/profilepic.png',
                        ),
                      ),
                    ],
                  ),
                  Gap.w16,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Howard Stevan',
                        style: AppText.xxlSemiBold_24_600.copyWith(
                          color: AppColors.primaryTextblack,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '(480) 555-0103',
                        style: AppText.mdRegular_16_400.copyWith(
                          color: AppColors.secondaryText,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'howard@gmail.com',
                        style: AppText.mdRegular_16_400.copyWith(
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Profile Options
              _buildProfileOption(
                context,
                icon: Icons.person_2_outlined,
                title: 'Account info',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountInfoScreen(),
                    ),
                  );
                },
              ),
              // Language
              _buildProfileOption(
                context,
                icon: Icons.language,
                title: 'Language',
                trailingText: selectedLanguage, // now dynamic
                textColor: AppColors.primaryTextblack,
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LanguageSelectionPage(),
                    ),
                  );

                  if (result != null && result is String) {
                    setState(() {
                      selectedLanguage = result; // update selected language
                    });

                    // Optional: show confirmation here instead of inside LanguageSelectionPage
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Language changed to $result',
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
              ),

              Divider(color: Colors.grey.shade300, thickness: 1),

              _buildProfileOption(
                context,
                icon: Icons.settings_outlined,
                title: 'General Setting',
                onTap: () {
                  // Handle general settings
                },
              ),
              _buildProfileOption(
                context,
                icon: Icons.lock_outline,
                title: 'Change Password',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePasswordPage(),
                    ),
                  );
                },
              ),
              _buildProfileOption(
                context,
                icon: Icons.notifications_none,
                title: 'Notification',
                isToggle: true,
                toggleValue: _notificationEnabled,
                onToggleChanged: (value) {
                  setState(() {
                    _notificationEnabled = value;
                  });
                },
              ),
              Divider(color: Colors.grey.shade300, thickness: 1),

              const SizedBox(
                height: 16,
              ), // Add some spacing before next section
              _buildProfileOption(
                context,
                icon: Icons.help_outline,
                title: 'FAQs',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FaqScreen()),
                  );
                },
              ),
              _buildProfileOption(
                context,
                icon: Icons.support_agent_outlined,
                title: 'Help Center',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelpCenterPage()),
                  );
                  // Handle help center
                },
              ),
              _buildProfileOption(
                context,
                icon: Icons.star_border,
                title: 'Rate Us',
                onTap: () {
                  // Handle rate us
                },
              ),
              Gap.h32,
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) => ConfirmActionBottomSheet(
                        message: 'Are you sure you want to logout?',
                        onConfirm: () {
                          Navigator.pop(context); // Close bottom sheet
                          // TODO: Add logout logic here
                        },
                        onCancel: () {},
                        confirmButtonText: 'Logout',
                        cancelButtonText: 'Not Now',
                        height: 200, // You can customize height
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to build individual profile options
  Widget _buildProfileOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? trailingText,
    bool isToggle = false,
    bool toggleValue = false,
    ValueChanged<bool>? onToggleChanged,
    VoidCallback? onTap,
    Color textColor = AppColors.primaryTextblack,
    Color iconColor = AppColors.primaryTextblack,
    Color arrowColor = AppColors.primaryTextblack,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: textColor, // 👈 Apply custom text color
                ),
              ),
            ),
            if (trailingText != null)
              Text(
                trailingText,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            if (isToggle)
              Switch(
                value: toggleValue,
                onChanged: onToggleChanged,
                activeColor: AppColors.primarybutton,
              )
            else
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: AppColors.primaryTextblack,
              ),
          ],
        ),
      ),
    );
  }
}
