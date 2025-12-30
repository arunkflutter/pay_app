package com.codetribe.alp_pay_flutter

import android.annotation.SuppressLint
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Bundle
import androidx.activity.OnBackPressedCallback
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.fragment.app.Fragment
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import at.bluecode.sdk.bluecodesdk.public.BCUiSdk
import at.bluecode.sdk.bluecodesdk.public.models.BCUiTrackingEvent
import at.bluecode.sdk.bluecodesdk.public.models.BCUiTrackingEventOnCantPay
import at.bluecode.sdk.bluecodesdk.public.models.BCUiTrackingEventOnConfirmMerchantTokenRequest
import at.bluecode.sdk.bluecodesdk.public.models.BCUiTrackingEventOnConfirmPayment
import at.bluecode.sdk.bluecodesdk.public.models.BCUiTrackingEventOnDidFinishLoading
import at.bluecode.sdk.bluecodesdk.public.models.BCUiTrackingEventOnHasOnboardedCards
import at.bluecode.sdk.bluecodesdk.public.models.BCUiTrackingEventOnIsLoading
import at.bluecode.sdk.bluecodesdk.public.models.BCUiTrackingEventOnLastCardDeleted
import at.bluecode.sdk.bluecodesdk.public.models.BCUiTrackingEventOnMerchantTokenStateUpdated
import at.bluecode.sdk.bluecodesdk.public.models.BCUiTrackingEventOnOnboardingCompleted
import at.bluecode.sdk.bluecodesdk.public.models.BCUiTrackingEventOnOnboardingStarted
import at.bluecode.sdk.bluecodesdk.public.models.BCUiTrackingEventOnPaymentFailed
import at.bluecode.sdk.bluecodesdk.public.models.BCUiTrackingEventOnPaymentSuccessful
import at.bluecode.sdk.bluecodesdk.public.models.BCUiTrackingEventOnSdkReset
import at.bluecode.sdk.bluecodesdk.public.models.BCUiTrackingEventOnUnlockSuccessful
import at.bluecode.sdk.bluecodesdk.public.models.BCUiTrackingEventOnWalletGenerated
import at.bluecode.sdk.bluecodesdk.public.models.toBCUiEvent
import at.bluecode.sdk.bluecodesdk.public.provider.BCUiCustomLayoutProvider
import at.bluecode.sdk.bluecodesdk.public.views.bluecode.BCUiBluecodeFragment
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel
import java.lang.Exception
import kotlinx.coroutines.*


class BluecodeActivity: AppCompatActivity(), BCUiCustomLayoutProvider {
    private var fragment: BCUiBluecodeFragment? = null;
    private lateinit var methodChannel: MethodChannel
    private val CHANNEL = "bluecode/android"
    private val customHeaderComponentHeight = 100;
    private var blueCodeConfig: Bundle? = null;

    companion object {
        var enableCustomLayoutProvider = false;
        var enableCustomHeader = false;
        var enableCustomFooter = false;
    }

    @SuppressLint("SuspiciousIndentation")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MainActivity.bluecodeActivity = this
        var flutterEngine = FlutterEngineCache.getInstance().get(CHANNEL)

         if (flutterEngine != null) {
             methodChannel = MethodChannel(flutterEngine.dartExecutor, CHANNEL)
         }

        blueCodeConfig = intent.getBundleExtra("blueCodeConfig")

