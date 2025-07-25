import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/Button/button_widget.dart';

import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';

class PasswordSuccessScreen extends StatefulWidget {
  const PasswordSuccessScreen({super.key});

  @override
  State<PasswordSuccessScreen> createState() => _PasswordSuccessScreenState();
}

class _PasswordSuccessScreenState extends State<PasswordSuccessScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),

                SizedBox(
                  height: 250,
                  width: 250,
                  child: Image.asset(
                    "assets/images/Success.png",
                    fit: BoxFit.contain,
                  ),
                ),

                // Title
                Text(
                  "Password Changed",
                  style: AppText.xxlSemiBold_24_600.copyWith(
                    color: AppColors.primaryTextblack,
                  ),
                  textAlign: TextAlign.center,
                ),

                Gap.h16,

                // Subtitle
                Text(
                  "Password changed successfully, you can login again with a new password",
                  style: AppText.smRegular_14_400.copyWith(
                    color: AppColors.secondaryTextblack,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),

                const Spacer(),

                context.primaryButton(
                  width: double.infinity,
                  onPressed: () {
                    _handleSignInNow();
                  },
                  text: 'Sign In Now',
                ),
                Gap.h32,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSignInNow() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
