import '../../../../exports.dart';

/// Transaction Details Screen
/// Shows transaction summary, status, and detailed information
class TransactionDetails extends StatelessWidget {
  const TransactionDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionDetailsController>(
      // Initialize controller for this screen
      init: TransactionDetailsController(),

      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white,

          /// ---------------- APP BAR ----------------
          appBar: AppBar(
            backgroundColor: AppColors.white,
            elevation: 0,
            titleSpacing: 0,
            centerTitle: false,
            leading: MyBackButton(color: AppColors.blackDark),
            title: Text(
              "transaction_details".tr,
              style: AppTextStyles.boldUrbanist.copyWith(
                fontSize: 20,
                color: AppColors.blackDark,
              ),
            ),
          ),

          /// ---------------- BODY ----------------
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// -------- TRANSACTION SUMMARY CARD --------
                Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: _cardDecoration(),
                  child: Column(
                    children: [

                      /// User Initials Avatar
                      Container(
                        height: 73,
                        width: 73,
                        decoration: const BoxDecoration(
                          color: AppColors.appColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            controller.getInitials("John Doe"),
                            style: AppTextStyles.boldUrbanist.copyWith(
                              color: AppColors.white,
                              fontSize: 45,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// Transaction Type
                      Text(
                        "receive".tr,
                        style: AppTextStyles.mediumUrbanist.copyWith(
                          color: AppColors.blackDark,
                          fontSize: 18,
                        ),
                      ),

                      /// Amount
                      Text(
                        "+ € 24.50",
                        style: AppTextStyles.extraBoldUrbanist.copyWith(
                          fontSize: 24,
                          color: AppColors.green2,
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// Status Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.fadeGreen,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 10,
                              width: 10,
                              decoration: const BoxDecoration(
                                color: AppColors.green2,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "completed".tr,
                              style: AppTextStyles.semiBoldUrbanist.copyWith(
                                color: AppColors.green2,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// -------- TRANSACTION INFORMATION TITLE --------
                Text(
                  "transaction_information".tr,
                  style: AppTextStyles.semiBoldUrbanist.copyWith(
                    fontSize: 19,
                    color: AppColors.blackDark,
                  ),
                ),

                const SizedBox(height: 10),

                /// -------- TRANSACTION DETAILS CARD --------
                Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: _cardDecoration(),
                  child: Column(
                    children: [
                      _infoRow('from'.tr, 'Sarah Miller'),
                      _infoRow('date'.tr, 'Today'),
                      _infoRow('time'.tr, '09:15 AM'),
                      _infoRow('transaction_id'.tr, '2'),
                      _infoRow('description'.tr, 'Lunch split'),
                    ],
                  ),
                ),

                /// -------- TOTAL AMOUNT BUTTON --------
                CustomButton(
                  margin: const EdgeInsets.symmetric(vertical: 35),
                  text: "",
                  onPressed: () {},
                  buttonCenter: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "total_amount".tr,
                        style: AppTextStyles.semiBoldUrbanist.copyWith(
                          color: AppColors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "€ 24.50",
                        style: AppTextStyles.boldUrbanist.copyWith(
                          color: AppColors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// ---------------- INFO ROW ----------------
  /// Used to display key-value transaction details
  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.mediumUrbanist),
          Text(
            value,
            style: AppTextStyles.semiBoldUrbanist.copyWith(
              color: AppColors.blackDark,
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------- CARD DECORATION ----------------
  /// Common card UI style used in this screen
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 6),
        ),
      ],
    );
  }
}
