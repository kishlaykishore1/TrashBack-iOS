//
//  RegistrationVC.swift
//  Chrono Green
//

import UIKit
import Photos
import AVFoundation
import UserNotifications
import GooglePlaces

class RegistrationVC: UIViewController {
  
  // MARK: Outlets
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
  
  @IBOutlet weak var txtEmail: UITextField!
  @IBOutlet weak var emailBorderview: DesignableView!
  @IBOutlet weak var lblEmailTop: UILabel!
  
  @IBOutlet weak var txtAddress: UITextField!
  @IBOutlet weak var addressBorderview: DesignableView!
  @IBOutlet weak var lblAddressTop: UILabel!
    
    @IBOutlet weak var txtReferalCode: UITextField!
    @IBOutlet weak var referalBorderview: DesignableView!
    @IBOutlet weak var lblReferalTop: UILabel!
  
  // MARK: - Properties
    var imagePicker = UIImagePickerController()
    var imageData = Data()
    lazy var datePicker: UIDatePicker = {
      let picker = UIDatePicker()
      picker.datePickerMode = .date
     // picker.backgroundColor = .clear
      picker.sizeToFit()
      if #available(iOS 13.4, *) {
        picker.preferredDatePickerStyle = .wheels
      }
        let date = Calendar.current.date(byAdding: .year, value: -13, to: Date())
        picker.maximumDate = date
      return picker
    }()
    
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setBackButton(tintColor: #colorLiteral(red: 0.01176470588, green: 0, blue: 0.2784313725, alpha: 1), isImage: true, #imageLiteral(resourceName: "ic_BackButton"))
    self.navigationController?.navigationBar.backgroundColor = .white
    setRightTick()
    datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
    DispatchQueue.main.async {
      self.imgProfileView.layer.cornerRadius = self.imgProfileView.frame.height / 2
      self.imgProfile.layer.cornerRadius = self.imgProfile.frame.height / 2
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.navigationBar.isHidden = false
      let appearance = UINavigationBarAppearance()
      appearance.configureWithOpaqueBackground()
      appearance.shadowImage = UIImage()
      appearance.backgroundColor = .white
      appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DMSans-Medium", size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .medium), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2235294118, green: 0.3176470588, blue: 0.3843137255, alpha: 1) ]
      self.title = "Inscription".localized
      self.navigationController?.navigationBar.standardAppearance = appearance
  }
  
  override func backBtnTapAction() {
      setVibration()
    self.dismiss(animated: true, completion: nil)
  }
  
  @objc func handleDatePicker(_ datePicker: UIDatePicker) {
    txtDob.rightViewMode = .always
    dobBorderview.borderColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
    lbldobTop.textColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
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
      
      txtReferalCode.rightViewMode = .never
      txtReferalCode.clearButtonMode = .never
      referalBorderview.borderColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
      lblReferalTop.textColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
      txtReferalCode.addImageTo(txtField: txtAddress, andImage: #imageLiteral(resourceName: "ic_GreenTick"), isLeft: false)
  }
  
  // MARK: Back Button Action
  @IBAction func btnBack_Action(_ sender: UIBarButtonItem) {
    self.navigationController?.popViewController(animated: true)
  }
  
  // MARK: Add Image Button Action
  @IBAction func btnAddImage_Action(_ sender: Any) {
      setVibration()
      let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: Messages.photoMassage, message: nil, preferredStyle: .actionSheet)
      let saveActionButton: UIAlertAction = UIAlertAction(title: Messages.txtCamera.localized, style: .default)
      { void in
          setVibration()
          self.checkCameraPermission()
      }
      actionSheetControllerIOS8.addAction(saveActionButton)
      
      let deleteActionButton: UIAlertAction = UIAlertAction(title: Messages.txtGallery.localized, style: .default)
      { void in
          setVibration()
          self.checkPhotoLibraryPermission()
      }
      actionSheetControllerIOS8.addAction(deleteActionButton)
      let cancelActionButton: UIAlertAction = UIAlertAction(title: Messages.txtCancel.localized, style: .cancel) { void in
          setVibration()
          print("Cancel")
      }
      actionSheetControllerIOS8.addAction(cancelActionButton)
      self.present(actionSheetControllerIOS8, animated: true, completion: nil)
  }
  
  // MARK: Continue Button Action
  @IBAction func BtnContinue_Action(_ sender: UIButton) {
      setVibration()
      DispatchQueue.main.async {
          self.dismiss(animated: true) {
              (UIApplication.shared.delegate as? AppDelegate)?.isUserLogin(true)
          }
      }
//      DispatchQueue.main.async {
//        self.dismiss(animated: true) {
//            let aboutVC = StoryBoard.Main.instantiateViewController(withIdentifier: "NotificationPermissionVC") as! NotificationPermissionVC
//            aboutVC.isModalInPresentation = true
//            guard let getNav = UIApplication.topViewController()?.navigationController else {
//                return
//            }
//            let rootNavView = UINavigationController(rootViewController: aboutVC)
//            getNav.present( rootNavView, animated: true, completion: nil)
//        }
//      }
  }
}

// MARK: - TextFiels Delegate Methods
extension RegistrationVC: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if textField.tag == 2 {
      setVibration()
      //textField.inputView?.backgroundColor = .white
      textField.inputView = datePicker
    } else if textField.tag == 4 {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        let filter = GMSAutocompleteFilter()
        filter.country = "FRA"
        autocompleteController.autocompleteFilter = filter
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) | UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.coordinate.rawValue) | UInt(GMSPlaceField.formattedAddress.rawValue))
        autocompleteController.placeFields = fields
        self.present(autocompleteController, animated: true, completion: nil)
    }
//    DispatchQueue.main.async {
//        textField.resignFirstResponder()
//    }
  }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 4 {
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
        txtEmail.rightViewMode = .always
        emailBorderview.borderColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
        lblEmailTop.textColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
      } else {
        txtEmail.rightViewMode = .never
        emailBorderview.borderColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
        lblEmailTop.textColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
      }
    case 4:
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
        if newLength > 0 {
          txtReferalCode.rightViewMode = .always
          referalBorderview.borderColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
            lblReferalTop.textColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
        } else {
    txtReferalCode.rightViewMode = .never
            referalBorderview.borderColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
          lblReferalTop.textColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
        }
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
extension RegistrationVC: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
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

// MARK: - Google Place Autocomplete
extension RegistrationVC: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        txtAddress.text = place.formattedAddress //place.name
        txtAddress.rightViewMode = .always
        addressBorderview.borderColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
        lblAddressTop.textColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}
