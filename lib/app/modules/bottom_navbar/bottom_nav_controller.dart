import 'package:alp_pay_flutter/app/modules/tabs/history/history_screen.dart';
import 'package:alp_pay_flutter/app/modules/tabs/home/home_screen.dart';

import '../../../exports.dart';

class BottomNavController extends GetxController {
  int currentIndex = 0;

  final pages = [
    HomeScreen(),
    HistoryScreen(),
    Container(
      color: Colors.green,
      child: const Center(child: Text('Pay')),
    ),
    Container(
      color: Colors.orange,
      child: const Center(child: Text('Wallet')),
    ),
    Container(
      color: Colors.pink,
      child: const Center(child: Text('Profile')),
    ),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }
}
