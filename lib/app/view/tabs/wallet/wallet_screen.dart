import 'package:alp_pay_flutter/app/view/tabs/wallet/wallet_controller.dart';
import '../../../../exports.dart';

/// Wallet main screen
/// Displays total sent amount and recent transactions
class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(
      // Initialize controller once for this screen
      init: WalletController(),

      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white,

          /// AppBar Section
          appBar: AppBar(
            backgroundColor: AppColors.white,
            surfaceTintColor: AppColors.white,
            elevation: 0,
            leadingWidth: 0,
            centerTitle: false,

            title: Text(
              'wallet'.tr,
              style: AppTextStyles.boldUrbanist.copyWith(
                fontSize: 20,
                color: AppColors.black,
              ),
            ),
          ),

          /// Body Content
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Wallet Balance Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.appColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Label
                      Text(
                        'amount_sent'.tr,
                        style: AppTextStyles.regularUrbanist.copyWith(
                          color: AppColors.white,
                        ),
                      ),

                      const SizedBox(height: 4),

                      /// Amount
                      Text(
                        '€ 348.80',
                        style: AppTextStyles.extraBoldUrbanist.copyWith(
                          fontSize: 30,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                /// Recent Transactions Title
                Text(
                  'recent_transactions'.tr,
                  style: AppTextStyles.boldUrbanist.copyWith(
                    fontSize: 20,
                    letterSpacing: 0.2,
                    color: AppColors.black,
                  ),
                ),

                /// Transactions List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    itemCount: 25,
                    itemBuilder: (context, index) {
                      return const TransactionCardWidget(
                        description: "Today, 9:15 AM",
                        margin: EdgeInsets.only(bottom: 10),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
