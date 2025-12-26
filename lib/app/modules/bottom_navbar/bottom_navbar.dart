import 'package:alp_pay_flutter/app/constant/app_colors.dart';
import 'package:alp_pay_flutter/app/constant/app_images.dart';
import 'package:alp_pay_flutter/app/constant/text_styles.dart';
import 'package:alp_pay_flutter/app/modules/bottom_navbar/bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            height: 115,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 75,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: []),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _navItem(
                        image: controller.currentIndex == 0
                            ? AppImages.homeFill
                            : AppImages.home,
                        label: 'Home',
                        index: 0,
                        controller: controller,
                      ),
                      _navItem(
                        image: controller.currentIndex == 1
                            ? AppImages.historyFill
                            : AppImages.history,
                        label: 'History',
                        index: 1,
                        controller: controller,
                      ),
                      _navItem(
                        image: "",
                        label: 'Pay',
                        index: 2,
                        controller: controller,
                      ), // space for FAB
                      _navItem(
                        image: controller.currentIndex == 3
                            ? AppImages.walletFill
                            : AppImages.wallet,
                        label: 'Wallet',
                        index: 3,
                        controller: controller,
                      ),
                      _navItem(
                        image: controller.currentIndex == 4
                            ? AppImages.profileFill
                            : AppImages.profile,
                        label: 'Profile',
                        index: 4,
                        controller: controller,
                      ),
                    ],
                  ),
                ),
                // Floating Pay button
                Positioned(
                  bottom: 76,
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
                            ? AppColor.appColor
                            : Colors.white,
                        border: Border.all(width: 3, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 2,
                            blurRadius: 8,
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
                              ? AppColor.white
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
                color: isSelected ? AppColor.appColor : null,
              )
            else
              SizedBox(height: 25),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.boldUrbanist.copyWith(
                fontSize: 11,
                color: isSelected ? AppColor.appColor : AppColor.textColor,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
