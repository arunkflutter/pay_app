import 'package:alp_pay_flutter/app/widgets/filter_sheet.dart';

import '../../../../exports.dart';

class HistoryController extends GetxController {
  final List<Map<String, dynamic>> dummyTransactions = [
    {
      "name": "Anna Smith",
      "amount": 20,
      "time": "${'today'.tr}, 10:45 AM",
      "isCredit": true,
    },
    {
      "name": "John Carter",
      "amount": 45,
      "time": " ${'today'.tr}, 09:30 AM",
      "isCredit": false,
    },
    {
      "name": "Emily Brown",
      "amount": 120,
      "time": "${"yesterday".tr}, 06:15 PM",
      "isCredit": true,
    },
    {
      "name": "Michael Lee",
      "amount": 75,
      "time": "${"yesterday".tr}, 02:40 PM",
      "isCredit": false,
    },
    {
      "name": "Sophia Wilson",
      "amount": 300,
      "time": "12 Aug, 11:20 AM",
      "isCredit": true,
    },
  ];

  onTapFilterButton() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const FilterTransactionBottomSheet(),
    );
  }
}
