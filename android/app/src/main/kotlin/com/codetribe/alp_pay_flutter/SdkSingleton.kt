package com.codetribe.alp_pay_flutter

import android.app.Application
import android.os.Bundle
import at.bluecode.sdk.bluecodesdk.public.BCUiSdk
import at.bluecode.sdk.bluecodesdk.public.models.BCUiConfig
import at.bluecode.sdk.bluecodesdk.public.models.BCUiEnvironment
import at.bluecode.sdk.bluecodesdk.public.models.BCUiLanguage
import at.bluecode.sdk.token.BCDomain
import at.bluecode.sdk.bluecodesdk.public.provider.BCUiCustomLayoutProvider

class SdkSingleton private constructor(private val application: Application) {
    private var isBluecodeInitialized = false
    private var isSdkVisible = false

    companion object {
        @Volatile private var instance: SdkSingleton? = null

        fun getInstance(application: Application): SdkSingleton {
            return instance ?: synchronized(this) {
                instance ?: SdkSingleton(application).also { instance = it }
            }
        }
        fun isInitialized(): Boolean {
            return instance?.isBluecodeInitialized ?: false
        }

        fun setUrlScheme(deepLink: String?) {
            BCUiSdk.setUrlScheme(deepLink);
        }

        fun checkIfVisible(): Boolean? {
            return instance?.isSdkVisible
        }

        fun BluecodeVisible() {
            instance?.isSdkVisible = true
        }

        fun BluecodeNotVisible() {
            instance?.isSdkVisible = false
        }
        fun resetSdk() {
            BCUiSdk.reset();
        }
    }

    fun initBluecodeSDK(blueCodeConfig: Bundle?) {
        ensureInitBluecodeSDK(blueCodeConfig, null)
    }

    fun ensureInitBluecodeSDK(
        blueCodeConfig: Bundle?,
        customLayoutProviderDelegate: BCUiCustomLayoutProvider?
    ) {
        val props = BluecodeConfig(blueCodeConfig)
        val config = props.toConfig()

        if (!isBluecodeInitialized) {
            BCUiSdk.initialize(application, config)
            isBluecodeInitialized = true
        }

        if (props.deepLink.isNotEmpty()) {
            BCUiSdk.setUrlScheme(props.deepLink)
        }

        customLayoutProviderDelegate?.let {
            BCUiSdk.setCustomLayoutProvider(it)
        }
    }



    class BluecodeConfig(bluecodeConfig: Bundle?) {
        var sdkHost = bluecodeConfig?.getString("sdkHost") ?: "SAMPLEAPP";
        var appScheme = bluecodeConfig?.getString("appScheme") ?: "sampleapp";
        var deepLink = bluecodeConfig?.getString("deepLink") ?: "";
        var isProduction= bluecodeConfig?.getBoolean("isProduction") ?: false;

        fun toConfig(): BCUiConfig{
            val config= BCUiConfig(
                sdkHost = this.sdkHost,
                appScheme = this.appScheme,
                sdkEnvironment = if(this.isProduction) BCUiEnvironment.PRODUCTION else BCUiEnvironment.SANDBOX,
                supportedLanguages = listOf(BCUiLanguage.EN, BCUiLanguage.EN),
                domain = BCDomain.BCE,
                enableWelcomePage = true,
                enableLegalPage = true,
                sendNotificationOnPaymentSuccess = true,
                appSupportsDarkMode = false,
            )
            return config;

        }
    }
}
