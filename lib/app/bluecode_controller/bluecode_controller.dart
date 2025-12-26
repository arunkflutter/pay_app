import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BlueCodeController extends GetxController {
  static const MethodChannel _channel =
  MethodChannel('bluecode/android');

  @override
  void onInit() {
    super.onInit();
    _listenFromAndroid();
  }

  void _listenFromAndroid() {
    print("MethodChannel initialized");

    _channel.setMethodCallHandler((call) async {
      if (call.method == "onTokenReceived") {
        final String token = call.arguments;
        print("✅ Android se token aaya: $token");
      }
    });
  }

  Future<void> onTapToCall() async {
    await _channel.invokeMethod("requestToken");
  }
}
