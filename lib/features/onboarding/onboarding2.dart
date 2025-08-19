import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/Button/button_widget.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';
import 'package:ttrueno_fo827e642a0c4/features/auth/presentation/screen/login_screen.dart';
import 'package:ttrueno_fo827e642a0c4/features/onboarding/onboarding3.dart';

import '../../core/theme/app_gap.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Onboarding 2.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Gap.w4,

                      Container(
                        width: 28,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.primarybutton,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Gap.w4,
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),

                  // Skip button
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SigninScreen()),
                      );
                    },
                    child: Text(
                      'Skip',
                      style: AppText.smRegular_14_400.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 0,
                ),
                child: Container(
                  padding: const EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Lorum Ipsum\nDummy Text',
                        textAlign: TextAlign.center,
                        style: AppText.xxxlSemiBold_40_700.copyWith(
                          color: AppColors.primaryTextblack,
                        ),
                      ),
                      Gap.h16,
                      Text(
                        'Lorem Ipsum is simply dummy text of the\nprinting and typesetting industry',
                        textAlign: TextAlign.center,
                        style: AppText.smRegular_14_400.copyWith(
                          color: AppColors.secondaryText,
                        ),
                      ),
                      Gap.h32,
                      context.primaryButton(
                        width: double.infinity,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OnboardingScreen3(),
                            ),
                          );
                        },
                        text: "Next",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
