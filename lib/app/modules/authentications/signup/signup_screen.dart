import 'package:flutter/services.dart';

import '../../../../exports.dart';

class SignUpScreen extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // 🔥 important
        statusBarIconBrightness: Brightness.dark, // Android icons dark
        statusBarBrightness: Brightness.light, // iOS text dark
      ),
    );
    return GetBuilder(
      init: SignUpController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColor.appColor,
        body: Container(
          margin: EdgeInsets.only(top: Get.height * 0.1),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26),
              topRight: Radius.circular(26),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.04),
              Text(
                "sign_up".tr,
                style: AppTextStyles.boldUrbanist.copyWith(
                  fontSize: 40,
                  color: AppColor.black,
                ),
              ),
              SizedBox(height: 25),
              MyTextFieldForm(
                controller: controller.nameController,
                label: "name".tr,
                hintText: "name_name".tr,
              ),
              SizedBox(height: 15),
              MyTextFieldForm(
                controller: controller.emailController,
                label: "email".tr,
                hintText: "enter_your_email".tr,
              ),
              SizedBox(height: 15),
              MyTextFieldForm(
                controller: controller.passwordController,
                label: "password".tr,
                hintText: "enter_your_password".tr,
                isPassword: true,
              ),
              SizedBox(height: 15),
              MyTextFieldForm(
                controller: controller.confirmPasswordController,
                label: "confirm_password".tr,
                hintText: "enter_confirm_password".tr,
                isPassword: true,
              ),
              SizedBox(height: 40),
              CustomButton(text: "sign_up".tr, onPressed: () {}),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "already_have_an_account".tr,
                    style: AppTextStyles.boldUrbanist.copyWith(
                      fontSize: 14,
                      letterSpacing: 0.5,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Text(
                      "login".tr,
                      style: AppTextStyles.boldUrbanist.copyWith(
                        fontSize: 14,
                        color: AppColor.appColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
