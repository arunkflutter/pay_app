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
    debugPrint("MethodChannel initialized");

    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "onTokenReceived":
          final String token = call.arguments;
          debugPrint("✅ Android se token aaya: $token");
          break;

        case "onBluecodeDeepLinkReceived":
          final String url = call.arguments;
          debugPrint("🌐 Deep link received: $url");
          break;

        case "onOnboardingDeepLinkReceived":
          final String url = call.arguments;
          debugPrint("📝 Onboarding deep link: $url");
          break;

        case "onReceiveClaimTokenError":
          debugPrint("❌ Claim token error from Android");
          break;

        case "onSdkInitialized":
          debugPrint("✅ SDK successfully initialized");
          break;

        default:
          debugPrint("ℹ️ Unknown method called: ${call.method}");
      }
    });
  }

  /// Call this to request a token from Android
  Future<void> requestToken() async {
    try {
      await _channel.invokeMethod("requestToken");
      debugPrint("Token request sent to Android");
    } catch (e) {
      debugPrint("❌ Error requesting token: $e");
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
      debugPrint(result ? "✅ SDK initialized" : "❌ SDK failed");
    } catch (e) {
      debugPrint("❌ SDK init error: $e");
    }
  }

  /// Open Bluecode SDK (optional)
  Future<void> openSdk() async {
    try {
      await _channel.invokeMethod('open', {
        "sdkHost": "SAMPLEAPP",
        "appScheme": "sampleapp",
      });
      debugPrint("SDK open requested");
    } catch (e) {
      debugPrint("❌ Error opening SDK: $e");
    }
  }
}
