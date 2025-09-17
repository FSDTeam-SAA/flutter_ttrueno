import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ttrueno_fo827e642a0c4/modules/profile/model/user_profile.dart';

class AccountInfoController extends GetxController {
  // Text fields
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  // Profile state
  var profileImage = Rx<File?>(null);
  var userProfile = const UserProfile(
    id: '1',
    name: 'Howard Stevenddd',
    email: 'howard@gmail.com',
    number: '(480) 555-0103',
    imageUrl: '',
  ).obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
  }

  void _loadInitialData() {
    fullNameController.text = userProfile.value.name;
    emailController.text = userProfile.value.email;
    phoneController.text = userProfile.value.number;
  }

  Future<void> pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      profileImage.value = File(picked.path);
    }
  }

  void saveProfile() {
    userProfile.value = userProfile.value.copyWith(
      name: fullNameController.text.trim(),
      email: emailController.text.trim(),
      number: phoneController.text.trim(),
      imageUrl: profileImage.value?.path ?? userProfile.value.imageUrl,
    );

    Get.snackbar(
      'Success',
      'Profile information saved!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}


