import '../../exports.dart';

mixin BaseClass {
  keyBoardOff(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }

  String getGreetings() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return "good_morning".tr;
    } else if (hour >= 12 && hour < 17) {
      return "good_afternoon".tr;
    } else if (hour >= 17 && hour < 21) {
      return "good_evening".tr;
    } else {
      return "good_night".tr;
    }
  }
}
