import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:futsoul_merchant/controller/dashboard/profile/edit_profile_controller.dart';
import 'package:futsoul_merchant/utils/colors.dart';
import 'package:futsoul_merchant/utils/custom_text_styles.dart';
import 'package:futsoul_merchant/utils/validators.dart';
import 'package:futsoul_merchant/widget/custom/custom_appbar.dart';
import 'package:futsoul_merchant/widget/custom/custome_textfield.dart';
import 'package:futsoul_merchant/widget/custom/elevated_button.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  static const String routeName = "/edit-profile";
  final c = Get.find<EditProfileController>();
  EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Edit Profile",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: CustomElevatedButton(
          title: "Continue",
          onTap: c.updateProfile,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: c.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  controller: c.futsalNameController,
                  labelText: "Futsal Name",
                  hint: "Enter your Futsal Name",
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                  validator: Validators.checkFieldEmpty,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: c.nameController,
                  labelText: "Full Name",
                  hint: "Enter your Full Name",
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                  validator: Validators.checkFieldEmpty,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: c.phoneController,
                  labelText: "Phone",
                  hint: "Enter your phone number",
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  validator: Validators.checkPhoneField,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: c.addressController,
                  labelText: "Address",
                  hint: "Enter your address",
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.streetAddress,
                  validator: Validators.checkFieldEmpty,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: c.priceController,
                  labelText: "Price",
                  hint: "Enter price per hour",
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  validator: Validators.checkFieldEmpty,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: c.openTimeController,
                  labelText: "Opening Time",
                  hint: "Select Opening Time",
                  border: AppColors.lGrey,
                  textInputAction: TextInputAction.none,
                  textInputType: TextInputType.none,
                  validator: Validators.checkFieldEmpty,
                  readOnly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: c.closeTimeController,
                  labelText: "Closing Time Time",
                  hint: "Select Closing Time",
                  border: AppColors.lGrey,
                  textInputAction: TextInputAction.none,
                  textInputType: TextInputType.none,
                  validator: Validators.checkFieldEmpty,
                  readOnly: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Image",
                  style: CustomTextStyles.f16W400(color: theme.primaryColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: DottedBorder(
                      dashPattern: const [4, 2],
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      padding: const EdgeInsets.all(10),
                      color: (c.imageError.value)
                          ? AppColors.errorColor
                          : AppColors.primaryColor,
                      strokeWidth: 1,
                      child: InkWell(
                        onTap: () {
                          c.pickImage();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: double.infinity,
                            height: 132,
                            child: (c.image.value != null)
                                ? Image.file(
                                    c.image.value!,
                                    height: 132,
                                    fit: BoxFit.cover,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: c.user.value?.image ?? "",
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: theme.colorScheme.outline,
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "Attach Image",
                                          style: CustomTextStyles.f16W400(
                                              color: theme.colorScheme.outline),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Banner Image",
                  style: CustomTextStyles.f16W400(color: theme.primaryColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: DottedBorder(
                      dashPattern: const [4, 2],
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      padding: const EdgeInsets.all(10),
                      color: (c.bannerImageError.value)
                          ? AppColors.errorColor
                          : AppColors.primaryColor,
                      strokeWidth: 1,
                      child: InkWell(
                        onTap: () {
                          c.pickBannerImage();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: double.infinity,
                            height: 132,
                            child: (c.bannerImage.value != null)
                                ? Image.file(
                                    c.bannerImage.value!,
                                    height: 132,
                                    fit: BoxFit.cover,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: c.user.value?.banner ?? "",
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: theme.colorScheme.outline,
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          "Attach Image",
                                          style: CustomTextStyles.f16W400(
                                              color: theme.colorScheme.outline),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
