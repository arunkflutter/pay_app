import '../../exports.dart';

class FilterTransactionBottomSheet extends StatefulWidget {
  const FilterTransactionBottomSheet({super.key});

  @override
  State<FilterTransactionBottomSheet> createState() =>
      _FilterTransactionBottomSheetState();
}

class _FilterTransactionBottomSheetState
    extends State<FilterTransactionBottomSheet> {
  String selectedPaymentType = 'all'.tr;
  String selectedDateRange = 'this_month'.tr;
  double amount = 300;

  final List<String> paymentTypes = ['all'.tr, 'sent'.tr, 'received'.tr];
  final List<String> dateRanges = [
    'today'.tr,
    'this_week'.tr,
    'this_month'.tr,
    'all_time'.tr,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            'filter_transactions'.tr,
            style: AppTextStyles.semiBoldUrbanist.copyWith(
              fontSize: 25,
              color: AppColors.blackDark,
            ),
          ),
          const SizedBox(height: 10),

          /// Payment Type
          Row(
            children: [
              Image.asset(AppImages.arrowUpDown, height: 14, width: 14),
              SizedBox(width: 5),
              Text(
                'payment_type'.tr,
                style: AppTextStyles.mediumUrbanist.copyWith(
                  fontSize: 21,
                  color: AppColors.blackDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(paymentTypes.length, (index) {
              final type = paymentTypes[index];
              final isSelected = selectedPaymentType == type;

              return Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() => selectedPaymentType = type);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.appColor
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.appColor
                                  : AppColors.textColor,
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              type,
                              style: AppTextStyles.semiBoldUrbanist.copyWith(
                                fontSize: 19,
                                color: isSelected
                                    ? AppColors.white
                                    : AppColors.textColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// 👉 Center gap (only if not last item)
                    if (index != paymentTypes.length - 1)
                      const SizedBox(width: 15),
                  ],
                ),
              );
            }),
          ),

          const SizedBox(height: 10),

          /// Date Range
          Row(
            children: [
              Image.asset(AppImages.calendar, height: 18, width: 18),
              SizedBox(width: 5),
              Text(
                'date_range'.tr,
                style: AppTextStyles.mediumUrbanist.copyWith(
                  fontSize: 21,
                  color: AppColors.blackDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 15,
            runSpacing: 10,
            children: dateRanges.map((range) {
              final isSelected = selectedDateRange == range;
              return SizedBox(
                width: (MediaQuery.of(context).size.width - 55) / 2,
                child: GestureDetector(
                  onTap: () {
                    setState(() => selectedDateRange = range);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.appColor : AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.appColor
                            : AppColors.textColor,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        range,
                        style: AppTextStyles.semiBoldUrbanist.copyWith(
                          fontSize: 19,
                          color: isSelected
                              ? AppColors.white
                              : AppColors.textColor,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 20),

          /// Amount Range
          Text(
            '€ ${"amount_range".tr}',
            style: AppTextStyles.mediumUrbanist.copyWith(
              fontSize: 21,
              color: AppColors.blackDark,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.fadeAppBlue3Color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '€0',
                      style: AppTextStyles.semiBoldUrbanist.copyWith(
                        fontSize: 12,
                        color: AppColors.blackDark,
                      ),
                    ),
                    Text(
                      '€${amount.toInt()}',
                      style: AppTextStyles.semiBoldUrbanist.copyWith(
                        fontSize: 12,
                        color: AppColors.blackDark,
                      ),
                    ),
                  ],
                ),
                Slider(
                  activeColor: AppColors.appColor,
                  inactiveColor: Colors.white,
                  min: 0,
                  max: 300,
                  value: amount,
                  onChanged: (value) {
                    setState(() => amount = value);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// Buttons
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  buttonHeight: 42,
                  color: Colors.white,
                  isBorderEnable: true,
                  textColor: AppColors.textColor,
                  borderColor: AppColors.textColor,
                  text: "reset".tr,
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      selectedPaymentType = 'all'.tr;
                      selectedDateRange = 'this_month'.tr;
                      amount = 300;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButton(
                  buttonHeight: 42,
                  onPressed: () {
                    Navigator.pop(context, {
                      'paymentType': selectedPaymentType,
                      'dateRange': selectedDateRange,
                      'amount': amount,
                    });
                  },
                  text: 'apply_filters'.tr,
                  // textStyle: AppTextStyles.semiBoldUrbanist.copyWith(
                  //   fontSize: 15,
                  //   color: Colors.white
                  // ),
                ),
              ),
            ],
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
