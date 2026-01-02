import '../../../../exports.dart';

class LoginController extends GetxController with BaseClass {
  final GlobalKey<ShakeWidgetState> emailShake = GlobalKey<ShakeWidgetState>();
  final GlobalKey<ShakeWidgetState> passShake = GlobalKey<ShakeWidgetState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isEmailValidate = true;
  bool isPassValidate = true;
  String? errorMessage;
  void onTapLogin() {
    final email = emailController.text.trim();
    final password = passwordController.text;

    // Reset validation flags
    isEmailValidate = true;
    isPassValidate = true;
    errorMessage = null;

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (email.isEmpty && password.isEmpty) {
      isEmailValidate = false;
      isPassValidate = false;
      emailShake.currentState?.shake();
      passShake.currentState?.shake();
    } else if (email.isEmpty || !emailRegex.hasMatch(email)) {
      isEmailValidate = false;
      emailShake.currentState?.shake();
      if (!emailRegex.hasMatch(email)) {
        errorMessage = "email_error".tr;
      }
    } else if (password.isEmpty) {
      isPassValidate = false;
      passShake.currentState?.shake();
    } else {
      // ✅ All validations passed
      Get.offAllNamed(AppRoutes.bottomNavbar);
    }

    update();
  }
}
