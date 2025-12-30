import '../../exports.dart';

class BlueCodeController extends GetxController {
  static const MethodChannel _channel = MethodChannel('bluecode/android');

  @override
  void onInit() {
    super.onInit();
    _listenFromAndroid();
  }

  /// Listen from Android for events like token, deep link, or SDK status
  void _listenFromAndroid() {
    print("MethodChannel initialized");

    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "onTokenReceived":
          final String token = call.arguments;
          print("✅ Android se token aaya: $token");
          break;

        case "onBluecodeDeepLinkReceived":
          final String url = call.arguments;
          print("🌐 Deep link received: $url");
          break;

        case "onOnboardingDeepLinkReceived":
          final String url = call.arguments;
          print("📝 Onboarding deep link: $url");
          break;

        case "onReceiveClaimTokenError":
          print("❌ Claim token error from Android");
          break;

        case "onSdkInitialized":
          print("✅ SDK successfully initialized");
          break;

        default:
          print("ℹ️ Unknown method called: ${call.method}");
      }
    });
  }

  /// Call this to request a token from Android
  Future<void> requestToken() async {
    try {
      await _channel.invokeMethod("requestToken");
      print("Token request sent to Android");
    } catch (e) {
      print("❌ Error requesting token: $e");
    }
  }

  /// Call this to init the Bluecode SDK
  Future<void> initSdk() async {
    try {
      final bool result = await _channel.invokeMethod('initSdk', {
        "sdkHost": "SAMPLEAPP",
        "appScheme": "sampleapp",
        "deepLink": "",
        "isProduction": false,
      });
      print(result ? "✅ SDK initialized" : "❌ SDK failed");
    } catch (e) {
      print("❌ SDK init error: $e");
    }
  }

  /// Open Bluecode SDK (optional)
  Future<void> openSdk() async {
    try {
      await _channel.invokeMethod('open', {
        "sdkHost": "SAMPLEAPP",
        "appScheme": "sampleapp",
      });
      print("SDK open requested");
    } catch (e) {
      print("❌ Error opening SDK: $e");
    }
  }
}
