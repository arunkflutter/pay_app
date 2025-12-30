import '../../../../exports.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HistoryController(),
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: AppColors.white,
          backgroundColor: AppColors.white,
          leading: SizedBox(),
          leadingWidth: 15,
          titleSpacing: 0,
          centerTitle: false,
          title: Text(
            'transaction_status'.tr,
            style: AppTextStyles.boldUrbanist.copyWith(
              fontSize: 20,
              color: AppColors.black,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: controller.dummyTransactions.isNotEmpty
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: MyTextFieldForm(
                      labelStyle: AppTextStyles.semiBoldUrbanist.copyWith(
                        fontSize: 18,
                        color: AppColors.black,
                      ),
                      hintText: "search_transactions".tr,
                      hintStyle: AppTextStyles.mediumUrbanist.copyWith(
                        fontSize: 20,
                        letterSpacing: 0,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 3),
                        child: Image.asset(
                          AppImages.search,
                          width: 18,
                          height: 18,
                        ),
                      ),
                      borderColor: AppColors.borderColor,
                      fillColor: AppColors.white,
                      formRadius: 50,
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: controller.onTapFilterButton,
                    child: Container(
                      height: 45,
                      width: 45,
                      padding: EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.borderColor,
                          width: 1.5,
                        ),
                      ),
                      child: Image.asset(AppImages.filter),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15),
              if (controller.dummyTransactions.isNotEmpty) ...[
                Text(
                  "December 2025",
                  style: AppTextStyles.boldUrbanist.copyWith(
                    fontSize: 20,
                    letterSpacing: 0,
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
                          onTap: () {
                            Get.toNamed(AppRoutes.transactionStatus);
                          },
                          name: item["name"],
                          description: item["time"],
                          amount: item["amount"],
                          isCredit: item["isCredit"],
                        );
                      },
                    ),
                  ),
                ),
              ] else ...[
                SizedBox(height: 20),
                Image.asset(
                  AppImages.noTransaction,
                  height: Get.width / 2,
                  width: Get.width / 2,
                ),
                SizedBox(height: 10),
                Text(
                  "no_transactions_yet".tr,
                  style: AppTextStyles.boldUrbanist.copyWith(
                    fontSize: 20,
                    letterSpacing: 0.5,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Text(
                    "your_transaction_history_is_empty".tr,
                    style: AppTextStyles.regularUrbanist.copyWith(
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
