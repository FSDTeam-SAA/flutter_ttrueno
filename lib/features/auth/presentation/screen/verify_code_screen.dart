import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ttrueno_fo827e642a0c4/core/Button/button_widget.dart';
import 'package:ttrueno_fo827e642a0c4/features/auth/presentation/screen/create_new_password_screen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gap.dart';
import '../../../../core/theme/text_style.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final TextEditingController _otpController = TextEditingController();
  int _secondsRemaining = 59;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      } 
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Verify Code",
                    style: AppText.xxxlSemiBold_32_600.copyWith(
                      color: AppColors.primaryTextblack,
                    ),
                  ),
                  Gap.h8,
                  Align(
                    //alignment: Alignment.start,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: AppText.smRegular_14_400.copyWith(
                          color: AppColors.secondaryText,
                        ),
                        children: [
                          TextSpan(
                            text:
                                "Please enter the code we just sent to Phone Number",
                            style: AppText.mdRegular_16_400.copyWith(
                              color: AppColors.secondaryTextblack,
                            ),
                          ),
                          TextSpan(
                            text: "Alberxxx@gmail.com",
                            style: AppText.mdSemiBold_16_600.copyWith(
                              color: AppColors.primaryTextblack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap.h24,
          
                  PinCodeTextField(
                    appContext: context,
                    controller: _otpController,
                    length: 4,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.none,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(16),
                      fieldHeight: 58,
                      fieldWidth: 58,
                      activeFillColor: Colors.grey.shade100,
                      inactiveFillColor: Colors.grey.shade100,
                      selectedFillColor: Colors.white,
                      inactiveColor: Colors.grey.shade100,
                      selectedColor: Colors.blue,
                      activeColor: Colors.blue,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    onChanged: (_) {},
                  ),
          
                  Gap.h8,
                  Text(
                    "Resend code in 00:${_secondsRemaining.toString().padLeft(2, '0')}",
                    style: AppText.smRegular_14_400.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap.h24,
          
                  context.primaryButton(
                    width: double.infinity,
                    onPressed: () {
                      if (_otpController.text.trim().length != 4) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter the 4-digit code'),
                          ),
                        );
                        return;
                      }
          
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateNewPasswordScreen(),
                        ),
                      );
                    },
                    text: 'Continue',
                  ),
          
                  Gap.h24,
          
                  // Number Pad (optional if using TextInputType.none)
                  _buildNumberPad(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNumberPad() {
    final List<String> keys = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      ".",
      "0",
      "⌫",
    ];

    return GridView.builder(
      shrinkWrap: true,
      itemCount: keys.length,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      itemBuilder: (context, index) {
        final key = keys[index];
        return InkWell(
          onTap: () {
            if (key == "⌫") {
              if (_otpController.text.isNotEmpty) {
                _otpController.text = _otpController.text.substring(
                  0,
                  _otpController.text.length - 1,
                );
              }
            } else if (_otpController.text.length < 4) {
              _otpController.text += key;
            }
            setState(() {});
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: key == "⌫"
                ? const Icon(Icons.backspace_outlined, color: Colors.black)
                : Text(
                    key,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
