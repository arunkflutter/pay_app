//
//  Bluecode.swift
//  Runner
//
//  Created by schr3da on 28.06.21.
//

import UIKit
import Foundation

import BluecodeSdk;

enum BluecodeChannelMethodResults {
    case StringResult(String, String)
    case BooleanResult(String, Bool)
    
    func toResult(method: BluecodeChannelMethods) -> BluecodeChannelMethodResults {
        switch method {
        case .open:
            return BluecodeChannelMethodResults.BooleanResult(method.rawValue, true);
        case .close:
            return BluecodeChannelMethodResults.BooleanResult(method.rawValue, true);
        case .requestClaimToken:
            return BluecodeChannelMethodResults.BooleanResult(method.rawValue, true);
        case .initSdk:
            return BluecodeChannelMethodResults.BooleanResult(method.rawValue, true);
        case .enableCustomLayoutProvider:
            return BluecodeChannelMethodResults.BooleanResult(method.rawValue, true);
        case .enableCustomHeader:
            return BluecodeChannelMethodResults.BooleanResult(method.rawValue, true);
        case .enableCustomFooter:
            return BluecodeChannelMethodResults.BooleanResult(method.rawValue, true);
        case .resetBluecode:
            return BluecodeChannelMethodResults.BooleanResult(method.rawValue, true);
        }
    }
}

enum BluecodeChannelMethods: String {
    case initSdk = "initSdk"
    case open = "open"
    case close = "close"
    case requestClaimToken = "requestClaimToken"
    
    case resetBluecode = "resetBluecode"
    
    case enableCustomLayoutProvider = "enableCustomLayoutProvider"
    case enableCustomHeader = "enableCustomHeader"
    case enableCustomFooter = "enableCustomFooter"
}
 
struct BluecodeChannel {
    static let channelId = "bluecode/ios";
}

protocol BluecodeViewControllerDelegate {

}

class BluecodeViewController: UIViewController, BCUiCustomLayoutProvider {
    
    fileprivate var notificationObserver: Any! = nil;
    
    fileprivate weak var bluecode: BCUiBluecodeViewController?;
    
    public static var urlScheme: String? = nil;
    
    private var leftBarButtonItem : UIBarButtonItem = UIBarButtonItem();
    
    private var navigationLeftButton : UIButton!
    
    var delegate: BluecodeViewControllerDelegate?
    
    var blueCodeProps: [String: Any]?
    
    var methodChannel: FlutterMethodChannel! = nil
    
    public static var enableCustomLayoutProvider = false;
    public static var enableCustomHeader = false;
    public static var enableCustomFooter = false;

    var customHeaderComponentHeight = 100.0;
    var headerViewController: BluecodeHeader?
    var footerViewController: BluecodeFooter?
    var flutterHeaderEngine: FlutterEngine?
    var flutterFooterEngine: FlutterEngine?

    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        SdkSingleton.shared.ensureInitBluecodeSDK(blueCodeProps: blueCodeProps!, customLayoutProviderDelegate: self)
        showBluecode(sdkEnviroment: SdkSingleton.shared.getSdkEnviroment());
    
