import 'package:alp_pay_flutter/app/widgets/source_dialog.dart';

import '../../../../exports.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: EditProfileController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          titleSpacing: 0,
          centerTitle: false,
          leading: MyBackButton(color: AppColors.blackDark),
          title: Text(
            "edit_profile".tr,
            style: AppTextStyles.boldUrbanist.copyWith(
              fontSize: 20,
              color: AppColors.blackDark,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.appColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 73,
                      width: 73,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: controller.profileImage != null
                            ? DecorationImage(
                          image: FileImage(controller.profileImage!),
                          fit: BoxFit.cover,
                        )
                            : null,
                      ),
                      child: controller.profileImage == null
                          ? Center(
                        child: Text(
                          controller.getInitials("John Doe"),
                          style: AppTextStyles.boldUrbanist.copyWith(
                            color: AppColors.appColor,
                            fontSize: 45,
                          ),
                        ),
                      )
                          : null,
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        SourceDialog.commonButtonsPopUp(
                          context,
                          onButtonTap: () {
                            controller.pickFromCamera();
                          },
                          onButton2Tap: () {
                            controller.pickFromGallery();
                          },
                          button1Image: AppImages.camera,
                          button2Image: AppImages.gallery,
                        );
                      },

                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.fadeAppBlue6Color,
                        ),
                        child: Text(
                          "change_photo".tr,
                          style: AppTextStyles.semiBoldUrbanist.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border3Color),
                ),
                child: Column(
                  children: [
                    MyTextFieldForm(
                      labelIcon: AppImages.proIcon,
                      labelStyle: AppTextStyles.semiBoldUrbanist.copyWith(
                        color: AppColors.blackDark,
                      ),
                      label: "first_name".tr,
                      borderColor: AppColors.border3Color,
                      hintText: "first_name".tr,
                      fillColor: AppColors.white,
                      controller: TextEditingController(),
                    ),
                    SizedBox(height: 10),
                    MyTextFieldForm(
                      labelIcon: AppImages.proIcon,
                      labelStyle: AppTextStyles.semiBoldUrbanist.copyWith(
                        color: AppColors.blackDark,
                      ),
                      label: "last_name".tr,
                      borderColor: AppColors.border3Color,
                      hintText: "last_name".tr,
                      fillColor: AppColors.white,
                      controller: TextEditingController(),
                    ),
                    SizedBox(height: 10),
                    MyTextFieldForm(
                      labelIcon: AppImages.mail,
                      labelStyle: AppTextStyles.semiBoldUrbanist.copyWith(
                        color: AppColors.blackDark,
                      ),
                      label: "email_address".tr,
                      borderColor: AppColors.border3Color,
                      hintText: "email_address".tr,
                      fillColor: AppColors.white,
                      controller: TextEditingController(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              CustomButton(text: "save_changes".tr, onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
