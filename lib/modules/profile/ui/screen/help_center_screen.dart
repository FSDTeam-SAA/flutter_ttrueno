import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  void _navigateTo(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Scaffold()),
    );
  }

  Widget buildButton({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return InkWell(
      onTap: () => _navigateTo(context, title),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            SizedBox(width: 16),
            Text(
              title,
              style: AppText.mdSemiBold_16_600.copyWith(
                color: AppColors.primaryTextblack,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // ✅ background color added
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          'Help Center',
          style: AppText.lgMedium_18_500.copyWith(
            color: AppColors.primaryTextblack,
          ),
        ),
        leading: BackButton(color: Colors.black),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: AppColors.background, // ✅ consistent background
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            buildButton(
              context: context,
              icon: Icons.headset_mic_outlined,
              title: 'Contact us',
              color: AppColors.primarybutton,
            ),
            buildButton(
              context: context,
              icon: Icons.phone_android_outlined,
              title: 'WhatsApp',
              color: AppColors.primarybutton,
            ),
            buildButton(
              context: context,
              icon: Icons.camera_alt_outlined,
              title: 'Instagram',
              color: AppColors.primarybutton,
            ),
            buildButton(
              context: context,
              icon: Icons.facebook,
              title: 'Facebook',
              color: AppColors.primarybutton,
            ),
            buildButton(
              context: context,
              icon: Icons.alternate_email,
              title: 'Twitter',
              color: AppColors.primarybutton,
            ),
            buildButton(
              context: context,
              icon: Icons.language,
              title: 'Website',
              color: AppColors.primarybutton,
            ),
          ],
        ),
      ),
    );
  }
}
