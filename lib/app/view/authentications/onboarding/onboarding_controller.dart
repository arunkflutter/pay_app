import '../../../../exports.dart';

class OnBoardingController extends GetxController {
  final PageController pageController = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "pay_anywhere".tr,
      "desc": "scan_qr_codes".tr,
      "image": AppImages.onboarding1,
    },
    {
      "title": "send_request".tr,
      "desc": "transfer_money_to_friends_line".tr,
      "image": AppImages.onboarding2,
    },
    {
      "title": "safe_and_secure".tr,
      "desc": "your_data_is_protected_with".tr,
      "image": AppImages.onboarding3,
    },
    {
      "title": "digital_wallet".tr,
      "desc": "secure_fast_and_simple_payments_line".tr,
      "image": AppImages.onboarding4,
    },
  ];

  void onTapNextPage() {
    if (currentIndex < onboardingData.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      Get.offAll(
        () => LoginScreen(),
        transition: Transition.downToUp,
        duration: const Duration(milliseconds: 800),
      );
    }
  }

  onPageChange(int index) {
    currentIndex = index;
    update();
  }
}
