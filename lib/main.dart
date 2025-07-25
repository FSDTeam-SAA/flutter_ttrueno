// import 'package:flutter/material.dart';
// import 'package:ttrueno_fo827e642a0c4/bottom_nabar_page.dart';
// import 'package:ttrueno_fo827e642a0c4/core/theme/app_theme.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: AppTheme.dark,
//       home: BottomNabarScreen(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_theme.dart';
import 'package:ttrueno_fo827e642a0c4/features/onboarding/onboarding1.dart';

import 'features/auth/presentation/widget/background_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.light,
      builder: (context, child) {
        return BackgroundWidget(child: child ?? SizedBox());
      },
      home:
          OnboardingScreen(), //BookingApp   OnboardingScreen  BookingScreen2  BookingScreen1
    );
  }
}
