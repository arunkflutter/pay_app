package com.codetribe.alp_pay_flutter

import android.content.Intent
import android.os.Bundle
import androidx.annotation.NonNull
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "bluecode/android"
    lateinit var methodChannel: MethodChannel

    companion object {
        lateinit var bluecodeActivity: BluecodeActivity
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

//        ViewCompat.setOnApplyWindowInsetsListener(
//            window.decorView
//        ) { v, insets ->
//            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
//            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
//            insets
//        }
    }

    override fun onResume() {
        super.onResume()
        if (intent.data != null) {
            handleDeepLink(intent)
        }
    }

    override fun onDestroy() {
        super.onDestroy()
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        if (intent.data != null) {
            handleDeepLink(intent)
        }
    }


    private fun handleDeepLink(intent: Intent?) {
        val next = intent?.data
        val url = next?.toString()

        val nullIntent = Intent()
        setIntent(nullIntent)

        if (url != null){
            var flutterEngine = FlutterEngineCache.getInstance().get(CHANNEL)
            if (flutterEngine == null) {
                flutterEngine = FlutterEngine(this)
                initFlutterEngine(flutterEngine)
            }
            methodChannel = MethodChannel(flutterEngine!!.dartExecutor, CHANNEL)

            if (url.contains("bluecode") && url.contains("onboarding")) {
                return methodChannel.invokeMethod("onOnboardingDeepLinkReceived", url);
            }

            if (url.contains("bluecode") && url.contains("sampleapp")) {
                methodChannel?.invokeMethod("onBluecodeDeepLinkReceived", url);
            }
        }
    }

    private fun initFlutterEngine(flutterEngine: FlutterEngine) {
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )
        FlutterEngineCache.getInstance().put(CHANNEL, flutterEngine)
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "initSdk") {
                val arguments = call.arguments as? Map<String, *>
                val blueCodeConfig = mapInitArguments(arguments);

                try{
                    SdkSingleton.getInstance(application).initBluecodeSDK(blueCodeConfig)
                }catch (e: Error){
                    println(e);
                }
                result.success(true);
            }
            else if (call.method == "open") {
                val arguments = call.arguments as? Map<String, *>
                val next = createIntent(arguments);
                intent.flags = Intent.FLAG_ACTIVITY_SINGLE_TOP
                startActivity(next)
                result.success(null)
            }
            else if (call.method =="requestClaimToken"){
                if(SdkSingleton.isInitialized()){
                    LocalBroadcastManager.getInstance(this).sendBroadcast(
                        Intent("REQUEST_CLAIM_TOKEN")
                    )
                    result.success(true)
                }else {
                    methodChannel = MethodChannel(flutterEngine.dartExecutor, CHANNEL)
                    methodChannel.invokeMethod("onReceiveClaimTokenError", null);
                    result.success(false)
                }
            }else if (call.method == "enableCustomLayoutProvider") {
                BluecodeActivity.enableCustomLayoutProvider = true;
                result.success(true)
            }else if (call.method == "enableCustomHeader") {
                BluecodeActivity.enableCustomHeader = true;
                result.success(true)
            }else if (call.method == "enableCustomFooter") {
                BluecodeActivity.enableCustomFooter = true;
                result.success(true)
            }else if (call.method == "resetBluecode"){
                SdkSingleton.resetSdk();
                result.success(true)
            }else if (call.method == "close"){
                bluecodeActivity?.closeBluecode()
            }else{
                result.notImplemented()
            }
        }
        FlutterEngineCache.getInstance().put(CHANNEL, flutterEngine)
    }

    private fun createIntent(arguments: Map<String, *>?) : Intent{
        val next = Intent(this, BluecodeActivity::class.java).apply {}
        val bluecodeConfig = mapInitArguments(arguments);
        next.putExtra("blueCodeConfig",bluecodeConfig)
        return next;
    }

    private fun mapInitArguments(arguments: Map<String, *>?): Bundle {
        val bluecodeConfig = Bundle()

        val defaultValues = hashMapOf<String, Any>(
            "sdkHost" to "SAMPLEAPP",
            "appScheme" to "sampleapp",
            "deepLink" to "",
            "isProduction" to false,
        )

        if (arguments != null) {
            for ((key, value ) in arguments) {
                when(key){
                    "sdkHost" -> bluecodeConfig.putString(key, (value as? String) ?: defaultValues[key] as String)
                    "appScheme" -> bluecodeConfig.putString(key, (value as? String) ?: defaultValues[key] as String)
                    "deepLink" -> bluecodeConfig.putString(key, (value as? String) ?: defaultValues[key] as String)
                    "isProduction" -> bluecodeConfig.putBoolean(key, (value as? Boolean) ?: defaultValues[key] as Boolean)
                }
            }
        }

        return bluecodeConfig;
    }


}