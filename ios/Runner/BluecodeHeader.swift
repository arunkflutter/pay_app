import Flutter
import UIKit

class BluecodeHeader: UIViewController {
    
    var flutterHeaderEngine: FlutterEngine?
    private var flutterHeaderViewController: FlutterViewController?
    
    init(engine: FlutterEngine, frame: CGRect, headerHeight: CGFloat) {
        super.init(nibName: nil, bundle: nil)
        
        flutterHeaderEngine = engine;
        
        flutterHeaderViewController = FlutterViewController(engine: flutterHeaderEngine!, nibName: nil, bundle: nil)
        flutterHeaderViewController!.view.isUserInteractionEnabled = false
        
        self.addChild(flutterHeaderViewController!)
        
        guard let flutterView = flutterHeaderViewController!.view else { return }
        flutterView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(flutterView)
        
        let constraints = [
            flutterView.topAnchor.constraint(equalTo: view.topAnchor),
            flutterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            flutterView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            flutterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            flutterView.heightAnchor.constraint(equalToConstant: headerHeight)
        ]
        
        
        NSLayoutConstraint.activate(constraints)
        
        flutterHeaderViewController!.didMove(toParent: self)
        flutterView.layoutIfNeeded()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        flutterHeaderViewController?.willMove(toParent: nil)
        flutterHeaderViewController?.removeFromParent()
        flutterHeaderViewController?.view.removeFromSuperview()
        flutterHeaderViewController = nil

        flutterHeaderEngine?.destroyContext()
        flutterHeaderEngine = nil
    }
   
}
