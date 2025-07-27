import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/bottom_nabar_page.dart';
import 'package:ttrueno_fo827e642a0c4/core/Button/button_widget.dart';
import 'package:ttrueno_fo827e642a0c4/features/auth/presentation/screen/forget_password_screen.dart';
import 'package:ttrueno_fo827e642a0c4/features/auth/presentation/screen/register_screen.dart';
import 'package:ttrueno_fo827e642a0c4/features/auth/presentation/widget/custom_text_field_widget.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gap.dart';
import '../../../../core/theme/text_style.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();

  static Widget _socialIcon(String assetPath) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Image.asset(assetPath, width: 24, height: 24),
    );
  }
}

class _SigninScreenState extends State<SigninScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
                        Text(
                          "Sign in to your account",
                          style: AppText.xxxlSemiBold_32_600.copyWith(
                            color: AppColors.primaryText,
                          ),
                        ),
                        Gap.h8,
                        Text(
                          "Sign in to your account.",
                          style: AppText.smRegular_14_400.copyWith(
                            color: AppColors.primaryText,
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
                                },
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
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  }
                                  if (value.length < 6) {
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
                              Gap.h8,
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ForgotPasswordScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap.h16,
                          context.primaryButton(
                            width: double.infinity,
                            onPressed: () {
                              //_formKey.currentState!.validate()
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BottomNabarScreen(),
                                  ),
                                );
                              }
                            },
                            text: 'Login Account',
                          ),
                          Gap.h40,
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.grey[300],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  "OR",
                                  style: AppText.mdRegular_16_400.copyWith(
                                    color: AppColors.secondaryText,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          ),
                          Gap.h40,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SigninScreen._socialIcon(
                                'assets/images/google.png',
                              ),
                              Gap.w32,
                              SigninScreen._socialIcon(
                                'assets/images/apple.png',
                              ),
                              Gap.w32,
                              SigninScreen._socialIcon(
                                'assets/images/facebook.png',
                              ),
                            ],
                          ),
                          Gap.h120,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have account? ",
                                style: AppText.smRegular_14_400.copyWith(
                                  color: AppColors.secondaryText,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Register",
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
