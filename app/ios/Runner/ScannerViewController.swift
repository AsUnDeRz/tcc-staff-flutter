//
//  ScanQrCodeViewController.swift
//  TheConcertStaff
//
//  Created by Admin on 30/4/2562 BE.
//  Copyright © 2562 AsUnDeR. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class ScannerViewController: UIViewController {
    
    @IBOutlet weak var backDropContainer: UIView! {
        didSet {
            backDropContainer.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var backDropBottom: UIView! {
        didSet {
            backDropBottom.backgroundColor = UIColor.black.withAlphaComponent(0.66)
        }
    }
    
    @IBOutlet weak var previewContainer: UIView! {
        didSet {
            previewContainer.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var userTotalTitle: UILabel! {
        didSet {
            userTotalTitle.textColor = .white
//            userTotalTitle.font = UIFont.thonburi_withSize(size: 14)
            userTotalTitle.text = "จำนวนผู้เข้างานทั้งหมด"
        }
    }
    
    @IBOutlet weak var userScanTitle: UILabel! {
        didSet {
            userScanTitle.textColor = .white
//            userScanTitle.font = UIFont.thonburi_withSize(size: 14)
            userScanTitle.text = "เข้างานแล้ว"
        }
    }
    
    @IBOutlet weak var userTotalLabel: UILabel! {
        didSet {
            userTotalLabel.textColor = .white
//            userTotalLabel.font = UIFont.thonburi_withSize(size: 28)
            userTotalLabel.text = "0"
        }
    }
    
    @IBOutlet weak var userScanLabel: UILabel! {
        didSet {
            userScanLabel.textColor = .white
//            userScanLabel.font = UIFont.thonburi_withSize(size: 28)
            userScanLabel.text = "0"
        }
    }
    
    @IBOutlet weak var flashButton: FlashButton! {
        didSet {
            flashButton.addTarget(self, action: #selector(handleFlashButton), for: .touchUpInside)
            flashButton.tintColor = .white
        }
    }
    
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
//    private let disposeBag = DisposeBag()
//    var productId: String?
//    var product: Product?
    
//    internal static func instantiate() -> ScannerViewController {
//        let vc = Storyboard.Scanner.instantiate(ScannerViewController.self)
//        return vc
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        observeValueCount()
        setupCamera()
        setupNavigationBar()
        
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let iconGroup = UIImage(named: "icons_group")
        let rightBarButtonItem = UIBarButtonItem(image: iconGroup, style: .plain, target: self, action: #selector(openReport))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
            if self.flashButton.isOn == true {
                self.flashButton.buttonPressed()
            }
        }
    }
    
    func setupCamera(){
        
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        DispatchQueue.main.async {
            self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
            let rootLayer :CALayer = self.previewContainer.layer
            rootLayer.masksToBounds = true
            self.previewLayer.frame = rootLayer.bounds
            self.previewLayer.videoGravity = .resizeAspectFill
            rootLayer.addSublayer(self.previewLayer)
            self.captureSession.startRunning()
            self.drawBoxScanner(rootLayer: rootLayer)
        }
    }
    
    func drawBoxScanner(rootLayer:CALayer){
        //test
        let vw = UIView(frame: rootLayer.bounds)
        self.previewContainer.addSubview(vw)
        let width: CGFloat = rootLayer.bounds.width
        let height: CGFloat = rootLayer.bounds.height
        let sizeWeightTop:CGFloat = height / 5
        let sizeWeightSide:CGFloat = width / 10
        let sizeWeightBottom:CGFloat = height / 5
        let boxWidth:CGFloat = width - (sizeWeightSide*2)
        let boxHeight:CGFloat = height-(sizeWeightTop+sizeWeightBottom)
        let centerPoint:CGFloat = (boxHeight / 2)+sizeWeightTop
        
        let lineCenter = UIView(frame: CGRect(x: sizeWeightSide, y: centerPoint, width: boxWidth, height: 1))
        lineCenter.backgroundColor = .red
        let pa = UIBezierPath()
        //box top
        pa.move(to: CGPoint(x: 0, y: 0))
        pa.addLine(to: CGPoint(x: width, y: 0))
        pa.addLine(to: CGPoint(x: width, y: sizeWeightTop))
        pa.addLine(to: CGPoint(x: 0, y: sizeWeightTop))
        
        //box right
        pa.move(to: CGPoint(x: width, y: 0))
        pa.addLine(to: CGPoint(x: width, y: height))
        pa.addLine(to: CGPoint(x: width - sizeWeightSide, y: height))
        pa.addLine(to: CGPoint(x: width - sizeWeightSide, y: 0))
        
        //box bottom
        pa.move(to: CGPoint(x: width, y: height))
        pa.addLine(to: CGPoint(x: 0, y: height))
        pa.addLine(to: CGPoint(x: 0, y: height-sizeWeightBottom))
        pa.addLine(to: CGPoint(x: width, y: height-sizeWeightBottom))
        
        //box left
        pa.move(to: CGPoint(x: 0, y: height))
        pa.addLine(to: CGPoint(x: 0, y: 0))
        pa.addLine(to: CGPoint(x: sizeWeightSide, y: 0))
        pa.addLine(to: CGPoint(x: sizeWeightSide, y: height))
        
        pa.move(to: CGPoint(x: sizeWeightSide, y: centerPoint))
        pa.addLine(to: CGPoint(x: width, y: centerPoint))
        //box bottom
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = pa.cgPath
        shapeLayer.fillColor = UIColor.black.withAlphaComponent(0.66).cgColor
        
        vw.layer.addSublayer(shapeLayer)
        vw.addSubview(lineCenter)
        lineCenter.startBlink()
    }
    
    func setupNavigationBar(){
//        navigationItem.title = product?.name ?? ""
    }
    
    func observeValueCount(){
        /*
        if let id = product?.id {
            Database.database().reference().child("/event/\(id)").observe(.value) { (snapshot) in
                let countModel = snapshot.value as? [String : AnyObject] ?? [:]
                print(countModel.description)
                self.userTotalLabel.text = "\(countModel["all"] ?? "0" as AnyObject)"
                self.userScanLabel.text = "\(countModel["checkin"] ?? "0" as AnyObject)"
            }
        }
 */
    }
    
    
    
    @objc func openReport(){
        /*
        let report = ReportViewController.instantiate()
        report.productId = "\(product?.id ?? 0)"
        report.allTicket = Int(self.userTotalLabel?.text ?? "0") ?? 0
        report.checkedTicket = Int(self.userScanLabel?.text ?? "0") ?? 0
        self.navigationController?.pushViewController(report, animated: true)
 */
    }
    
    @objc func handleFlashButton() {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard device.hasTorch else { return }
        
        do {
            try device.lockForConfiguration()
            
            if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                device.torchMode = AVCaptureDevice.TorchMode.off
            } else {
                do {
                    try device.setTorchModeOn(level: 1.0)
                } catch {
                    print(error)
                }
            }
            
            device.unlockForConfiguration()
        } catch {
            print(error)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}


extension ScannerViewController : AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
    }
    
    func found(code: String) {
        print(code)
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
        /*
        let alert = ModalNotifyViewController.instantiate()
        
        Api.share.scanQrCode(productId:  "\(product?.id ?? 0)", qrCodeString: code)
            .subscribe(onNext: { (response) in
                alert.setupCompleteModal(result: response.data?.message ?? "")
                DispatchQueue.main.async {
                    self.customPresentViewController(alert.presenter, viewController: alert, animated: true)
                    AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                    AudioServicesPlayAlertSound(SystemSoundID(1322))
                }
            }, onError: { (error) in
                DispatchQueue.main.async {
                    guard let message = error.toCommonError().message else { return }
                    alert.setupFailModal(result: message)
                    self.customPresentViewController(alert.presenter, viewController: alert, animated: true)
                    AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                    AudioServicesPlayAlertSound(SystemSoundID(1073))
                }
            })
            .disposed(by: disposeBag)
        
        alert.onThisDismiss = {
            if (self.captureSession?.isRunning == false) {
                self.captureSession.startRunning()
            }
        }
 */
    }
}

extension UIView {
    func startBlink() {
        UIView.animate(withDuration: 0.8,//Time duration
            delay:0.0,
            options:[.allowUserInteraction, .curveEaseInOut, .autoreverse, .repeat],
            animations: { self.alpha = 0 },
            completion: nil)
    }
}
