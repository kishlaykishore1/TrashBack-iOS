//
//  TypeOfWasteVC.swift
//  TrashBack
//
//  Created by angrz singh on 23/01/22.
//

import UIKit
import MXParallaxHeader
import Photos

class TypeOfWasteVC: UIViewController {
    
    @IBOutlet weak var imgViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var scrView: UIScrollView!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var typeOfWasteCollectionView: UICollectionView!
    @IBOutlet weak var addMoreCollectionView: UICollectionView!
    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var switchView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var validateView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var btnSwitch: UISwitch!
    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var txtdescription: KMPlaceholderTextView!
    
    var typeOfWaste: Int?
    var arrImage = [#imageLiteral(resourceName: "plastic"), #imageLiteral(resourceName: "wine-bottles"), #imageLiteral(resourceName: "box"), #imageLiteral(resourceName: "battray"), #imageLiteral(resourceName: "dirty_shirt")]
    var arrImage2 = [#imageLiteral(resourceName: "ic_couch"), #imageLiteral(resourceName: "ic_trash"), #imageLiteral(resourceName: "ic_WaterPolution"), #imageLiteral(resourceName: "ic_GarbageBin")]
    var arrTitle = ["Plastique", "Verre", "Papier / Carton", "Métaux", "Textile"]
    var arrTitle2 = ["Meubles", "Gravas", "Polluant", "Décharge"]
    var takePictureVC: TakePictureVC?
    var nav = UINavigationController()
    var newPickup: Bool?
    var headerImage: UIImage?
    var isSelectCategory = false
    var vcKey: String?
    var home: HomeVC?
    var imagePicker = UIImagePickerController()
    var captureImage: UIImage?
    var arrImages = [#imageLiteral(resourceName: "Bitmap-1")]
    var imgCheck = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.scrView.delegate = self
        txtdescription.textContainerInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        //txtdescription.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        DispatchQueue.main.async {
            self.roundedView.roundCorners([.topLeft, .topRight], radius: 21.0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imgView.image = headerImage
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
    
    func setupViews() {
        if newPickup ?? false {
            if isSelectCategory {
                self.descriptionView.isHidden = true
                self.addMoreCollectionView.isHidden = false
                self.categoryView.isHidden = false
                self.switchView.isHidden = false
                self.infoView.isHidden = false
                self.validateView.isHidden = false
                setup()
            } else {
                self.descriptionView.isHidden = true
                self.addMoreCollectionView.isHidden = true
                self.categoryView.isHidden = true
                self.switchView.isHidden = true
                self.infoView.isHidden = true
                self.validateView.isHidden = true
                setup()
            }
            
            // lblInfo.text = "Important ! Pense à ajouter une photo te montrant jeter le déchet pour valider tes points. Les photos sont régulièrement vérifiées par notre équipe."
        } else {
            self.validateView.isHidden = false
            self.descriptionView.isHidden = false
            self.addMoreCollectionView.isHidden = true
            self.categoryView.isHidden = true
            self.switchView.isHidden = true
            self.infoView.isHidden = false
            lblInfo.text = "Tu peux ajouter une petite description à propos de ton signalement."
        }
    }
    
    // MARK: - Button Action Methods
    @IBAction func action_btnSwitch(_ sender: UISwitch) {
        if btnSwitch.isOn {
            addMoreCollectionView.isHidden = false
            infoView.isHidden = false
         //   btnSwitch.isOn = false
        } else {
            addMoreCollectionView.isHidden = true
            infoView.isHidden = true
           // btnSwitch.isOn = true
        }
    }
    
    @IBAction func action_openCategory(_ sender: UIButton) {
        setVibration()
        let vc = StoryBoard.Home.instantiateViewController(withIdentifier: "ChooseCategoryVC") as! ChooseCategoryVC
        vc.typeOfWasteVC = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func action_validateTap(_ sender: UIButton) {
        setVibration()
        self.dismiss(animated: true) {
            if self.vcKey == "home" {
                let vc = StoryBoard.Home.instantiateViewController(withIdentifier: "RewardPointsVC") as! RewardPointsVC
                vc.nav = self.nav
                vc.newPickup = self.newPickup
                self.home?.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = StoryBoard.Home.instantiateViewController(withIdentifier: "RewardPointsVC") as! RewardPointsVC
                vc.nav = self.nav
                vc.newPickup = self.newPickup
                self.nav.pushViewController(vc, animated: true)
            }
            
        }
    }
    
    @IBAction func action_backButton(_ sender: UIButton) {
        setVibration()
        if vcKey == "home" {
            self.home?.navigationController?.popViewController(animated: true)
        } else {
            self.nav.popViewController(animated: true)
        }
    }
    
}

// MARK: - Camera Function
extension TypeOfWasteVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
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
            self.addMoreCollectionView.reloadData()
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
            self.addMoreCollectionView.reloadData()
          //  self.imageData = selectedImage!.jpegData(compressionQuality:0.7)!
            picker.dismiss(animated: true, completion: nil)
        }
    }
}



// MARK: - ScrollView Delegate
extension TypeOfWasteVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(self.scrView.contentOffset.y)
        if self.scrView.contentOffset.y == 0 {
            self.imgViewHeight.constant = 350
        } else if self.scrView.contentOffset.y < 0 {
            self.imgViewHeight.constant = 350 + abs(self.scrView.contentOffset.y)
        }
    }
}

