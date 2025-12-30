import 'package:alp_pay_flutter/app/view/tabs/wallet/wallet_screen.dart';

import '../../../exports.dart';

class BottomNavController extends GetxController {
  int currentIndex = 0;

  final pages = [
    HomeScreen(),
    HistoryScreen(),
    Container(
      color: Colors.green,
    ),
    WalletScreen(),
    Container(
      color: Colors.pink,
    ),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }
}
