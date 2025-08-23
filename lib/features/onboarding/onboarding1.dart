import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/Button/button_widget.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';
import 'package:ttrueno_fo827e642a0c4/modules/auth/screen/select_signin_method_screen.dart';
import 'package:ttrueno_fo827e642a0c4/features/onboarding/onboarding2.dart';
import 'package:ttrueno_fo827e642a0c4/modules/auth/screen/signin_screen.dart';

import '../../bottom_nabar_page.dart';
import '../../core/services/app_services.dart';
import '../../core/services/debug/debug_service.dart';
import '../../core/services/network/auth/auth_service.dart';
import '../../core/theme/app_gap.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final Debugger debugger = UIDebugger();
  late Timer timer;
  bool _isLoadingAuth = false;

  _route() async{
    Future.delayed(Duration(seconds: 1)).then((_){
      
    });
    if (mounted && context.mounted) {
        final authStatus = AppServices.authController.authStatus;
        /// Auth status ->>>>
        debugger.dekhao("New auth status >>> ${authStatus.runtimeType}");
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TermsAndConditionView()));
        if(authStatus is AuthLoading) {
          if(!_isLoadingAuth) {
            _isLoadingAuth = true;
            setState(() {
            });
          }
          return _route();
        }
        else if(authStatus is Authenticated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNabarScreen()),
        );
        } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        ); // Auth is null
        }
      }
  }

  @override
  void didChangeDependencies() {
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      debugger.dekhao("calling route");
      timer.cancel();
      _route();
    });
    AppServices.authController.getAuthStream();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    AppServices.authController.getAuthStream();
  }

  @override
  void dispose() {
    if(timer.isActive) {
      timer.cancel();
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Onboarding 1.png',
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
                        MaterialPageRoute(builder: (context) => SelectSigninMethodScreen()),
                      );
                    },
                    child: Text(
                      'Skip'.tr(),
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
                        'Lorum Ipsum\nDummy Text'.tr(),
                        textAlign: TextAlign.center,
                        style: AppText.xxxlSemiBold_40_700.copyWith(
                          color: AppColors.primaryTextblack,
                        ),
                      ),
                      Gap.h16,
                      Text(
                        'Lorem Ipsum is simply dummy text of the\nprinting and typesetting industry'
                            .tr(),
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
                              builder: (context) => OnboardingScreen2(),
                            ),
                          );
                        },
                        text: "Next".tr(),
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
