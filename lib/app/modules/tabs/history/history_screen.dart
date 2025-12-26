import 'package:alp_pay_flutter/app/modules/tabs/history/history_controller.dart';
import 'package:alp_pay_flutter/app/widgets/back_button.dart';

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
          surfaceTintColor: AppColor.white,
          backgroundColor: AppColor.white,
          leading: SizedBox(),
          leadingWidth: 15,
          titleSpacing: 0,
          centerTitle: false,
          title: Text(
            'Transaction History',
            style: AppTextStyles.boldUrbanist.copyWith(
              fontSize: 20,
              color: AppColor.black,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: MyTextFieldForm(
                      labelStyle: AppTextStyles.semiBoldUrbanist.copyWith(
                        fontSize: 18,
                        color: AppColor.black,
                      ),
                      hintText: "Search transactions.....",
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
                      borderColor: AppColor.borderColor,
                      fillColor: AppColor.white,
                      formRadius: 50,
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                      height: 45,width: 45,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColor.borderColor, width: 1.5)
                      ),
                      child: Image.asset(AppImages.filter))
                ],
              ),

              SizedBox(height: 15),
              Text(
                "December 2025",
                style: AppTextStyles.boldUrbanist.copyWith(
                  fontSize: 20,
                  letterSpacing: 0,
                  color: AppColor.black,
                ),
              ),
              const SizedBox(height: 14),
              // Expanded(
              //   child: RefreshIndicator(
              //     onRefresh: () async {},
              //     child: ListView.builder(
              //       padding: EdgeInsets.zero,
              //       itemCount: 20,
              //       itemBuilder: (context, index) {
              //         final item =
              //         controller.dummyTransactions[index %
              //             controller.dummyTransactions.length];
              //
              //         return TransactionCardWidget(
              //           name: item["name"],
              //           description: item["phone"],
              //         );
              //       },
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
