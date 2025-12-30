import '../../../../exports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage(AppImages.backgroundHome),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height * 0.07),

                  /// ---------------- Header ----------------
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.getGreetings(),
                            style: AppTextStyles.regularUrbanist.copyWith(
                              fontSize: 17,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Mr John Doe",
                            style: AppTextStyles.boldUrbanist.copyWith(
                              fontSize: 20,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const NetworkImageWidget(
                        imageUrl: "https://i.pravatar.cc/300",
                        height: 50,
                        width: 50,
                        borderRadius: 1000,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// ---------------- Balance Card ----------------
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(19),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "total_balance".tr,
                              style: AppTextStyles.regularUrbanist.copyWith(
                                fontSize: 17,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.fadeAppColor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Text(
                                "eur".tr,
                                style: AppTextStyles.boldUrbanist.copyWith(
                                  fontSize: 14,
                                  color: AppColors.appColor,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        Text(
                          "€ 348.80",
                          style: AppTextStyles.extraBoldUrbanist.copyWith(
                            fontSize: 26,
                            color: AppColors.black,
                          ),
                        ),

                        const SizedBox(height: 14),

                        /// ---------------- Actions ----------------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _ActionButton(
                              icon: AppImages.qrCode,
                              label: "scan".tr,
                              onTap: () {},
                            ),
                            _ActionButton(
                              icon: AppImages.send,
                              label: "send".tr,
                              onTap: () =>
                                  Get.toNamed(AppRoutes.sendMoneyScreen),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// ---------------- Show My Qr Code ----------------
                  const SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(19),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          padding: EdgeInsets.all(11),
                          decoration: BoxDecoration(
                            color: AppColors.appColor,
                            borderRadius: BorderRadius.circular(11),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.appColor,
                                AppColors.appColorsGradient2,
                              ],
                            ),
                          ),
                          child: Image.asset(AppImages.qrCode),
                        ),
                        const SizedBox(width: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "show_my_qr_code".tr,
                              style: AppTextStyles.semiBoldUrbanist.copyWith(
                                fontSize: 16,
                                color: AppColors.black,
                              ),
                            ),
                            Text(
                              "let_others_scan".tr,
                              style: AppTextStyles.regularUrbanist.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.fadeAppBlue2Color,
                            shape: BoxShape.circle,
                          ),
                          child: Transform.rotate(
                            angle: 8.7,
                            child: Image.asset(
                              AppImages.arrowBack,
                              color: AppColors.fadeAppBlueColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// ---------------- Recent Activity ----------------
                  const SizedBox(height: 14),
                  Text(
                    "recent_activity".tr,
                    style: AppTextStyles.boldUrbanist.copyWith(
                      fontSize: 20,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {},
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          final item =
                              controller.dummyTransactions[index %
                                  controller.dummyTransactions.length];

                          return TransactionCardWidget(
                            name: item["name"],
                            amount: item["amount"],
                            description: item["time"],
                            isCredit: item["isCredit"],
                            margin: const EdgeInsets.only(bottom: 10),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// ---------------- Reusable Action Button ----------------
class _ActionButton extends StatelessWidget {
  final String icon;
  final String label;
  final GestureTapCallback onTap;
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: AppColors.appColor,
          borderRadius: BorderRadius.circular(11),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 6),
              blurRadius: 5,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, height: 25, width: 25, color: AppColors.white),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.boldUrbanist.copyWith(
                fontSize: 14,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
