import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:futsoul_user/controller/dashboard/profile/edit_profile_controller.dart';
import 'package:futsoul_user/utils/colors.dart';
import 'package:futsoul_user/utils/image_path.dart';
import 'package:futsoul_user/utils/validators.dart';
import 'package:futsoul_user/widget/custom/custom_appbar.dart';
import 'package:futsoul_user/widget/custom/custome_textfield.dart';
import 'package:futsoul_user/widget/custom/elevated_button.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  static const String routeName = "/edit-profile";
  final c = Get.find<EditProfileController>();
  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Edit Profile"),
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height / 1.2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: c.formKey,
              child: Column(
                children: [
                  Obx(
                    () => ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: (c.image.value != null)
                          ? Image.file(
                              c.image.value!,
                              fit: BoxFit.cover,
                              height: 120,
                              width: 120,
                            )
                          : CachedNetworkImage(
                              imageUrl: c.user.value?.image ?? "",
                              fit: BoxFit.cover,
                              height: 120,
                              width: 120,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Image.asset(
                                ImagePath.imagePlaceholder,
                                fit: BoxFit.cover,
                                height: 120,
                                width: 120,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    onPressed: c.pickImage,
                    child: const Center(
                      child: Text("Upload Image"),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomTextField(
                    controller: c.nameController,
                    labelText: "Full Name",
                    hint: "Full Name",
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
                    validator: Validators.checkFieldEmpty,
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  CustomTextField(
                    controller: c.phoneController,
                    labelText: "Phone Number",
                    hint: "Phone Number",
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.number,
                    validator: Validators.checkPhoneField,
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  CustomTextField(
                    controller: c.emailController,
                    labelText: "Email",
                    hint: "Email",
                    readOnly: true,
                    border: AppColors.lGrey,
                    textInputAction: TextInputAction.none,
                    textInputType: TextInputType.none,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Spacer(),
                  CustomElevatedButton(
                    title: "Save Details",
                    onTap: c.submit,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
