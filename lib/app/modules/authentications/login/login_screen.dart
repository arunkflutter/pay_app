import '../../../../exports.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LoginController(),
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
              SizedBox(height: Get.height * 0.06),
              Text(
                "welcome_back".tr,
                style: AppTextStyles.boldUrbanist.copyWith(
                  fontSize: 40,
                  color: AppColor.black,
                ),
              ),
              SizedBox(height: 40),
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
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.forgetPassScreen),
                  child: Text(
                    "forgot_password".tr,
                    style: AppTextStyles.boldUrbanist.copyWith(
                      color: AppColor.appColor,
                      letterSpacing: 0.5,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColor.appColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              CustomButton(text: "login".tr, onPressed: controller.onTapLogin),
              Spacer(),
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
                    onTap: () => Get.toNamed(AppRoutes.signUpScreen),
                    child: Text(
                      "sign_up".tr,
                      style: AppTextStyles.boldUrbanist.copyWith(
                        fontSize: 14,
                        color: AppColor.appColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.08),
            ],
          ),
        ),
      ),
    );
  }
}
