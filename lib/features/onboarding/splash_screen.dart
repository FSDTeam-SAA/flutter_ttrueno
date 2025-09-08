import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/features/onboarding/onboarding1.dart';

import '../../bottom_nabar_page.dart';
import '../../core/services/app_services.dart';
import '../../core/services/debug/debug_service.dart';
import '../../core/services/network/auth/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
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
      backgroundColor: Colors.black,
    );
  }
}
