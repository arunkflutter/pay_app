import Flutter
import UIKit

class BluecodeFooter: UIViewController {
    
    private var flutterFooterEngine: FlutterEngine!
    private var flutterViewController: FlutterViewController!

    init(engine: FlutterEngine, frame: CGRect) {
        super.init(nibName: nil, bundle: nil)
        
        flutterFooterEngine = engine;
        flutterViewController = FlutterViewController(engine: flutterFooterEngine!, nibName: nil, bundle: nil)
        flutterViewController!.view.isUserInteractionEnabled = false
        
        self.addChild(flutterViewController)
        
        guard let flutterView = flutterViewController!.view else { return }
        flutterView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(flutterViewController.view)
        
        let constraints = [
            flutterView.topAnchor.constraint(equalTo: view.topAnchor),
            flutterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            flutterView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            flutterView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
         
        flutterViewController!.didMove(toParent: self)
        flutterView.layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        flutterViewController?.willMove(toParent: nil)
        flutterViewController?.removeFromParent()
        flutterViewController?.view.removeFromSuperview()
        flutterViewController = nil

        flutterFooterEngine?.destroyContext()
        flutterFooterEngine = nil
    }
}
