import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/Button/button_widget.dart';
import 'package:ttrueno_fo827e642a0c4/features/auth/presentation/screen/login_screen.dart';
import 'package:ttrueno_fo827e642a0c4/features/auth/presentation/screen/verify_code_screen.dart';
import 'package:ttrueno_fo827e642a0c4/features/auth/presentation/widget/custom_text_field_widget.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gap.dart';
import '../../../../core/theme/text_style.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscure = true;
  bool _agreedToTerms = false; // New state for the checkbox

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Register",
                                style: AppText.xxxlSemiBold_32_600.copyWith(
                                  color: AppColors.primaryText,
                                ),
                              ),
                              Gap.h8,
                              Text(
                                "Create account and enjoy all services.",
                                style: AppText.smRegular_14_400.copyWith(
                                  color: AppColors.primaryText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap.h12,
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Username",
                                style: AppText.mdSemiBold_16_600.copyWith(
                                  color: AppColors.primaryTextblack,
                                ),
                              ),
                              Gap.h8,
                              ReusableTextField(
                                hintText: "Type your username",
                                prefix: Icons.person_2_outlined,
                                controller: usernameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Username is required';
                                  }
                                  return null;
                                }, obscureText: false,
                              ),
                              Gap.h16,
                              Text(
                                "Email",
                                style: AppText.mdSemiBold_16_600.copyWith(
                                  color: AppColors.primaryTextblack,
                                ),
                              ),
                              Gap.h8,
                              ReusableTextField(
                                hintText: "Type your email",
                                prefix: Icons.email_outlined,
                                controller: emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email is required';
                                  }
                                  final emailRegex = RegExp(
                                    r'^[^@]+@[^@]+\.[^@]+',
                                  );
                                  if (!emailRegex.hasMatch(value)) {
                                    return 'Enter a valid email address';
                                  }
                                  return null;
                                }, obscureText: false,
                              ),
                              Gap.h16,
                              Text(
                                "Password",
                                style: AppText.mdSemiBold_16_600.copyWith(
                                  color: AppColors.primaryTextblack,
                                ),
                              ),
                              Gap.h8,
                              ReusableTextField(
                                hintText: "Type your password",
                                prefix: Icons.lock_outline,
                                obscureText: _obscure,
                                controller: passwordController,
                                validator: (value) {
                                  if (value == null || value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscure
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() => _obscure = !_obscure);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Gap.h24, // Added some gap before the checkbox
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 24.0, // Adjust size as needed
                                  height: 24.0, // Adjust size as needed
                                  child: Checkbox(
                                    value: _agreedToTerms,
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        _agreedToTerms = newValue!;
                                      });
                                    },
                                    activeColor: AppColors
                                        .primaryTextblack, // Or your preferred color
                                    checkColor: Colors.white,
                                    materialTapTargetSize: MaterialTapTargetSize
                                        .shrinkWrap, // To reduce extra padding
                                  ),
                                ),
                                Gap.w8,
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      text: "I agree to the company ",
                                      style: AppText.smRegular_14_400.copyWith(
                                        color: AppColors.secondaryText,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: "Term of Service",
                                          style: AppText.smRegular_14_400
                                              .copyWith(
                                                color:
                                                    AppColors.primaryTextblack,
                                              ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Scaffold(),
                                                ),
                                              );
                                            },
                                        ),
                                        TextSpan(
                                          text: " and ",
                                          style: AppText.smRegular_14_400
                                              .copyWith(
                                                color: AppColors.secondaryText,
                                              ),
                                        ),
                                        TextSpan(
                                          text: "Privacy Policy",
                                          style: AppText.smRegular_14_400
                                              .copyWith(
                                                color:
                                                    AppColors.primaryTextblack,
                                              ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Scaffold(),
                                                ),
                                              );
                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap.h80,
                          context.primaryButton(
                            width: double.infinity,
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  _agreedToTerms) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VerifyCodeScreen(),
                                  ),
                                );
                              } else if (!_agreedToTerms) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'You must agree to the Terms of Service and Privacy Policy.',
                                    ),
                                  ),
                                );
                              }
                            },
                            text: 'Register',
                          ),

                          Gap.h40,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Do you already have an account? ",
                                style: AppText.smRegular_14_400.copyWith(
                                  color: AppColors.secondaryText,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SigninScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Log in",
                                  style: AppText.smRegular_14_400.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
