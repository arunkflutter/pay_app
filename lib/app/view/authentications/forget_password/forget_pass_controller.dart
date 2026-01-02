import '../../../../exports.dart';

class ForgetPassController extends GetxController {
  final GlobalKey<ShakeWidgetState> emailShake = GlobalKey<ShakeWidgetState>();
  TextEditingController emailController = TextEditingController();
  bool isEmailValidate = true;
  String? errorMessage;
  onTapToSendEmail() {
    final email = emailController.text.trim();
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (email.isEmpty || !emailRegex.hasMatch(email)) {
      isEmailValidate = false;
      emailShake.currentState?.shake();
      if (email.isNotEmpty && !emailRegex.hasMatch(email)) {
        errorMessage = "email_error".tr;
      }
    } else {}
    update();
  }
}
