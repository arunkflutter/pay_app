import '../../../../exports.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void onTapLogin() {
    Get.offAllNamed(AppRoutes.bottomNavbar);
    // if (email.isNotEmpty && password.isNotEmpty) {
    //   // Navigate to the dashboard if login is successful
    //   Get.offNamed('/dashboard');
    // } else {
    //   // Show an error message if email or password is empty
    //   Get.snackbar('Error', 'Please fill in both email and password.');
    // }
  }
}
