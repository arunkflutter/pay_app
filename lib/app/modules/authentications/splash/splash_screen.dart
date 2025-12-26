import '../../../../exports.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) => Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColor.appColor, AppColor.appColorsGradient2],
            ),
          ),
          child: Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1500),
              curve: Curves.easeOutBack,
              builder: (context, scale, child) {
                return Transform.scale(scale: scale, child: child);
              },
              child: Image.asset(AppImages.appLogo, width: Get.width * 0.5),
            ),
          ),
        ),
      ),
    );
  }
}
