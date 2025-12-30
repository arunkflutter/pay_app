import '../../../../exports.dart';

class SendMoneyScreen extends StatelessWidget {
  const SendMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SendMoneyController(),
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: AppColors.white,
          backgroundColor: AppColors.white,
          leading: MyBackButton(color: AppColors.black),
          titleSpacing: 0,
          centerTitle: false,
          title: Text(
            'Send Money',
            style: AppTextStyles.boldUrbanist.copyWith(
              fontSize: 20,
              color: AppColors.black,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextFieldForm(
                label: "Phone Number or Name",
                labelStyle: AppTextStyles.semiBoldUrbanist.copyWith(
                  fontSize: 18,
                  color: AppColors.black,
                ),
                hintText: "Search by phone or name",
                hintStyle: AppTextStyles.mediumUrbanist.copyWith(
                  fontSize: 20,
                  letterSpacing: 0,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 3),
                  child: Image.asset(AppImages.search, width: 18, height: 18),
                ),
                borderColor: AppColors.borderColor,
                fillColor: AppColors.white,
                formRadius: 50,
              ),

              SizedBox(height: 15),
              Text(
                "Recent",
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
                        description: item["phone"],
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
  }
}
