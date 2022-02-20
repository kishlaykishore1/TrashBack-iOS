//
//  TakePictureVC.swift
//  TrashBack
//
//  Created by angrz singh on 23/01/22.
//

import UIKit
import SPStorkController
import AVFoundation

class TakePictureVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var btnTakePicture: UIControl!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var lblMessage: UILabel!
    
    // MARK: - Properties
    var nav = UINavigationController()
    var newPickup: Bool?
    private let photoOutput = AVCapturePhotoOutput()
    let captureSession = AVCaptureSession()
    var home: HomeVC?
    var vcKey: String?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if newPickup ?? false {
            lblMessage.text = "Prends en photo\nle déchet que tu as trouvé."
        } else {
            lblMessage.text = "Prend en photo les encombrants\nque tu souhaites signaler."
        }
        DispatchQueue.main.async {
            self.btnTakePicture.cornerRadius = self.btnTakePicture.frame.height/2
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
      self.navigationController?.navigationBar.isHidden = true
      self.tabBarController?.tabBar.isHidden = true
      
      openCamera()
    }
    
    @IBAction func action_backButton(_ sender: UIButton) {
        setVibration()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func action_takePicture(_ sender: UIControl) {
        let photoSettings = AVCapturePhotoSettings()
        if let photoPreviewType = photoSettings.availablePreviewPhotoPixelFormatTypes.first {
            photoSettings.previewPhotoFormat = [kCVPixelBufferPixelFormatTypeKey as String: photoPreviewType]
            photoOutput.capturePhoto(with: photoSettings, delegate: self)
        }
    }
    
    @IBAction func action_flashToogle(_ sender: UIButton) {
        setVibration()
        if sender.isSelected {
            toggleTorch(on: false)
            sender.isSelected = false
        } else {
            toggleTorch(on: true)
            sender.isSelected = true
        }
    }
    
    func stopSession() {
        if captureSession.isRunning {
            DispatchQueue.global().async {
                self.captureSession.stopRunning()
            }
        }
    }
    
}

// MARK: - AV Capture Methods
extension TakePictureVC {
    
    private func openCamera() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // the user has already authorized to access the camera.
            self.setupCaptureSession()
            
        case .notDetermined: // the user has not yet asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                if granted { // if user has granted to access the camera.
                    print("the user has granted to access the camera")
                    DispatchQueue.main.async {
                        self.setupCaptureSession()
                    }
                } else {
                    print("the user has not granted to access the camera")
                }
            }
            
        case .denied:
            print("the user has denied previously to access the camera.")
            
        case .restricted:
            print("the user can't give camera access due to some restriction.")
            
        default:
            print("something has wrong due to we can't access the camera.")
        }
    }
    
    private func setupCaptureSession() {
        
        
        if let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) {
            do {
                let input = try AVCaptureDeviceInput(device: captureDevice)
                if captureSession.canAddInput(input) {
                    captureSession.addInput(input)
                }
            } catch let error {
                print("Failed to set input device with error: \(error)")
            }
            
            if captureSession.canAddOutput(photoOutput) {
                captureSession.addOutput(photoOutput)
            }
            let cameraLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            cameraLayer.frame = self.cameraView.frame
            cameraLayer.videoGravity = .resizeAspectFill
            self.cameraView.layer.addSublayer(cameraLayer)
            captureSession.startRunning()
        }
    }
    
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
}

// MARK: - AVCapturePhotoCaptureDelegate
extension TakePictureVC: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
        let previewImage = UIImage(data: imageData)
        print(previewImage ?? UIImage())
        self.toggleTorch(on: false)
        self.stopSession()
        let vc = StoryBoard.Home.instantiateViewController(withIdentifier: "TypeOfWasteVC") as! TypeOfWasteVC
        vc.headerImage = previewImage
        vc.nav = self.nav
        vc.newPickup = self.newPickup
        vc.home = self.home
        vc.vcKey = self.vcKey
        if vcKey == "home" {
            self.home?.hidesBottomBarWhenPushed = true
            self.home?.navigationController?.pushViewController(vc, animated: true)
        } else {
            self.nav.pushViewController(vc, animated: true)
        }
        
        //        let photoPreviewContainer = PhotoPreviewView(frame: self.view.frame)
        //        photoPreviewContainer.photoImageView.image = previewImage
        //        self.view.addSubviews(photoPreviewContainer)
    }
}
