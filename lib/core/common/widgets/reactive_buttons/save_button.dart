import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/helpers/dekhao.dart';
import '../../../notifiers/button_status_notifier.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_sizes.dart';
import 'inkwell_button.dart';

class RSaveButton extends StatefulWidget {
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final TextStyle? style;
  final ButtonStatusNotifier buttonStatusNotifier;
  final String saveText;
  final String loadingText;
  final String errorText;
  final String doneText;
  final VoidCallback onSaveTap;
  final VoidCallback onDone;
  const RSaveButton({
    required super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.style,
    this.saveText = "Save",
    this.loadingText = "Saving",
    this.errorText = "Error",
    this.doneText = "Done",
    required this.buttonStatusNotifier,
    required this.onSaveTap,
    required this.onDone,
  });

  @override
  State<RSaveButton> createState() => _RSaveButtonState();
}

class _RSaveButtonState extends State<RSaveButton> {
  late ButtonStatusNotifier buttonStatusNotifier;

  @override
  void didChangeDependencies() {
    buttonStatusNotifier.addListener(_update);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    buttonStatusNotifier = widget.buttonStatusNotifier;
    super.initState();
  }

  @override
  dispose() {
    buttonStatusNotifier.removeListener(_update);
    super.dispose();
  }

  _update() {
    dekhao("button status is ${buttonStatusNotifier.status}");
    Future.delayed(const Duration(milliseconds: 100)).then((_) {
      if (mounted && context.mounted) {
        setState(() {});
      }
    });
    if (buttonStatusNotifier.status is SuccessStatus) {
      dekhao("Successful save");
      Future.delayed(const Duration(milliseconds: 1000)).then((_) async {
        if (mounted && context.mounted) {
          widget.onDone();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        print(constraints);
        return AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          height: widget.height ?? 52,
          width: widget.width ?? constraints.maxWidth,
          decoration: BoxDecoration(
            color: AppColors.primarybutton,
            borderRadius: widget.borderRadius ?? AppSizes.borderRadiusSmall,
          ),
          child: RInkwellButton(
            borderRadius: widget.borderRadius ?? AppSizes.borderRadiusSmall,
            onTap: () async {
              if (buttonStatusNotifier.status is EnabledStatus) {
                widget.onSaveTap();
              }
            },
            child: Center(
              //key: UniqueKey(),
              child: _buttonText(),
            ),
          ),
        );
      },
    );
  }

  Widget _buttonText() {
    return LayoutBuilder(
      builder: (context, constraints) {
        dekhao("Button status: ${buttonStatusNotifier.status.runtimeType}");
        switch (buttonStatusNotifier.status.runtimeType) {
          case const (EnabledStatus):
            return Text(
              widget.saveText,
              style:
                  widget.style ??
                  TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.buttonTextColor,
                  ),
            );

          case const (DisabledStatus):
            dekhao("Button is disabled");
            return Text(
              widget.saveText,
              style:
                  widget.style ??
                  TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.buttonInactiveTextColor,
                  ),
            );

          case const (LoadingStatus):
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 10),
                Text(
                  widget.loadingText,
                  style:
                      widget.style ??
                      TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.buttonTextColor,
                      ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 4, color: Colors.black,),
                ),
              ],
            );

          case (ErrorStatus):
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error,
                  size: AppSizes.iconSizeMedium,
                  color: Colors.orange,
                ),
                SizedBox(width: 10),
                Text(
                  widget.errorText,
                  style:
                      widget.style ??
                      TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.buttonTextColor,
                      ),
                ),
              ],
            );

          case const (SuccessStatus):
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.done,
                  size: AppSizes.iconSizeMedium,
                  color: AppColors.buttonTextColor,
                ),
                SizedBox(width: 10),
                Text(
                  widget.doneText,
                  style:
                      widget.style ??
                      TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.buttonTextColor,
                      ),
                ),
              ],
            );
          default:
            dekhao("Button status not found");
            return Text(
              "Save",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.buttonInactiveTextColor,
              ),
            );
        }
      },
    );
  }
}




// // //example usage of save button

// import 'package:flutter/material.dart';
// import 'package:ttrueno_fo827e642a0c4/core/widgets/buttons/r_save_button.dart';
// import 'package:ttrueno_fo827e642a0c4/core/notifiers/button_status_notifier.dart';

// class SaveExampleScreen extends StatefulWidget {
//   const SaveExampleScreen({super.key});

//   @override
//   State<SaveExampleScreen> createState() => _SaveExampleScreenState();
// }

// class _SaveExampleScreenState extends State<SaveExampleScreen> {
//   final ButtonStatusNotifier _statusNotifier = ButtonStatusNotifier(EnabledStatus());

//   @override
//   void dispose() {
//     _statusNotifier.dispose();
//     super.dispose();
//   }

//   void _onSave() async {
//     // Set button to loading
//     _statusNotifier.setStatus(LoadingStatus());

//     try {
//       // Simulate async saving
//       await Future.delayed(const Duration(seconds: 2));

//       // Set status to success
//       _statusNotifier.setStatus(SuccessStatus());
//     } catch (e) {
//       _statusNotifier.setStatus(ErrorStatus());
//     }
//   }

//   void _onDone() {
//     // Do something after successful save
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Save completed")),
//     );

//     // Optionally reset the button state
//     _statusNotifier.setStatus(EnabledStatus());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('RSaveButton Demo')),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             const Text("Press the button to simulate save operation."),
//             const SizedBox(height: 40),

//             // RSaveButton usage
//             RSaveButton(
//               buttonStatusNotifier: _statusNotifier,
//               onSaveTap: _onSave,
//               onDone: _onDone,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

