import '../../../exports.dart';

class BottomNavController extends GetxController {
  int currentIndex = 0;

  final pages = [
    HomeScreen(),
    HistoryScreen(),
    Container(color: Colors.green),
    WalletScreen(),
    ProfileScreen(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    update();
  }
}
