import '../../../../exports.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 3), () {
      Get.toNamed(AppRoutes.onboardingScreen);
    });
  }
}