        createOnBackPressed();
        showBluecode()
        setContentView(R.layout.bluecode_activity)
    }

    private fun showBluecode() {

        if (enableCustomHeader || enableCustomFooter) {
            SdkSingleton.getInstance(application).ensureInitBluecodeSDK(blueCodeConfig, this)
        }

        fragment = BCUiBluecodeFragment.createInstance()
        val transaction = supportFragmentManager.beginTransaction()
            .replace(R.id.bluecode, fragment!!)
            .commitAllowingStateLoss()
        SdkSingleton.BluecodeVisible();
    }

    fun closeBluecode(){
        LocalBroadcastManager.getInstance(this).unregisterReceiver(requestClaimTokenReceiver)
        LocalBroadcastManager.getInstance(this).unregisterReceiver(trackingBroadcastReceiver)
        SdkSingleton.BluecodeNotVisible();
        finish();
    }

    override fun onResume() {
        super.onResume()
        LocalBroadcastManager.getInstance(this).registerReceiver(requestClaimTokenReceiver, IntentFilter(
            "REQUEST_CLAIM_TOKEN")
        )
        LocalBroadcastManager.getInstance(this).registerReceiver(trackingBroadcastReceiver, IntentFilter(
            "REQUEST_CLAIM_TOKEN")
        )
        LocalBroadcastManager.getInstance(this).registerReceiver(trackingBroadcastReceiver, IntentFilter(
            "SET_URL_SCHEME")
        )
        LocalBroadcastManager.getInstance(this).registerReceiver(trackingBroadcastReceiver, IntentFilter(
            BCUiTrackingEvent.actionName)
        )
    }

    suspend fun requestClaimToken() {
        try{
            var claimToken = BCUiSdk.requestLoyaltyClaimToken()
            methodChannel?.invokeMethod("onReceivedClaimToken", claimToken);
        } catch(e: Exception) {
            methodChannel?.invokeMethod("onReceiveClaimTokenError", null);
        }
    }

    private val trackingBroadcastReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            runOnUiThread{
                val event = intent?.toBCUiEvent()
                when (event) {
                    is BCUiTrackingEventOnConfirmPayment -> {
                        methodChannel?.invokeMethod("onConfirmPayment", null);
                    }
                    is BCUiTrackingEventOnPaymentSuccessful -> {
                        methodChannel?.invokeMethod("onPaymentSuccessful", null);
                    }
                    is BCUiTrackingEventOnPaymentFailed -> {
                        methodChannel?.invokeMethod("onPaymentFailed", null);
                    }
                    is BCUiTrackingEventOnIsLoading -> {
                        methodChannel?.invokeMethod("onIsLoading", null);
                    }
                    is BCUiTrackingEventOnWalletGenerated -> {
                        methodChannel?.invokeMethod("onWalletGenerated", null)
                    }
                    is BCUiTrackingEventOnUnlockSuccessful -> {
                        methodChannel?.invokeMethod("onUnlockSuccessful", null)
                    }
                    is BCUiTrackingEventOnLastCardDeleted -> {
                        methodChannel?.invokeMethod("onLastCardDeleted", null)
                    }
                    is BCUiTrackingEventOnCantPay -> {
                        methodChannel?.invokeMethod("onCantPay", null)
                    }
                    is BCUiTrackingEventOnOnboardingStarted -> {
                        methodChannel?.invokeMethod("onOnboardingStarted", null)
                    }
                    is BCUiTrackingEventOnOnboardingCompleted -> {
                        methodChannel?.invokeMethod("onOnboardingCompleted", null)
                    }
                    is BCUiTrackingEventOnHasOnboardedCards -> {
                        methodChannel?.invokeMethod("onHasOnboardedCards", null)
                    }
                    is BCUiTrackingEventOnMerchantTokenStateUpdated -> {
                        methodChannel?.invokeMethod("onMerchantTokenStateUpdated", null)
                    }
                    is BCUiTrackingEventOnConfirmMerchantTokenRequest -> {
                        methodChannel?.invokeMethod("onConfirmMerchantTokenRequest", null)
                    }
                    is BCUiTrackingEventOnSdkReset -> {
                        methodChannel?.invokeMethod("onSdkReset", null)
                    }
                    is BCUiTrackingEventOnDidFinishLoading -> {
                        methodChannel?.invokeMethod("onDidFinishLoading", null)
                    }
                }
            }
        }
    }

    private fun createOnBackPressed() {
        val callback = object : OnBackPressedCallback(true) {
            override fun handleOnBackPressed() {
                closeBluecode()
            }
        }
        onBackPressedDispatcher.addCallback(this, callback)
    }

    private val requestClaimTokenReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent) {
            CoroutineScope(Dispatchers.Main).launch {
                requestClaimToken()
            }
        }
    }

    override fun getCustomHeader(): Fragment? {
        if (!enableCustomLayoutProvider || !enableCustomHeader) {
            return null;
        }

        return BluecodeHeader.getCustomHeader(customHeaderComponentHeight);
    }

    override fun getCustomFooter(): Fragment? {
        if (!enableCustomLayoutProvider || !enableCustomFooter) {
            return null;
        }
        return BluecodeFooter();
    }

    override fun onDestroy() {
        super.onDestroy()
        SdkSingleton.BluecodeNotVisible();
    }
}
