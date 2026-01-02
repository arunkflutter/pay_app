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

  String getInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));

    if (parts.isEmpty) return "";

    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }

    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  Color getAvatarColor(String name) {
    final colors = [
      AppColors.appColor,
      Colors.pinkAccent.shade200,
      Colors.yellow,
      Color(0xFFC78CFF),
      Colors.greenAccent.shade200,
      AppColors.green,
    ];
    return colors[name.hashCode % colors.length];
  }

  int getBottomNavBarHeight(BuildContext context) {
    return (MediaQuery.of(context).padding.bottom).toInt();
  }
}
