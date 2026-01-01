import '../../../../exports.dart';

class TransactionStatus extends StatelessWidget {
  const TransactionStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionStatusController>(
      init: TransactionStatusController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 18),

                  /// Success Icon
                  // Image.asset(
                  //   controller.icon,
                  //   height: Get.width * 0.3,
                  //   width: Get.width * 0.3,
                  // ),
                  SuccessSparkAnimation(icon: controller.icon),
                  const SizedBox(height: 12),

                  /// Title
                  Text(
                    controller.textStatus,
                    style: AppTextStyles.boldUrbanist.copyWith(
                      fontSize: 24,
                      color: AppColors.black,
                    ),
                  ),

                  const SizedBox(height: 4),

                  /// Subtitle
                  Text(
                    '${"money_sent_to".tr} Sarah Miller',
                    style: AppTextStyles.regularUrbanist,
                  ),

                  const SizedBox(height: 20),

                  /// Transaction Card
                  _transactionDetailsCard(controller),

                  const SizedBox(height: 25),

                  /// Buttons
                  CustomButton(
                    text: 'back_to_dashboard'.tr,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    onPressed: controller.onBackToDashboard,
                  ),

                  const SizedBox(height: 15),

                  CustomButton(
                    text: 'make_another_transfer'.tr,
                    isBorderEnable: true,
                    color: Colors.transparent,
                    borderColor: AppColors.appColor,
                    textColor: AppColors.appColor,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    onPressed: controller.onMakeAnotherTransfer,
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// ---------------- TRANSACTION DETAILS CARD ----------------
  Widget _transactionDetailsCard(TransactionStatusController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          /// Amount Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.appColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'amount_sent'.tr,
                  style: AppTextStyles.regularUrbanist.copyWith(
                    color: AppColors.white,
                  ),
                ),
                Text(
                  '€ 348.80',
                  style: AppTextStyles.extraBoldUrbanist.copyWith(
                    fontSize: 30,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  'transaction_completed'.tr,
                  style: AppTextStyles.regularUrbanist.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),

          /// Details Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const TransactionCardWidget(
                  name: 'Sarah Miller',
                  description: '+45 1123 4546 4933',
                  isDisableBorder: true,
                ),

                const Divider(height: 30),

                _infoRow('transaction_id'.tr, 'TXN1765794592202'),
                _infoRow('date_time'.tr, '15/12/2025, 3:59 PM'),
                _infoRow('status'.tr, controller.status.name),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------- INFO ROW ----------------
  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.mediumUrbanist),
          Text(value, style: AppTextStyles.semiBoldUrbanist),
        ],
      ),
    );
  }
}
