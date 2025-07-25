// import 'package:flutter/material.dart';
// import 'package:ttrueno_fo827e642a0c4/core/Button/button_widget.dart';
// import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
// import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';
// import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';
// import 'package:ttrueno_fo827e642a0c4/features/auth/presentation/screen/verify_code_screen.dart';

// class ForgotPasswordScreen extends StatefulWidget {
//   const ForgotPasswordScreen({super.key});

//   @override
//   State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
// }

// class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
//   int? _selectedMethod = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 margin: const EdgeInsets.only(top: 20),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
//                 ),
//                 padding: const EdgeInsets.all(24.0),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Gap.h16,
//                       Text(
//                         "Forgot Password",
//                         style: AppText.xxxlSemiBold_32_600.copyWith(
//                           color: AppColors.primaryTextblack,
//                           fontSize: 28,
//                         ),
//                       ),
//                       Gap.h8,
//                       Text(
//                         "Select verification method and we will send verification code",
//                         style: AppText.smRegular_14_400.copyWith(
//                           color: AppColors.secondaryTextblack,
//                           height: 1.4,
//                         ),
//                       ),
//                       Gap.h32,
//                       _buildOptionCard(
//                         icon: Icons.email_outlined,
//                         title: 'Email',
//                         subtitle: '******@gmail.com',
//                         value: 0,
//                       ),
//                       Gap.h16,
//                       _buildOptionCard(
//                         icon: Icons.phone_outlined,
//                         title: 'Phone Number',
//                         subtitle: '**** **** **** 3489',
//                         value: 1,
//                       ),
//                       // Instead of Spacer(), add SizedBox for spacing before button
//                       Gap.h32,
//                       // SizedBox(
//                       //   width: double.infinity,
//                       //   height: 51,
//                       //   child: ElevatedButton(
//                       //     onPressed: () {
//                       //       Navigator.push(
//                       //         context,
//                       //         MaterialPageRoute(
//                       //           builder: (context) => const VerifyCodeScreen(),
//                       //         ),
//                       //       );
//                       //     },
//                       //     style: ElevatedButton.styleFrom(
//                       //       backgroundColor: AppColors.primarybutton,
//                       //       foregroundColor: Colors.white,
//                       //       elevation: 0,
//                       //       shape: RoundedRectangleBorder(
//                       //         borderRadius: BorderRadius.circular(32),
//                       //       ),
//                       //     ),
//                       //     child: const Text(
//                       //       'Send Link',
//                       //       style: TextStyle(
//                       //         fontSize: 16,
//                       //         fontWeight: FontWeight.w600,
//                       //       ),
//                       //     ),
//                       //   ),
//                       // ),
                      // context.primaryButton(
                      //   width: double.infinity,
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => VerifyCodeScreen(),
                      //       ),
                      //     );
                      //   },
                      //   text: 'Send Link',
                      // ),
                      // Gap.h24,
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOptionCard({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required int value,
//   }) {
//     final isSelected = _selectedMethod == value;

//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _selectedMethod = value;
//         });
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: isSelected
//                 ? AppColors.primarybutton
//                 : const Color(0xFFE5E5E5),
//             width: isSelected ? 2 : 1,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.04),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF8F9FA),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(icon, color: const Color(0xFF666666), size: 24),
//             ),
//             Gap.w16,
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: AppText.mdSemiBold_16_600.copyWith(
//                       color: AppColors.primaryTextblack,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     subtitle,
//                     style: AppText.smRegular_14_400.copyWith(
//                       color: AppColors.secondaryText,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               width: 24,
//               height: 24,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: isSelected
//                       ? AppColors.primarybutton
//                       : const Color(0xFFE5E5E5),
//                   width: 2,
//                 ),
//                 color: isSelected
//                     ? AppColors.primarybutton
//                     : Colors.transparent,
//               ),
//               child: isSelected
//                   ? const Icon(Icons.check, color: Colors.white, size: 16)
//                   : null,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';
import 'package:ttrueno_fo827e642a0c4/features/auth/presentation/screen/verify_code_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int? _selectedMethod = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap.h16,
                      Text(
                        "Forgot Password",
                        style: AppText.xxxlSemiBold_32_600.copyWith(
                          color: AppColors.primaryTextblack,
                          fontSize: 28,
                        ),
                      ),
                      Gap.h8,
                      Text(
                        "Select verification method and we will send verification code",
                        style: AppText.smRegular_14_400.copyWith(
                          color: AppColors.secondaryTextblack,
                          height: 1.4,
                        ),
                      ),
                      Gap.h32,
                      _buildOptionCard(
                        icon: Icons.email_outlined,
                        title: 'Email',
                        subtitle: '******@gmail.com',
                        value: 0,
                      ),
                      Gap.h16,
                      _buildOptionCard(
                        icon: Icons.phone_outlined,
                        title: 'Phone Number',
                        subtitle: '**** **** **** 3489',
                        value: 1,
                      ),
                      Gap.h32,
                    ],
                  ),
                ),
              ),
            ),

            // Button fixed at bottom
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VerifyCodeScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primarybutton,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Send Link',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required int value,
  }) {
    final isSelected = _selectedMethod == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = value;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.primarybutton
                : const Color(0xFFE5E5E5),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFF666666), size: 24),
            ),
            Gap.w16,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppText.mdSemiBold_16_600.copyWith(
                      color: AppColors.primaryTextblack,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: AppText.smRegular_14_400.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primarybutton
                      : const Color(0xFFE5E5E5),
                  width: 2,
                ),
                color: isSelected
                    ? AppColors.primarybutton
                    : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
