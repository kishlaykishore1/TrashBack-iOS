//
//  FinalizePickupVC.swift
//  TrashBack
//
//  Created by angrz singh on 03/02/22.
//

import UIKit
import Photos

class FinalizePickupVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var submitView: UIView!
    @IBOutlet weak var theSwitch: UISwitch!
    @IBOutlet weak var switchRight: NSLayoutConstraint! //12
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var colourView: UIView!
    @IBOutlet weak var lblHeadTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var switchWidth: NSLayoutConstraint! //50
    @IBOutlet weak var lblSwitchText: UILabel!
    @IBOutlet weak var switchViewTop: NSLayoutConstraint! //16
    @IBOutlet weak var switchViewHeight: NSLayoutConstraint! //55
    @IBOutlet weak var btnReport: UIControl!
    @IBOutlet weak var viewBottom1: UIView!
    @IBOutlet weak var viewBottom2: UIView!
    
    var receivedString = ""
    var isFromMap = false
    var imagePicker = UIImagePickerController()
    var captureImage: UIImage?
    var arrImages = [#imageLiteral(resourceName: "Bitmap-1")]
    var imgCheck = false
    var isFromHistory = false
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        if isFromHistory {
            btnReport.isHidden = false
            viewBottom1.isHidden = false
            viewBottom2.isHidden = false
        } else {
            btnReport.isHidden = true
            viewBottom1.isHidden = true
            viewBottom2.isHidden = true
        }
        
        setBackButton(tintColor: #colorLiteral(red: 0.01176470588, green: 0, blue: 0.2784313725, alpha: 1), isImage: true, #imageLiteral(resourceName: "ic_BackButton"))
        
        if receivedString == "Validé" {
            lblHeadTitle.text = receivedString
            lblSubtitle.text = "Ton ramassage a bien été validé par notre équique de modération. Bravo à toi !"
            lblHeadTitle.textColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
            colourView.backgroundColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
            shadowView.backgroundColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 0.25)
            infoView.isHidden = true
            submitView.isHidden = true
            theSwitch.isHidden = true
            switchRight.constant = 0
            lblSwitchText.text = "Le déchet a bien été jeté à la poubelle 🙏"
            switchWidth.constant = 0
            switchViewTop.constant = 8
            switchViewHeight.constant = 24
        } else {
            lblHeadTitle.text = receivedString
            lblSubtitle.text = "Tu as bien enregistré ton ramassage mais tu dois ajouter une photo du moment où tu je jète à la poubelle"
            lblHeadTitle.textColor = #colorLiteral(red: 0, green: 0.4862745098, blue: 1, alpha: 1)
            colourView.backgroundColor = #colorLiteral(red: 0, green: 0.4862745098, blue: 1, alpha: 1)
            shadowView.backgroundColor = #colorLiteral(red: 0, green: 0.4862745098, blue: 1, alpha: 0.25)
            infoView.isHidden = false
            submitView.isHidden = false
            theSwitch.isHidden = false
            switchRight.constant = 12
            lblSwitchText.text = "J’ai jeté le déchet à la poubelle 🙏"
            switchWidth.constant = 50
            switchViewTop.constant = 16
            switchViewHeight.constant = 55
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBarImage(for: UIImage(), color: .white, requireShadowLine: true)
        self.title = "Masque ramassé le 23 juin 2021".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DMSans-Medium", size: 13) ?? UIFont(), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2235294118, green: 0.3176470588, blue: 0.3843137255, alpha: 1) ]
    }
    
    // MARK: - Helper Methods
    
    func setup() {
        lblInfo.numberOfLines = 0
        lblInfo.textColor = #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4117647059, alpha: 1)
        let clickableTextTerms = NSMutableAttributedString(string: "Important ! ".localized, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4117647059, alpha: 1), NSAttributedString.Key.font: UIFont(name: "DMSans-Medium", size: lblInfo.font.pointSize) ?? UIFont.systemFont(ofSize: lblInfo.font.pointSize, weight: .medium)])
        let clickableTextPolicy = NSMutableAttributedString(string: "Pense à ajouter une photo te montrant jeter le déchet pour valider tes points. Les photos sont régulièrement vérifiées par notre équipe.".localized, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4117647059, alpha: 1),NSAttributedString.Key.font: UIFont(name: "DMSans-Regular", size: lblInfo.font.pointSize) ?? UIFont.systemFont(ofSize: lblInfo.font.pointSize, weight: .regular)])
        let finalString = NSMutableAttributedString()
        finalString.append(clickableTextTerms)
        finalString.append(clickableTextPolicy)
        lblInfo.attributedText = finalString
    }
    
    func actionSheetBottom() {
        let alert = UIAlertController(title: "Signaler comme invalide", message: "Si tu trouve que ce ramassage n'est pas conforme à nos Conditions Générales d'Utilisation, tu peux nous le signaler. Merci de bien vouloir choisir la raison du signalement.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title:  "Ce n'est pas un déchet/encombrant", style: .default, handler: { _ in
          setVibration()
        }))
        alert.addAction(UIAlertAction(title: "C'est un doublon", style: .default, handler: { _ in
          setVibration()
        }))
        alert.addAction(UIAlertAction(title: "Autre….", style: .default, handler: { _ in
          setVibration()
        }))
        alert.addAction(UIAlertAction.init(title: Messages.txtCancel, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Button Action Methods
    
    override func backBtnTapAction() {
        setVibration()
        if isFromMap || isFromHistory {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func btnReport_Action(_ sender: UIControl) {
        setVibration()
        actionSheetBottom()
    }
    
    @IBAction func action_theSwitch(_ sender: UISwitch) {
        if theSwitch.isOn {
            collectionView.isHidden = false
            infoView.isHidden = false
            //   btnSwitch.isOn = false
        } else {
            collectionView.isHidden = true
            infoView.isHidden = true
            // btnSwitch.isOn = true
        }
    }
    
    @IBAction func btnSeeonmap_Action(_ sender: UIControl) {
        setVibration()
        let aboutVC = StoryBoard.Home.instantiateViewController(withIdentifier: "MapVC") as! MapVC
        aboutVC.strTitle = "Masque ramassé le 23 juin 2021"
        aboutVC.isfromFinal = true
        self.navigationController?.pushViewController(aboutVC, animated: true)
    }
    
}

//MARK: - CollectionView DataSource
extension FinalizePickupVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            if receivedString == "Validé" {
                return 0
            } else {
                return 1
            }
        } else {
            if receivedString == "Validé" {
                return 1
            } else {
                return arrImages.count
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddMoreImageCollectionCell", for: indexPath) as! AddMoreImageCollectionCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowImageWasteCollectionCell", for: indexPath) as! ShowImageWasteCollectionCell
            if receivedString == "Validé" {
                cell.imgTickMark.isHidden = true
                cell.imgView.image = #imageLiteral(resourceName: "Bitmap-1")
            } else {
                cell.imgTickMark.isHidden = false
                cell.imgView.image = arrImages[indexPath.row]
            }
            return cell
        }
    }
}

