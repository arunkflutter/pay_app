import '../../../../exports.dart';

class SignUpController extends GetxController with BaseClass {
  // Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // Shake animation keys
  final GlobalKey<ShakeWidgetState> nameShake = GlobalKey<ShakeWidgetState>();
  final GlobalKey<ShakeWidgetState> emailShake = GlobalKey<ShakeWidgetState>();
  final GlobalKey<ShakeWidgetState> passShake = GlobalKey<ShakeWidgetState>();
  final GlobalKey<ShakeWidgetState> confPassShake =
      GlobalKey<ShakeWidgetState>();

  // Validation flags
  bool isNameValidate = true;
  bool isEmailValidate = true;
  bool isPassValidate = true;
  bool isConfPassValidate = true;
  String? errorMessage;

  /// Sign-Up button tapped
  void onTapSignUp() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    // Reset all validations
    isNameValidate = true;
    isEmailValidate = true;
    isPassValidate = true;
    isConfPassValidate = true;
    errorMessage = null;

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    // ----- VALIDATIONS -----
    if (name.isEmpty &&
        email.isEmpty &&
        password.isEmpty &&
        confirmPassword.isEmpty) {
      // All fields empty
      isNameValidate = false;
      isEmailValidate = false;
      isPassValidate = false;
      isConfPassValidate = false;

      nameShake.currentState?.shake();
      emailShake.currentState?.shake();
      passShake.currentState?.shake();
      confPassShake.currentState?.shake();
    } else if (name.isEmpty) {
      isNameValidate = false;
      nameShake.currentState?.shake();
    } else if (email.isEmpty || !emailRegex.hasMatch(email)) {
      isEmailValidate = false;
      emailShake.currentState?.shake();
      if (!emailRegex.hasMatch(email)) {
        errorMessage = "email_error".tr;
      }
    } else if (password.isEmpty) {
      // Optional: enforce min 6 characters
      isPassValidate = false;
      passShake.currentState?.shake();
    } else if (!RegExp(
      r"^(?=.{8,}$)(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*\W).*$",
    ).hasMatch(password)) {
      isPassValidate = false;
      passShake.currentState?.shake();
      errorMessage = "password_error".tr;
    } else if (confirmPassword.isEmpty || confirmPassword != password) {
      isConfPassValidate = false;
      confPassShake.currentState?.shake();
      if (confirmPassword.isNotEmpty && confirmPassword != password) {
        errorMessage = "password_error_nm".tr;
      }
    } else {
      // ✅ All validations passed
      // Here you can call your API

      // Example: Navigate to bottom nav / login page
      Get.offAllNamed(AppRoutes.bottomNavbar);
    }

    // Update UI
    update();
  }
}
