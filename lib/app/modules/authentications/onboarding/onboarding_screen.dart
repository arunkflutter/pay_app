import '../../../../exports.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: OnBoardingController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              /// Skip Button
              if (controller.currentIndex != 3)
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () => Get.offAll(
                      () => LoginScreen(),
                      transition: Transition.downToUp,
                      duration: const Duration(milliseconds: 800),
                    ),
                    style: TextButton.styleFrom(
                      overlayColor: Colors.transparent,
                    ),
                    child: Text(
                      "skip".tr,
                      style: AppTextStyles.boldUrbanist.copyWith(fontSize: 16),
                    ),
                  ),
                )
              else
                SizedBox(height: 48),
              SizedBox(height: Get.height * 0.08),

              /// Pages
              SizedBox(
                height: Get.height * 0.5,
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: controller.onboardingData.length,
                  onPageChanged: (index) {
                    controller.onPageChange(index);
                  },
                  itemBuilder: (context, index) {
                    final item = controller.onboardingData[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(item["image"]!, height: 240),
                          const SizedBox(height: 32),
                          Text(
                            item["title"]!,
                            style: AppTextStyles.boldUrbanist.copyWith(
                              fontSize: 25,
                              color: AppColor.appColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item["desc"]!,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.regularUrbanist.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              /// Dots Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.onboardingData.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: controller.currentIndex == index ? 20 : 8,
                    decoration: BoxDecoration(
                      color: controller.currentIndex == index
                          ? AppColor.appColor
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.08),
              CustomButton(
                text: controller.currentIndex == 3
                    ? "get_started".tr
                    : "next".tr,
                buttonCenter: controller.currentIndex == 3
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Spacer(),
                          SizedBox(width: 20),
                          Text(
                            "get_started".tr,
                            style: TextStyle(
                              fontFamily: FontFamily.urbanist,
                              fontSize: 20,
                              color: AppColor.white,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Image.asset(
                            AppImages.arrowCircle,
                            height: 28,
                            width: 28,
                          ),
                        ],
                      )
                    : null,
                onPressed: controller.onTapNextPage,
                margin: EdgeInsets.symmetric(horizontal: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
