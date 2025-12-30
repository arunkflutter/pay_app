import 'package:alp_pay_flutter/exports.dart';

enum Status { pending, success, failed }

class TransactionStatusController extends GetxController {
  Status status = Status.success;
  String icon = AppImages.success;
  String textStatus = "Transfer Successful!";

  void onBackToDashboard() {
    // Get.offAllNamed(AppRoutes.dashboard);
  }

  void onMakeAnotherTransfer() {
    Get.back();
  }
}
