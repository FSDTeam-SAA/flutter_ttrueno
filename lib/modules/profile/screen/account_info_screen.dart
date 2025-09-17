import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ttrueno_fo827e642a0c4/core/common/widgets/reactive_buttons/save_button.dart';
import 'package:ttrueno_fo827e642a0c4/core/notifiers/button_status_notifier.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/app_colors.dart';
import 'package:ttrueno_fo827e642a0c4/core/theme/text_style.dart';
import 'package:ttrueno_fo827e642a0c4/features/profile/widget/text_field.dart';
import 'package:ttrueno_fo827e642a0c4/modules/profile/controller/user_profile_data_controller.dart';

class AccountInfoScreen extends StatelessWidget {
  const AccountInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AccountInfoController());
    final ProcessStatusNotifier processNotifier = ProcessStatusNotifier(
      initialStatus: EnabledStatus(),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Account Info',
          style: AppText.lgMedium_18_500.copyWith(
            color: AppColors.primaryTextblack,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Obx(() {
                  ImageProvider avatar;

                  if (controller.profileImage.value != null) {
                    avatar = FileImage(controller.profileImage.value!);
                  } else if (controller.userProfile.value.imageUrl.isNotEmpty) {
                    final img = controller.userProfile.value.imageUrl;
                    if (img.startsWith('http')) {
                      avatar = NetworkImage(img);
                    } else {
                      final file = File(img);
                      avatar = file.existsSync()
                          ? FileImage(file)
                          : const AssetImage('assets/images/profilepic.png');
                    }
                  } else {
                    avatar = const AssetImage('assets/images/profilepic.png');
                  }

                  return Stack(
                    children: [
                      CircleAvatar(radius: 50, backgroundImage: avatar),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: controller.pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.primarybutton,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
              const SizedBox(height: 32),

              BuildTextField(
                controller: controller.fullNameController,
                labelText: 'Full Name',
                textColor: AppColors.primaryTextblack,
              ),
              const SizedBox(height: 16),

              BuildTextField(
                controller: controller.emailController,
                labelText: 'Email',
                textColor: AppColors.primaryTextblack,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              BuildTextField(
                controller: controller.phoneController,
                labelText: 'Phone',
                textColor: AppColors.primaryTextblack,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 300),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: RSaveButton(
                  key: UniqueKey(),
                  saveText: "Save",
                  loadingText: "Saving...",
                  doneText: "Done",
                  onSaveTap: () {},
                  onDone: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Scaffold()),
                      (route) => false,
                    );
                  },
                  buttonStatusNotifier: processNotifier,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
