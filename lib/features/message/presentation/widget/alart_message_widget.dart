// import 'package:flutter/material.dart';
// import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';

// class ConfirmActionBottomSheet extends StatelessWidget {
//   final String message;
//   final VoidCallback onConfirm;
//   final VoidCallback onCancel;
//   final double height;
//   final bool showTextField;
//   final TextEditingController? controller;
//   final String? hintText;

//   const ConfirmActionBottomSheet({
//     super.key,
//     required this.message,
//     required this.onConfirm,
//     required this.onCancel,
//     this.height = 150,
//     this.showTextField = false,
//     this.controller,
//     this.hintText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: showTextField ? height + 60 : height,
//       padding: const EdgeInsets.all(24),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             message,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//             textAlign: TextAlign.center,
//           ),
//           if (showTextField)
//             Padding(
//               padding: const EdgeInsets.only(top: 16.0),
//               child: TextField(
//                 controller: controller,
//                 decoration: InputDecoration(
//                   hintText: hintText ?? 'Optional reason...',
//                   border: OutlineInputBorder(),
//                   contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 8,
//                   ),
//                 ),
//               ),
//             ),
//           const SizedBox(height: 16),
//           SizedBox(
//             width: double.infinity,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: SizedBox(
//                     height: 50,
//                     child: OutlinedButton(
//                       style: OutlinedButton.styleFrom(
//                         side: const BorderSide(color: AppColors.primarybutton),
//                         foregroundColor: AppColors.primarybutton,
//                       ),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                         onCancel();
//                       },
//                       child: const Text('Not Now'),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: SizedBox(
//                     height: 50,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.redAccent,
//                         foregroundColor: Colors.white,
//                       ),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                         onConfirm();
//                       },
//                       child: const Text('Kick Out'),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';

class ConfirmActionBottomSheet extends StatelessWidget {
  final String message;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final double height;
  final bool showTextField;
  final TextEditingController? controller;
  final String? hintText;
  final double? textFieldHeight;
  final String confirmButtonText;
  final String cancelButtonText;

  const ConfirmActionBottomSheet({
    super.key,
    required this.message,
    required this.onConfirm,
    required this.onCancel,
    this.height = 150,
    this.showTextField = false,
    this.controller,
    this.hintText,
    this.textFieldHeight,
    this.confirmButtonText = 'Confirm',
    this.cancelButtonText = 'Cancel',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: showTextField ? height + 60 : height,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            maxLines: 2,
            message,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          if (showTextField)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                height: textFieldHeight ?? 50,
                child: TextField(
                  controller: controller,
                  expands: false,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: hintText ?? 'Optional reason...',
                    border: OutlineInputBorder(),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primarybutton),
                        foregroundColor: AppColors.primarybutton,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onCancel();
                      },
                      child: Text(cancelButtonText),

                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onConfirm();
                      },
                      child: Text(confirmButtonText.tr()),

                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




// example usage

// ConfirmActionBottomSheet(
//   message: 'Are you sure?',
//   onConfirm: () {},
//   onCancel: () {},
//   showTextField: true,
//   textFieldHeight: 80, // You control the height here
//   hintText: 'Write your reason here',
// )

