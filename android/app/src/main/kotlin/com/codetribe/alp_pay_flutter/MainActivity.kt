package com.codetribe.alp_pay_flutter

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "bluecode/android"
    private lateinit var methodChannel: MethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        methodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        )

        // 👂 Flutter se request sun raha hai
        methodChannel.setMethodCallHandler { call, result ->
            if (call.method == "requestToken") {
                // Flutter ne bola → Android reply karega
                sendTokenToFlutter("TOKEN_FROM_ANDROID_123")
                result.success(null)
            }
        }
    }

    // 📢 Android → Flutter
    private fun sendTokenToFlutter(token: String) {
        methodChannel.invokeMethod("onTokenReceived", token)
    }
}
