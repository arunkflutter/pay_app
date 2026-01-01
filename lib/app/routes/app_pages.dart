import 'package:alp_pay_flutter/app/view/tabs/transaction_page/transaction_details.dart';

import '../../exports.dart';

class AppPages {
  static List<GetPage> getPages = [
    GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),
    GetPage(name: AppRoutes.onboardingScreen, page: () => OnboardingScreen()),
    GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),
    GetPage(name: AppRoutes.forgetPassScreen, page: () => ForgetPassScreen()),
    GetPage(name: AppRoutes.signUpScreen, page: () => SignUpScreen()),
    GetPage(name: AppRoutes.bottomNavbar, page: () => BottomNavbar()),
    GetPage(name: AppRoutes.sendMoneyScreen, page: () => SendMoneyScreen()),
    GetPage(name: AppRoutes.transactionStatus, page: () => TransactionStatus()),
    GetPage(name: AppRoutes.editProfile, page: () => EditProfile()),
    GetPage(
      name: AppRoutes.transactionDetails,
      page: () => TransactionDetails(),
    ),
  ];
}
