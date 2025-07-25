// // file: reusable_text_field.dart
// import 'package:flutter/material.dart';

// class ReusableTextField extends StatelessWidget {
//   final String hintText;
//   final IconData prefixIcon;
//   final TextEditingController controller;
//   final bool obscureText;
//   final Widget? suffixIcon;
//   final String? Function(String?)? validator;

//   const ReusableTextField({
//     super.key,
//     required this.hintText,
//     required this.prefixIcon,
//     required this.controller,
//     this.obscureText = false,
//     this.suffixIcon,
//     this.validator,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       obscureText: obscureText,
//       validator: validator,
//       decoration: InputDecoration(
//         hintText: hintText,
//         prefixIcon: Icon(prefixIcon),
//         suffixIcon: suffixIcon,
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';

class ReusableTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const ReusableTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.secondaryText, fontSize: 14),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(color: AppColors.primarybutton, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(color: AppColors.primarybutton, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(color: AppColors.primarybutton, width: 2),
        ),
        errorStyle: TextStyle(
          color: AppColors.primarybutton,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
