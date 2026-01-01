import 'package:alp_pay_flutter/app/view/tabs/scanner/scanner_screen.dart';

import '../../../exports.dart';

class BottomNavController extends GetxController {
  int currentIndex = 0;

  final pages = [
    HomeScreen(),
    HistoryScreen(),
    ScannerScreen(),
    WalletScreen(),
    ProfileScreen(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }
}
