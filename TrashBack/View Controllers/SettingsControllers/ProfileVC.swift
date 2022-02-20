//
//  ProfileVC.swift
//  TrashBack
//
//  Created by kishlay kishore on 23/01/22.
//

import UIKit
import Photos
import AVFoundation
import GooglePlaces

class ProfileVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var imgProfileView: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var firstNameBorderview: DesignableView!
    @IBOutlet weak var lblFirstNameTop: UILabel!
    
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var lastNameBorderview: DesignableView!
    @IBOutlet weak var lbllastNameTop: UILabel!
    
    @IBOutlet weak var txtDob: UITextField!
    @IBOutlet weak var dobBorderview: DesignableView!
    @IBOutlet weak var lbldobTop: UILabel!
    
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var lblContryCode: UILabel!
    @IBOutlet weak var phoneBorderview: DesignableView!
    @IBOutlet weak var lblPhoneTop: UILabel!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var emailBorderview: DesignableView!
    @IBOutlet weak var lblEmailTop: UILabel!
    
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var addressBorderview: DesignableView!
    @IBOutlet weak var lblAddressTop: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    
    // MARK: - Varialbles
    var imagePicker = UIImagePickerController()
    var imageData = Data()
    let picker = ADCountryPicker()
    var txtDialCode = ""
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        //picker.backgroundColor = .clear
        picker.sizeToFit()
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        }
        let date = Calendar.current.date(byAdding: .year, value: -13, to: Date())
        picker.maximumDate = date
        return picker
    }()
    var isFromTab = false
    
    // MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton(tintColor: #colorLiteral(red: 0.01176470588, green: 0, blue: 0.2784313725, alpha: 1), isImage: true, #imageLiteral(resourceName: "ic_BackButton"))
        picker.searchBarBackgroundColor = UIColor.white
        picker.hidesNavigationBarWhenPresentingSearch = false
        picker.defaultCountryCode = Locale.current.regionCode ?? "FR"
        picker.forceDefaultCountryCode = true
        lblContryCode.text = "+\(Constants.countryPrefixes[Locale.current.regionCode ?? "FR"]!)"
        txtDialCode = "+\(Constants.countryPrefixes[Locale.current.regionCode ?? "FR"]!)"
        picker.delegate = self
        setRightTick()
        setup()
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        DispatchQueue.main.async {
            self.imgProfileView.layer.cornerRadius = self.imgProfileView.frame.height / 2
            self.imgProfile.layer.cornerRadius = self.imgProfile.frame.height / 2
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.setNavigationBarImage(for: UIImage(), color: .white, requireShadowLine: true)
        self.title = "Modifier mon profil".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DMSans-Medium", size: 13) ?? UIFont(), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2235294118, green: 0.3176470588, blue: 0.3843137255, alpha: 1) ]
    }
    // MARK: - Helper Methods
    
    @objc func handleDatePicker(_ datePicker: UIDatePicker) {
        txtDob.rightViewMode = .always
        dobBorderview.borderColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
        lbldobTop.textColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
    }
    
    func disablemobile() {
        txtPhone.isEnabled = false
        txtPhone.isUserInteractionEnabled = false
        txtPhone.textColor = #colorLiteral(red: 0.01568627451, green: 0.1725490196, blue: 0.3607843137, alpha: 0.5)
    }
    
    // MARK: Function To set The Tick Mark Image For Textfields
    func setRightTick() {
        txtFirstName.rightViewMode = .never
        txtFirstName.clearButtonMode = .never
        firstNameBorderview.borderColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
        lblFirstNameTop.textColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
        txtFirstName.addImageTo(txtField: txtFirstName, andImage: #imageLiteral(resourceName: "ic_GreenTick"), isLeft: false)
        
        txtLastName.rightViewMode = .never
        txtLastName.clearButtonMode = .never
        lastNameBorderview.borderColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
        lbllastNameTop.textColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
        txtLastName.addImageTo(txtField: txtLastName, andImage: #imageLiteral(resourceName: "ic_GreenTick"), isLeft: false)
        
        txtEmail.rightViewMode = .never
        txtEmail.clearButtonMode = .never
        emailBorderview.borderColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
        lblEmailTop.textColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
        txtEmail.addImageTo(txtField: txtEmail, andImage: #imageLiteral(resourceName: "ic_GreenTick"), isLeft: false)
        
        txtPhone.rightViewMode = .never
        txtPhone.clearButtonMode = .never
        phoneBorderview.borderColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
        lblPhoneTop.textColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
        txtPhone.addImageTo(txtField: txtEmail, andImage: #imageLiteral(resourceName: "ic_GreenTick"), isLeft: false)
        
        txtDob.rightViewMode = .never
        txtDob.clearButtonMode = .never
        dobBorderview.borderColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
        lbldobTop.textColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
        txtDob.addImageTo(txtField: txtDob, andImage: #imageLiteral(resourceName: "ic_GreenTick"), isLeft: false)
        
        txtAddress.rightViewMode = .never
        txtAddress.clearButtonMode = .never
        addressBorderview.borderColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
        lblAddressTop.textColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
        txtAddress.addImageTo(txtField: txtAddress, andImage: #imageLiteral(resourceName: "ic_GreenTick"), isLeft: false)
    }
    
    func setup() {
        lblInfo.numberOfLines = 0
        lblInfo.textColor = #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4117647059, alpha: 1)
        let clickableTextTerms = NSMutableAttributedString(string: "Important ! ".localized, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4117647059, alpha: 1), NSAttributedString.Key.font: UIFont(name: "DMSans-Medium", size: lblInfo.font.pointSize) ?? UIFont.systemFont(ofSize: lblInfo.font.pointSize, weight: .medium)])
        let clickableTextPolicy = NSMutableAttributedString(string: "Cette adresse sera utilisée pour t’envoyer tes cadeaux par la Poste. L’adresse doit être en France Métropolitaine.".localized, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4117647059, alpha: 1),NSAttributedString.Key.font: UIFont(name: "DMSans-Regular", size: lblInfo.font.pointSize) ?? UIFont.systemFont(ofSize: lblInfo.font.pointSize, weight: .regular)])
        let finalString = NSMutableAttributedString()
        finalString.append(clickableTextTerms)
        finalString.append(clickableTextPolicy)
        lblInfo.attributedText = finalString
    }
    
    // MARK: - Button Actions
    
    override func backBtnTapAction() {
        setVibration()
        if isFromTab {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func btnAddImage_Action(_ sender: Any) {
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
    
    @IBAction func btnModifyPhone_Action(_ sender: UIButton) {
        setVibration()
        let settingVC = StoryBoard.Settings.instantiateViewController(withIdentifier: "ModifyPhoneNoVC") as! ModifyPhoneNoVC
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
    
    @IBAction func btnRegister_Action(_ sender: UIButton) {
        setVibration()
        
    }
    
    @IBAction func actionSelectCountry(_ sender: UIControl) {
        setVibration()
        //        let pickerNavigationController = UINavigationController(rootViewController: picker)
        //        self.present(pickerNavigationController, animated: true, completion: nil)
    }
}

// MARK: - TextFiels Delegate Methods
extension ProfileVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 2 {
            setVibration()
            //textField.inputView?.backgroundColor = .white
            textField.inputView = datePicker
        } else if textField.tag == 3 {
            disablemobile()
        } else if textField.tag == 5 {
            let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            let filter = GMSAutocompleteFilter()
            filter.country = "FRA"
            autocompleteController.autocompleteFilter = filter
            let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.coordinate.rawValue) | UInt(GMSPlaceField.formattedAddress.rawValue))
            autocompleteController.placeFields = fields
            self.present(autocompleteController, animated: true, completion: nil)
        }
        //        DispatchQueue.main.async {
        //          textField.resignFirstResponder()
        //        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 5 {
            textField.inputView = UIView()
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = textField.text!.utf16.count + string.utf16.count - range.length
        switch (textField.tag) {
        case 0:
            if newLength > 0 {
                txtFirstName.rightViewMode = .always
                firstNameBorderview.borderColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
                lblFirstNameTop.textColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
            } else {
                txtFirstName.rightViewMode = .never
                firstNameBorderview.borderColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
                lblFirstNameTop.textColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
            }
        case 1:
            if newLength > 0 {
                txtLastName.rightViewMode = .always
                lastNameBorderview.borderColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
                lbllastNameTop.textColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
            } else {
                txtLastName.rightViewMode = .never
                lastNameBorderview.borderColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
                lbllastNameTop.textColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
            }
        case 2:
            if newLength > 0 {
                txtDob.rightViewMode = .always
                dobBorderview.borderColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
                lbldobTop.textColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
            } else {
                txtDob.rightViewMode = .never
                dobBorderview.borderColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
                lbldobTop.textColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
            }
        case 3:
            if newLength > 0 {
                txtPhone.rightViewMode = .always
                phoneBorderview.borderColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
                lblPhoneTop.textColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
            } else {
                txtPhone.rightViewMode = .never
                phoneBorderview.borderColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
                lblPhoneTop.textColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
            }
        case 4:
            if newLength > 0 {
                txtEmail.rightViewMode = .always
                emailBorderview.borderColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
                lblEmailTop.textColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
            } else {
                txtEmail.rightViewMode = .never
                emailBorderview.borderColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
                lblEmailTop.textColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
            }
        case 5:
            if newLength > 0 {
                txtAddress.rightViewMode = .always
                addressBorderview.borderColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
                lblAddressTop.textColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
            } else {
                txtAddress.rightViewMode = .never
                addressBorderview.borderColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
                lblAddressTop.textColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
            }
        default:
            break
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 2 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM yyyy"
            dateFormatter.locale = Locale(identifier: "fr")
            textField.text = dateFormatter.string(from: datePicker.date)
            DispatchQueue.main.async {
                self.txtEmail.becomeFirstResponder()
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

// MARK: - Camera Function
extension ProfileVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
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
            self.imgProfile.image = selectedImage!
            self.imageData = selectedImage!.jpegData(compressionQuality:0.6)!
            
            picker.dismiss(animated: true, completion: nil)
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
            self.imgProfile.image = selectedImage!
            self.imageData = selectedImage!.jpegData(compressionQuality:0.7)!
            picker.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - AD Country Picker
extension ProfileVC: ADCountryPickerDelegate {
    func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
        lblContryCode.text = "+\(dialCode)"
        txtDialCode = dialCode
        picker.dismiss(animated: true) {
            DispatchQueue.main.async {
                self.txtPhone.becomeFirstResponder()
            }
        }
    }
}

// MARK: - Google Place Autocomplete
extension ProfileVC: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        txtAddress.text = place.formattedAddress //place.name
        //    self.lat = place.coordinate.latitude
        //    self.long = place.coordinate.longitude
        dismiss(animated: true) {
            self.txtAddress.rightViewMode = .always
            self.addressBorderview.borderColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
            self.lblAddressTop.textColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
        }
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}
