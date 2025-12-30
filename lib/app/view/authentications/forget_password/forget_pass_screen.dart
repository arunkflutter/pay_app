import '../../../../exports.dart';

class ForgetPassScreen extends StatelessWidget {
  final ForgetPassController controller = Get.put(ForgetPassController());

  ForgetPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ForgetPassController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.appColor,
        body: Stack(
          children: [
            MyBackButton(margin: EdgeInsets.only(top: 45, left: 12)),
            Container(
              margin: EdgeInsets.only(top: Get.height * 0.12),
              padding: EdgeInsets.all(25),
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
                    "forgot_password".tr,
                    style: AppTextStyles.boldUrbanist.copyWith(
                      fontSize: 40,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "forgot_password_note".tr,
                    style: AppTextStyles.regularUrbanist.copyWith(
                      fontSize: 17,
                      color: AppColors.textColor,
                    ),
                  ),
                  SizedBox(height: 35),
                  MyTextFieldForm(
                    controller: controller.emailController,
                    label: "email".tr,
                    hintText: "enter_your_email".tr,
                  ),
                  SizedBox(height: 35),
                  CustomButton(text: "send".tr, onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
