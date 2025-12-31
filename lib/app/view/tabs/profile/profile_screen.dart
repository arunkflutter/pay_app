import '../../../../exports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ProfileController(),
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: Text(
            "profile_setting".tr,
            style: AppTextStyles.boldUrbanist.copyWith(
              fontSize: 20,
              color: AppColors.blackDark,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.appColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          controller.getInitials("John Doe"),
                          style: AppTextStyles.boldUrbanist.copyWith(
                            color: AppColors.appColor,
                            fontSize: 42,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "John Doe",
                          style: AppTextStyles.boldUrbanist.copyWith(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          "john.doe@example.com",
                          style: AppTextStyles.mediumUrbanist.copyWith(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          "+49 123 4567890",
                          style: AppTextStyles.mediumUrbanist.copyWith(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "personal_details".tr,
                style: AppTextStyles.mediumUrbanist.copyWith(
                  fontSize: 18,
                  color: AppColors.blackDark,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Column(
                  children: [
                    rowWidget(
                      onTap: ()=>Get.toNamed(AppRoutes.editProfile),
                      title: "edit_profile".tr,
                      icon: AppImages.calendar,
                    ),
                    SizedBox(height: 15),
                    rowWidget(
                      title: "select_language".tr,
                      icon: AppImages.language,
                      widget: LanguageDropdown(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                "legal_and_security".tr,
                style: AppTextStyles.mediumUrbanist.copyWith(
                  fontSize: 18,
                  color: AppColors.blackDark,
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Column(
                  children: [
                    rowWidget(
                      title: "terms_and_conditions".tr,
                      icon: AppImages.termsCondition,
                    ),
                    SizedBox(height: 15),
                    rowWidget(
                      title: "privacy_policy".tr,
                      icon: AppImages.bagCheck,
                    ),
                    SizedBox(height: 15),
                    rowWidget(title: "imprint".tr, icon: AppImages.imprint),
                  ],
                ),
              ),
              SizedBox(height: 25),
              CustomButton(
                buttonCenter: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "logout".tr,
                      style: AppTextStyles.mediumUrbanist.copyWith(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    Image.asset(
                      AppImages.logout,
                      height: 20,
                      width: 20,
                      color: Colors.white,
                    ),
                  ],
                ),
                text: "",
                onPressed: ()=>Get.offAllNamed(AppRoutes.loginScreen),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowWidget({title, icon, onTap, widget}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.fadeAppBlue4Color,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  icon,
                  height: 20,
                  width: 20,
                  color: AppColors.fadeAppBlue5Color,
                ),
              ),
            ),
            SizedBox(width: 10),
            Text(
              title,
              style: AppTextStyles.mediumUrbanist.copyWith(
                fontSize: 16,
                color: AppColors.blackDark,
              ),
            ),
            Spacer(),
            if (widget != null)
              widget
            else
              Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.textColor,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