//MARK: - CollectionView Delegate
extension FinalizePickupVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: self.collectionView.frame.height - 10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setVibration()
        if indexPath.section == 0 {
            let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: Messages.photoMassage, message: nil, preferredStyle: .actionSheet)
            let saveActionButton: UIAlertAction = UIAlertAction(title: Messages.txtCamera.localized, style: .default)
            { void in
                self.checkCameraPermission()
            }
            actionSheetControllerIOS8.addAction(saveActionButton)
            
            let deleteActionButton: UIAlertAction = UIAlertAction(title: Messages.txtGallery.localized, style: .default)
            { void in
                self.checkPhotoLibraryPermission()
            }
            actionSheetControllerIOS8.addAction(deleteActionButton)
            let cancelActionButton: UIAlertAction = UIAlertAction(title: Messages.txtCancel.localized, style: .cancel) { void in
                print("Cancel")
            }
            actionSheetControllerIOS8.addAction(cancelActionButton)
            self.present(actionSheetControllerIOS8, animated: true, completion: nil)
        }
    }
}

// MARK: - Camera Function
extension FinalizePickupVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func checkCameraPermission() {
        let mediaType = AVMediaType.video
        switch AVCaptureDevice.authorizationStatus(for: mediaType) {
            
        case .authorized:
            self.openCamera()
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: mediaType) { granted in
                DispatchQueue.main.async {
                    if granted {
                        self.openCamera()
                    } else {
                        self.showCameraPermissionAlert()
                    }
                }
            }
            
        case .restricted, .denied:
            self.showCameraPermissionAlert()
            
        @unknown default:
            assertionFailure("Unknown authorization status".localized)
            self.showCameraPermissionAlert()
        }
    }
    
    func showCameraPermissionAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: Constants.kAppDisplayName, message: Messages.txtCameraPermission, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Messages.txtCancel, style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: Messages.txtSetting, style: .cancel, handler: { (error) in
                let url = URL(string: UIApplication.openSettingsURLString)
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url!, options: [:], completionHandler: { (error) in
                    })
                } else {
                    UIApplication.shared.openURL(url!)
                }
            }))
            
            Constants.kAppDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized {
                    self.openGallary()
                }
            })
        } else if status == .denied {
            self.showPhotoLibraryPermissionAlert()
        } else if status == .authorized {
            self.openGallary()
        }
    }
    
    func showPhotoLibraryPermissionAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: Constants.kAppDisplayName, message: Messages.txtLibraryPermission.localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Messages.txtCancel.localized, style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: Messages.txtSetting.localized, style: .default, handler: { (error) in
                let url = URL(string: UIApplication.openSettingsURLString)
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url!, options: [:], completionHandler: { (error) in
                    })
                } else {
                    UIApplication.shared.openURL(url!)
                }
            }))
            
            Constants.kAppDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            imagePicker.mediaTypes = ["public.image"]
            imagePicker.delegate = self
            self .present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func openGallary() {
        DispatchQueue.main.async {
            self.imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.imagePicker.allowsEditing = true
            self.imagePicker.delegate = self
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImage: UIImage?
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
            self.captureImage = selectedImage!
            if !imgCheck {
                self.imgCheck = true
                self.arrImages.removeAll()
            }
            self.arrImages.append(self.captureImage ?? UIImage())
            self.collectionView.reloadData()
            //  self.imageData = selectedImage!.jpegData(compressionQuality:0.6)!
            
            picker.dismiss(animated: true, completion: nil)
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
            self.captureImage = selectedImage!
            if !imgCheck {
                self.imgCheck = true
                self.arrImages.removeAll()
            }
            self.arrImages.append(self.captureImage ?? UIImage())
            self.collectionView.reloadData()
            //  self.imageData = selectedImage!.jpegData(compressionQuality:0.7)!
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
