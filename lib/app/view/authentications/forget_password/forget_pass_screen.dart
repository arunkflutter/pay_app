import '../../../../exports.dart';

class ForgetPassScreen extends StatelessWidget {
  const ForgetPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPassController>(
      /// Initialize the controller here instead of class-level
      init: ForgetPassController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.appColor,

        body: Stack(
          children: [
            /// BACK BUTTON
            MyBackButton(margin: const EdgeInsets.only(top: 45, left: 12)),

            /// WHITE CONTAINER SHEET
            Container(
              margin: EdgeInsets.only(top: Get.height * 0.12),
              padding: const EdgeInsets.symmetric(horizontal: 25),
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
                  SizedBox(height: Get.height * 0.06),

                  /// TITLE
                  Center(
                    child: Text(
                      "forgot_password".tr,
                      style: AppTextStyles.boldUrbanist.copyWith(
                        fontSize: 40,
                        color: AppColors.black,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// NOTE / DESCRIPTION
                  Text(
                    "forgot_password_note".tr,
                    style: AppTextStyles.regularUrbanist.copyWith(
                      fontSize: 17,
                      color: AppColors.textColor,
                    ),
                  ),

                  const SizedBox(height: 35),

                  /// EMAIL FIELD WITH SHAKE ANIMATION
                  ShakeAnimatedWidget(
                    key: controller.emailShake,
                    shakeCount: 3,
                    shakeOffset: 5,
                    shakeDuration: const Duration(milliseconds: 500),
                    child: MyTextFieldForm(
                      controller: controller.emailController,
                      label: "email".tr,
                      hintText: "enter_your_email".tr,
                      keyboardType: TextInputType.emailAddress,
                      errorText: controller.errorMessage,
                      showError: !controller.isEmailValidate,
                      // Reset validation on tap
                      onTap: () {
                        controller.isEmailValidate = true;
                        controller.update();
                      },

                      // ERROR STYLING
                      borderColor: controller.isEmailValidate
                          ? null
                          : Colors.red,
                      labelStyle: controller.isEmailValidate
                          ? null
                          : AppTextStyles.boldUrbanist.copyWith(
                              fontSize: 14,
                              color: Colors.red,
                            ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  /// SEND BUTTON
                  CustomButton(
                    text: "send".tr,
                    onPressed: controller.onTapToSendEmail,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
