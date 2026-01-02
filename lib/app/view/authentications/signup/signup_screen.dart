import '../../../../exports.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Transparent status bar
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    return GetBuilder<SignUpController>(
      // Initialize the controller here
      init: SignUpController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.appColor,

        body: Container(
          margin: EdgeInsets.only(top: Get.height * 0.1),
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26),
              topRight: Radius.circular(26),
            ),
          ),

          /// SCROLLABLE CONTENT
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              SizedBox(height: Get.height * 0.04),

              /// SCREEN TITLE
              Center(
                child: Text(
                  "sign_up".tr,
                  style: AppTextStyles.boldUrbanist.copyWith(
                    fontSize: 40,
                    color: AppColors.black,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              /// NAME FIELD
              ShakeAnimatedWidget(
                key: controller.nameShake,
                shakeCount: 3,
                shakeOffset: 5,
                shakeDuration: const Duration(milliseconds: 500),
                child: MyTextFieldForm(
                  controller: controller.nameController,
                  label: "name".tr,
                  hintText: "name_name".tr,
                  onTap: () {
                    controller.isNameValidate = true;
                    controller.update();
                  },
                  borderColor: controller.isNameValidate ? null : Colors.red,
                  labelStyle: controller.isNameValidate
                      ? null
                      : AppTextStyles.boldUrbanist.copyWith(
                          fontSize: 14,
                          color: Colors.red,
                        ),
                ),
              ),

              const SizedBox(height: 15),

              /// EMAIL FIELD
              ShakeAnimatedWidget(
                key: controller.emailShake,
                shakeCount: 3,
                shakeOffset: 5,
                shakeDuration: const Duration(milliseconds: 500),
                child: MyTextFieldForm(
                  controller: controller.emailController,
                  label: "email".tr,
                  hintText: "enter_your_email".tr,
                  onTap: () {
                    controller.isEmailValidate = true;
                    controller.update();
                  },
                  keyboardType: TextInputType.emailAddress,
                  errorText: controller.errorMessage,
                  showError: !controller.isEmailValidate,
                  borderColor: controller.isEmailValidate ? null : Colors.red,
                  labelStyle: controller.isEmailValidate
                      ? null
                      : AppTextStyles.boldUrbanist.copyWith(
                          fontSize: 14,
                          color: Colors.red,
                        ),
                ),
              ),

              const SizedBox(height: 15),

              /// PASSWORD FIELD
              ShakeAnimatedWidget(
                key: controller.passShake,
                shakeCount: 3,
                shakeOffset: 5,
                shakeDuration: const Duration(milliseconds: 500),
                child: MyTextFieldForm(
                  controller: controller.passwordController,
                  label: "password".tr,
                  hintText: "enter_your_password".tr,
                  isPassword: true,
                  onTap: () {
                    controller.isPassValidate = true;
                    controller.update();
                  },
                  keyboardType: TextInputType.visiblePassword,
                  errorText: controller.errorMessage,
                  showError: !controller.isPassValidate,
                  borderColor: controller.isPassValidate ? null : Colors.red,
                  labelStyle: controller.isPassValidate
                      ? null
                      : AppTextStyles.boldUrbanist.copyWith(
                          fontSize: 14,
                          color: Colors.red,
                        ),
                ),
              ),

              const SizedBox(height: 15),

              /// CONFIRM PASSWORD FIELD
              ShakeAnimatedWidget(
                key: controller.confPassShake,
                shakeCount: 3,
                shakeOffset: 5,
                shakeDuration: const Duration(milliseconds: 500),
                child: MyTextFieldForm(
                  controller: controller.confirmPasswordController,
                  label: "confirm_password".tr,
                  hintText: "enter_confirm_password".tr,
                  isPassword: true,
                  onTap: () {
                    controller.isConfPassValidate = true;
                    controller.update();
                  },
                  keyboardType: TextInputType.visiblePassword,
                  errorText: controller.errorMessage,
                  showError: !controller.isConfPassValidate,
                  borderColor: controller.isConfPassValidate
                      ? null
                      : Colors.red,
                  labelStyle: controller.isConfPassValidate
                      ? null
                      : AppTextStyles.boldUrbanist.copyWith(
                          fontSize: 14,
                          color: Colors.red,
                        ),
                ),
              ),

              const SizedBox(height: 40),

              /// SIGN UP BUTTON
              CustomButton(
                text: "sign_up".tr,
                onPressed: controller.onTapSignUp,
              ),

              /// Bottom spacing
              SizedBox(
                height:
                    Get.height * 0.16 -
                    controller.getBottomNavBarHeight(context),
              ),

              /// REDIRECT TO LOGIN
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
                        color: AppColors.appColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