//MARK: - CollectionView DataSource
extension TypeOfWasteVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == addMoreCollectionView {
            return 2
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == addMoreCollectionView {
            if section == 0 {
                return 1
            } else {
                return arrImages.count
            }
        } else {
            if newPickup ?? false {
                return arrTitle.count
            } else {
                return arrTitle2.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == addMoreCollectionView {
            if indexPath.section == 0 {
                let cell = addMoreCollectionView.dequeueReusableCell(withReuseIdentifier: "AddMoreImageCollectionCell", for: indexPath) as! AddMoreImageCollectionCell
                return cell
            } else {
                let cell = addMoreCollectionView.dequeueReusableCell(withReuseIdentifier: "ShowImageWasteCollectionCell", for: indexPath) as! ShowImageWasteCollectionCell
                cell.imgView.image = arrImages[indexPath.row]
                return cell
            }
        } else {
            let cell = typeOfWasteCollectionView.dequeueReusableCell(withReuseIdentifier: "TypeOfWasteCollectionCell", for: indexPath) as! TypeOfWasteCollectionCell
            cell.bckView.backgroundColor = self.typeOfWaste == indexPath.row ? #colorLiteral(red: 0.2849054039, green: 0.3921816051, blue: 0.460280478, alpha: 1) : #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            if newPickup ?? false {
                cell.lblName.text = arrTitle[indexPath.row]
                cell.imgView.image = arrImage[indexPath.row]
            } else {
                cell.lblName.text = arrTitle2[indexPath.row]
                cell.imgView.image = arrImage2[indexPath.row]
            }
            cell.lblName.textColor = self.typeOfWaste == indexPath.row ? #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.2849054039, green: 0.3921816051, blue: 0.460280478, alpha: 1)
            cell.bckView.borderColor = self.typeOfWaste == indexPath.row ? #colorLiteral(red: 0.5725490196, green: 0.6392156863, blue: 0.6862745098, alpha: 1) : #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
            if isSelectCategory {
                DispatchQueue.main.async {
                    self.setupViews()
                }
            }
            return cell
        }
    }
}

//MARK: - CollectionView Delegate
extension TypeOfWasteVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == addMoreCollectionView {
            return CGSize(width: 140, height: self.addMoreCollectionView.frame.height - 10)
        } else {
            return CGSize(width: 108, height: 115)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setVibration()
        if collectionView == addMoreCollectionView {
            if indexPath.section == 0 {
                setVibration()
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
        } else {
            self.typeOfWaste = indexPath.row
            self.isSelectCategory = true
            typeOfWasteCollectionView.reloadData()
        }
    }
}


//extension TypeOfWasteVC: UITextViewDelegate {
//    func sizeOfString (string: String, constrainedToWidth width: Double, font: UIFont) -> CGSize {
//        return (string as NSString).boundingRect(with: CGSize(width: width, height: DBL_MAX),
//                                                 options: NSStringDrawingOptions.usesLineFragmentOrigin,
//                                                 attributes: [NSAttributedString.Key.font: font],
//            context: nil).size
//    }
//
//
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
//        var textWidth = textView.frame.inset(by: textView.textContainerInset).width
//        textWidth -= 2.0 * textView.textContainer.lineFragmentPadding;
//
//        let boundingRect = sizeOfString(string: newText, constrainedToWidth: Double(textWidth), font: textView.font!)
//        let numberOfLines = boundingRect.height / textView.font!.lineHeight;
//
//        return numberOfLines <= 5;
//    }
//
//}
