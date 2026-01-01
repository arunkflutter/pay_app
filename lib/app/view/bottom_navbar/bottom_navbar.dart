import 'dart:io';

import '../../../exports.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: BottomNavController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: controller.pages[controller.currentIndex],
          bottomNavigationBar: SizedBox(
            height:Platform.isAndroid? 115:92,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 75,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.15),
                        offset: const Offset(0, -5),
                        blurRadius: 1,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _navItem(
                        image: controller.currentIndex == 0
                            ? AppImages.homeFill
                            : AppImages.home,
                        label: 'home'.tr,
                        index: 0,
                        controller: controller,
                      ),
                      _navItem(
                        image: controller.currentIndex == 1
                            ? AppImages.historyFill
                            : AppImages.history,
                        label: 'history'.tr,
                        index: 1,
                        controller: controller,
                      ),
                      _navItem(
                        image: "",
                        label: 'pay'.tr,
                        index: 2,
                        controller: controller,
                      ), // space for FAB
                      _navItem(
                        image: controller.currentIndex == 3
                            ? AppImages.walletFill
                            : AppImages.wallet,
                        label: 'wallet'.tr,
                        index: 3,
                        controller: controller,
                      ),
                      _navItem(
                        image: controller.currentIndex == 4
                            ? AppImages.profileFill
                            : AppImages.profile,
                        label: 'profile'.tr,
                        index: 4,
                        controller: controller,
                      ),
                    ],
                  ),
                ),
                // Floating Pay button
                Positioned(
                  bottom:Platform.isAndroid? 76:55,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      controller.changeIndex(2);
                    },
                    child: Container(
                      height: 58,
                      width: 58,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.currentIndex == 2
                            ? AppColors.appColor
                            : Colors.white,
                        border: Border.all(width: 3, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Image.asset(
                          AppImages.scanner,
                          height: 20,
                          width: 20,
                          color: controller.currentIndex == 2
                              ? AppColors.white
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _navItem({
    required String image,
    required String label,
    required int index,
    required BottomNavController controller,
  }) {
    final isSelected = controller.currentIndex == index;

    return GestureDetector(
      onTap: () => controller.changeIndex(index),
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.all(6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (image.isNotEmpty)
              Image.asset(
                image,
                height: 25,
                width: 25,
                color: isSelected ? AppColors.appColor : null,
              )
            else
              SizedBox(height: 25),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.boldUrbanist.copyWith(
                fontSize: 11,
                color: isSelected ? AppColors.appColor : AppColors.textColor,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
