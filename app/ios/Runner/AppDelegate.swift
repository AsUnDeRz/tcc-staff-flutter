import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var flutterVC: FlutterViewController!

    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    
    GeneratedPluginRegistrant.register(with: self)
    initMethodChannel()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    private func initMethodChannel() {
        flutterVC = window?.rootViewController as? FlutterViewController
        
        let channel = FlutterMethodChannel(name: "flutter.theconcert/scan", binaryMessenger: flutterVC)
        
        channel.setMethodCallHandler { [unowned self] (methodCall, result) in
            guard let arg = (methodCall.arguments as! [String]).first else { return }
            
            switch methodCall.method {
            case "openCamera":
                self.openSecondPage(param: arg)
            case "showDialog":
                self.openAlert(param: arg, result: result)
            default:
                debugPrint(methodCall.method)
                result(methodCall.method)
            }
        }
    }
    
    private func openSecondPage(param: String) {
        let sb = UIStoryboard(name: "Scanner", bundle: nil)
        let nav = sb.instantiateViewController(withIdentifier: "ScannerViewController")
        
        if let vc = nav.childViewControllers.first as? ScannerViewController {
            vc.navigationItem.title = param
        }
        
        flutterVC.present(nav, animated: true, completion: nil)
    }
    
    private func openAlert(param: String, result: @escaping FlutterResult) {
        let alert = UIAlertController(title: "Native Alert", message: param, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            result("Ok was pressed")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (_) in
            result("Cancel was pressed")
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        flutterVC.present(alert, animated: true, completion: nil)
    }
    
}