        registerBluecodeNotifications();
    }
    
    private func getBluecodeControllerFrame() -> CGRect {
        return  CGRect.init(
            origin: CGPoint.init(
                x: self.view.frame.origin.x,
                y: self.view.frame.origin.y
            ),
            size: CGSize.init(
                width: self.view.frame.width,
                height: self.view.frame.height
            ));
    }
    
     
    
    private func showBluecode(sdkEnviroment: BCUiEnvironment) {
        
        let controller: BCUiBluecodeViewController = BCUiBluecodeViewController().initialize(additionalSettingItems: nil, environment: sdkEnviroment);
        
        self.addChild(controller);
        self.view.addSubview(controller.view);
        controller.didMove(toParent: self);
  

        setNavigationBackButton()
        
        if(UIScreen.main.bounds.height <= 667){
            setViewScaling(controller: controller)
        }else{
            controller.view.frame = self.view.frame;
        }
        
        self.bluecode = controller;
        SdkSingleton.shared.BluecodeVisible();
    }
    
    private func setNavigationBackButton() {
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Close", for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        if(UIScreen.main.bounds.height <= 667){
            closeButton.titleEdgeInsets = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: -16)
        }else if(UIScreen.main.bounds.height <= 852){
            closeButton.titleEdgeInsets = UIEdgeInsets(top: 7, left: 0, bottom: 0, right: 0)
        }else{
            closeButton.titleEdgeInsets = UIEdgeInsets(top: 7, left: -7, bottom: 0, right: 0)
        }
    
        closeButton.addTarget(self, action: #selector(handleBackPressed), for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: closeButton)
        self.navigationItem.leftBarButtonItem = barButtonItem
    }
    
    
    public func closeBluecode() {

        self.bluecode?.dismiss(animated: false);
        self.bluecode?.viewWillDisappear(false);
        self.bluecode?.viewDidDisappear(false);
        self.bluecode?.willMove(toParent: nil);
        self.bluecode?.didMove(toParent: nil);
        self.bluecode?.view.removeFromSuperview();
        self.bluecode?.removeFromParent();
        
        self.flutterHeaderEngine?.viewController = nil;
        self.flutterFooterEngine?.viewController = nil;
        self.flutterHeaderEngine = nil
        self.flutterFooterEngine = nil
        
        self.headerViewController = nil;
        self.footerViewController = nil;

        SdkSingleton.shared.BluecodeNotVisible()
        self.bluecode = nil;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.unregisterNotifications();
        self.closeBluecode();
    }
        
    func registerBluecodeNotifications() {
        notificationObserver = NotificationCenter.default.addObserver(forName: BCUiSdk.BCUiEvent, object: nil, queue: nil) { (notification) in
            if let event = notification.object as? BCUiTrackingEvent {
                DispatchQueue.main.async {
                    switch event {
                      case .walletGenerated:
                        self.methodChannel.invokeMethod("onWalletGenerated", arguments:nil, result: nil);
                      case .onUnlockSuccessful:
                        self.methodChannel.invokeMethod("onUnlockSuccessful", arguments:nil, result: nil);
                      case .onLastCardDeleted:
                        self.methodChannel.invokeMethod("onLastCardDeleted", arguments:nil, result: nil);
                      case .cantPay:
                        self.methodChannel.invokeMethod("onCantPay", arguments:nil, result: nil);
                      case .onboardingStarted:
                        self.methodChannel.invokeMethod("onOnboardingStarted", arguments:nil, result: nil);
                      case .onboardingCompleted(_):
                        self.methodChannel.invokeMethod("onOnboardingCompleted", arguments:nil, result: nil);
                      case .onHasOnboardedCards:
                        self.methodChannel.invokeMethod("onHasOnboardedCards", arguments:nil, result: nil);
                      case .merchantTokenStateUpdated(_):
                        self.methodChannel.invokeMethod("onMerchantTokenStateUpdated", arguments:nil, result: nil);
                      case .confirmMerchantTokenRequest(_):
                        self.methodChannel.invokeMethod("onConfirmMerchantTokenRequest", arguments:nil, result: nil);
                      case .confirmPayment(_):
                        self.methodChannel.invokeMethod("onConfirmPayment", arguments:nil, result: nil);
                      case .onSdkReset:
                        self.methodChannel.invokeMethod("onSdkReset", arguments:nil, result: nil);
                      case .isLoading:
                        self.methodChannel.invokeMethod("onIsLoading", arguments:nil, result: nil);
                      case .didFinishLoading:
                        self.methodChannel.invokeMethod("onDidFinishLoading", arguments:nil, result: nil);
                      case .paymentSuccessful(_):
                        self.methodChannel.invokeMethod("onPaymentSuccessful", arguments:nil, result: nil);
                      case .paymentFailed(_):
                        self.methodChannel.invokeMethod("onPaymentFailed", arguments:nil, result: nil);
                      case .onMountCustomLayoutComponents:
                        self.methodChannel.invokeMethod("qrCodeScanned", arguments:nil, result: nil);
                      case .onRequireAuthentication:
                        self.methodChannel.invokeMethod("onRequireAuthentication", arguments:nil, result: nil);
                      break;
                    
                      default: return
                    }
                }
            }
        }
    }
    
    func requestClaimToken() async {
        do{
            let claimToken = try await BCUiSdk.requestLoyaltyClaimToken();
            await self.methodChannel.invokeMethod("onReceivedClaimToken", arguments: claimToken, result: nil);
        }catch{
            await self.methodChannel.invokeMethod("onReceiveClaimTokenError", arguments: nil, result: nil);
        }
    }
    
    func unregisterNotifications() {
        if (notificationObserver == nil) {
            return;
        }
        NotificationCenter.default.removeObserver(notificationObserver!);
    }
    
    @objc func handleBackPressed(sender: AnyObject) {
     //   self.closeBluecode();
        self.navigationController?.dismiss(animated: true);
    }
    

    
    func getCustomHeader() -> UIViewController? {
        if (!BluecodeViewController.enableCustomLayoutProvider || !BluecodeViewController.enableCustomHeader) {
            return nil
        }
        
        if (flutterHeaderEngine == nil){
            flutterHeaderEngine = FlutterEngine(name: "custom_layout_header")
            flutterHeaderEngine?.run(withEntrypoint: nil, initialRoute: "/custom_header")
            GeneratedPluginRegistrant.register(with: flutterHeaderEngine!)
        }
        
        self.headerViewController = BluecodeHeader(engine: flutterHeaderEngine!, frame: self.getBluecodeControllerFrame(), headerHeight: customHeaderComponentHeight)
    
        return headerViewController
    }
    
    func getCustomFooter() -> UIViewController? {
        if (!BluecodeViewController.enableCustomLayoutProvider || !BluecodeViewController.enableCustomFooter) {
            return nil;
        }
        
        if (flutterFooterEngine == nil){
            flutterFooterEngine = FlutterEngine(name: "custom_layout_footer")
            flutterFooterEngine!.run(withEntrypoint: nil, initialRoute: "/custom_footer")
            GeneratedPluginRegistrant.register(with: flutterFooterEngine!)
        }
        footerViewController = BluecodeFooter(engine:flutterFooterEngine!, frame: self.getBluecodeControllerFrame())
        
        return footerViewController
    }
    
    
    func resetViewScaling() {
        for subview in bluecode?.view.subviews ?? [] {
            subview.transform = CGAffineTransform.identity
        }
    }
    
    func setViewScaling(controller: BCUiBluecodeViewController) {
        let scaleFactor: CGFloat = 0.95
        controller.view.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
    }

}



