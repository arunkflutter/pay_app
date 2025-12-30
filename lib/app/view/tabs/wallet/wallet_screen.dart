import 'package:alp_pay_flutter/app/view/tabs/wallet/wallet_controller.dart';
import '../../../../exports.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(
      init: WalletController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            surfaceTintColor: AppColors.white,
            backgroundColor: AppColors.white,
            leadingWidth: 0,
            title: Text(
              'wallet'.tr,
              style: AppTextStyles.boldUrbanist.copyWith(
                fontSize: 20,
                color: AppColors.black,
              ),
            ),
            centerTitle: false,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      Text(
                        'amount_sent'.tr,
                        style: AppTextStyles.regularUrbanist.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
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
                Text(
                  'recent_transactions'.tr,
                  style: AppTextStyles.boldUrbanist.copyWith(
                    fontSize: 20,
                    letterSpacing: 0.2,
                    color: AppColors.black,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shrinkWrap: true,
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
