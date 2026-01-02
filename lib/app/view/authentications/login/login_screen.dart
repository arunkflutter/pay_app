import '../../../../exports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.appColor,

        body: Container(
          // Push container down from top
          margin: EdgeInsets.only(top: Get.height * 0.1),
          padding: EdgeInsets.symmetric(horizontal: 20),

          // Rounded top sheet style
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(26),
              topRight: Radius.circular(26),
            ),
          ),

          // Scrollable content
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              SizedBox(height: Get.height * 0.06),

              /// Welcome text
              Center(
                child: Text(
                  "welcome_back".tr,
                  style: AppTextStyles.boldUrbanist.copyWith(
                    fontSize: 40,
                    color: AppColors.black,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              /// EMAIL FIELD (with shake + validation)
              ShakeAnimatedWidget(
                key: controller.emailShake,
                shakeCount: 3,
                shakeOffset: 5,
                shakeDuration: const Duration(milliseconds: 500),
                child: MyTextFieldForm(
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.emailController,
                  label: "email".tr,
                  hintText: "enter_your_email".tr,

                  // Reset validation when user taps
                  onTap: () {
                    controller.isEmailValidate = true;
                    controller.update();
                  },
                  errorText: controller.errorMessage,
                  showError: !controller.isEmailValidate,
                  // Error styling
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

              /// PASSWORD FIELD (with shake + validation)
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

                  // Reset validation on tap
                  onTap: () {
                    controller.isPassValidate = true;
                    controller.update();
                  },

                  // Error styling
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

              /// FORGOT PASSWORD
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // Reset validations before navigation
                    controller.isEmailValidate = true;
                    controller.isPassValidate = true;
                    controller.update();

                    Get.toNamed(AppRoutes.forgetPassScreen);
                  },
                  child: Text(
                    "forgot_password".tr,
                    style: AppTextStyles.boldUrbanist.copyWith(
                      color: AppColors.appColor,
                      fontSize: 15,
                      letterSpacing: 0.5,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// LOGIN BUTTON
              CustomButton(text: "login".tr, onPressed: controller.onTapLogin),

              /// Bottom spacing (keyboard & device safe)
              SizedBox(
                height:
                    Get.height * 0.28 -
                    controller.getBottomNavBarHeight(context),
              ),

              /// SIGN UP REDIRECT
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "don_t_have_an_account_yet".tr,
                    style: AppTextStyles.boldUrbanist.copyWith(
                      fontSize: 14,
                      letterSpacing: 0.5,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.isEmailValidate = true;
                      controller.isPassValidate = true;
                      controller.update();
                      Get.toNamed(AppRoutes.signUpScreen);
                    },
                    child: Text(
                      "sign_up".tr,
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
