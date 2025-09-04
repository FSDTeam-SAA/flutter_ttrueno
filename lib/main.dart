// import 'package:flutter/material.dart';
// import 'package:ttrueno_fo827e642a0c4/core/theme/app_theme.dart';
// import 'package:ttrueno_fo827e642a0c4/features/onboarding/onboarding1.dart';

// import 'features/auth/presentation/widget/background_image.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: AppTheme.light,
//       builder: (context, child) {
//         return BackgroundWidget(child: child ?? SizedBox());
//       },
//       home:
//           OnboardingScreen(), //BookingApp   OnboardingScreen  BookingScreen2  BookingScreen1
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme/app_theme.dart';
import 'features/onboarding/onboarding1.dart';
import 'features/auth/presentation/widget/background_image.dart';
import 'features/onboarding/splash_screen.dart';
import 'init_dependency.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initDependencies();

  // Load saved locale from SharedPreferences (language only, no country)
  final prefs = await SharedPreferences.getInstance();
  final langCode = prefs.getString('lang_code') ?? 'en';

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('ar'),
        Locale('bn'),
        Locale('gr'),
        Locale('bs'),
        Locale('de'),
        Locale('el'),
        Locale('en'),
        Locale('es'),
        Locale('fr'),
        Locale('hi'),
        Locale('hu'),
        Locale('id'),
        Locale('it'),
        Locale('ja'),
        Locale('ko'),
        Locale('nl'),
        Locale('pl'),
        Locale('pt'),
        Locale('ro'),
        Locale('ru'),
        Locale('sq'),
        Locale('sw'),
        Locale('th'),
        Locale('zh'),
        Locale('zu'),
      ],
      path: 'assets/lang',
      fallbackLocale: Locale('en'),
      startLocale: Locale(langCode),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.light,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      builder: (context, child) {
        return BackgroundWidget(child: child ?? const SizedBox());
      },
      home: SplashScreen()
    );
  }
}
