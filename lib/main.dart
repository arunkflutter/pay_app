import 'package:alp_pay_flutter/app/bluecode_controller/bluecode_controller.dart';

import 'exports.dart';

void main() {
  Get.put(BlueCodeController());
  runApp(AlpinePayApp());
}

class AlpinePayApp extends StatelessWidget with BaseClass {
  const AlpinePayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        keyBoardOff(context);
      },
      child: GetMaterialApp(
        color: AppColors.backgroundColor,
        title: 'Alpine Pay',
        translations: AppTranslation(),
        locale: const Locale('en'),
        fallbackLocale: const Locale('en'),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splashScreen,
        getPages: AppPages.getPages,
      ),
    );
    ;
  }
}
