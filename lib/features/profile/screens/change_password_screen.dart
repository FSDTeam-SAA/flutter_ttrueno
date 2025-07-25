import 'package:flutter/material.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_gap.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';
import 'package:ttrueno_fo827e642a0c4/features/auth/presentation/widget/custom_text_field_widget.dart';
import '../../../core/theme/app_colors.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Change Password',
          style: AppText.lgMedium_18_500.copyWith(
            color: AppColors.primaryTextblack,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: AppColors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Current Password
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Current Password",
                style: AppText.xlSemiBold_20_600.copyWith(
                  color: AppColors.primaryTextblack,
                ),
              ),
            ),

            Gap.h8,
            ReusableTextField(
              hintText: "Enter current password",
              prefixIcon: Icons.lock_outline,
              obscureText: _obscureCurrent,
              controller: _currentPasswordController,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureCurrent
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() => _obscureCurrent = !_obscureCurrent);
                },
              ),
            ),

            const SizedBox(height: 16),

            // New Password
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "New Password",
                style: AppText.xlSemiBold_20_600.copyWith(
                  color: AppColors.primaryTextblack,
                ),
              ),
            ),

            Gap.h8,
            ReusableTextField(
              hintText: "Enter new password",
              prefixIcon: Icons.lock_outline,
              obscureText: _obscureNew,
              controller: _newPasswordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter your new password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureNew
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() => _obscureNew = !_obscureNew);
                },
              ),
            ),

            const SizedBox(height: 16),

            // Confirm Password
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Confirm Password",
                style: AppText.xlSemiBold_20_600.copyWith(
                  color: AppColors.primaryTextblack,
                ),
              ),
            ),
            Gap.h8,
            ReusableTextField(
              hintText: "Re-enter new password",
              prefixIcon: Icons.lock_outline,
              obscureText: _obscureConfirm,
              controller: _confirmNewPasswordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Confirm your password';
                }
                if (value != _newPasswordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirm
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() => _obscureConfirm = !_obscureConfirm);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 52,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              final currentPassword = _currentPasswordController.text.trim();
              final newPassword = _newPasswordController.text.trim();
              final confirmPassword = _confirmNewPasswordController.text.trim();

              if (currentPassword.isEmpty ||
                  newPassword.isEmpty ||
                  confirmPassword.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All fields are required!'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              if (newPassword.length < 6) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Password must be at least 6 characters long!',
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              if (newPassword != confirmPassword) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'New password and confirmation do not match!',
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              // Success feedback
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password changed successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primarybutton,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
