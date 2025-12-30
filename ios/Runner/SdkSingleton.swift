//
//  InitSDK.swift
//  Runner
//
//  Created by Lukas Körbler on 11.12.23.
//

import Foundation
import BluecodeSdk

struct BlueCodeProps {
    public var sdkHost: String;
    public var appScheme: String;
    public var deepLink: String;
    public var isProduction: Bool;
    
    init(from dictionary: [String: Any]) {
        self.sdkHost = dictionary["sdkHost"] as? String ?? "SAMPLEAPP"
        self.appScheme = dictionary["appScheme"] as? String ?? "sampleapp"
        self.deepLink = dictionary["deepLink"] as? String ?? ""
        self.isProduction = dictionary["isProduction"] as? Bool ?? false
    }
     
    func toConfig() -> BCUiConfig{
        var config = BCUiConfig();
        config.sdkHost = self.sdkHost;
        config.appScheme = self.appScheme;
        config.sdkEnvironment = self.isProduction ? .production : .sandbox;
        config.supportedLanguages = [.de, .en]
        config.domain = .BCE
        config.enableWelcomePage = true
        config.sendNotificationOnPaymentSuccess = true
        config.enableLegalPage = true
        return config;
    }
}

@objc class SdkSingleton: NSObject {
    @objc static let shared = SdkSingleton()
    private var isBluecodeInitialized = false
    private var sdkEnviroment: BCUiEnvironment? = nil
    private var isSdkVisible: Bool = false

    @objc static func initBluecodeSDK(blueCodeProps: [String: Any]) {
        SdkSingleton.shared.ensureInitBluecodeSDK(blueCodeProps: blueCodeProps, customLayoutProviderDelegate: nil)
    }
    
    @objc func ensureInitBluecodeSDK(blueCodeProps: [String: Any], customLayoutProviderDelegate: BluecodeSdk.BCUiCustomLayoutProvider?) {
        
        let props = BlueCodeProps.init(from: blueCodeProps);

        if(!isBluecodeInitialized){
            let config: BCUiConfig = props.toConfig();
            sdkEnviroment = config.sdkEnvironment;
            
            BCUiSdk.intialize(config: config);
            BCUiSdk.customLayoutProvider = customLayoutProviderDelegate;
            isBluecodeInitialized = true
        }
        
        BCUiSdk.customLayoutProvider = customLayoutProviderDelegate;
        
        if(!props.deepLink.isEmpty){
              BCUiSdk.urlScheme = props.deepLink;
        }
    }
    
    @objc static func isInitialized() -> Bool {
        return shared.isBluecodeInitialized
    }
    
    @objc static func setUrlScheme(deepLink: String) {
        BCUiSdk.urlScheme = deepLink;
    }
    
    @objc func getSdkEnviroment() -> BCUiEnvironment {
        return sdkEnviroment!;
    }
    
    @objc func checkIfVisible() -> Bool {
        return isSdkVisible
    }
  
    @objc func BluecodeVisible() {
        isSdkVisible = true
    }

    @objc func BluecodeNotVisible() {
        isSdkVisible = false
    }
    
    @objc func resetSdk() {
        BCUiSdk.reset();
    }
}


