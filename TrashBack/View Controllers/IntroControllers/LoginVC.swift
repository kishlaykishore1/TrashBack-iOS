//
//  LoginVC.swift
//  TrashBack
//
//  Created by kishlay kishore on 17/01/22.
//

import UIKit

class LoginVC: UIViewController {
  
  // MARK: - Outlets
  @IBOutlet weak var tfPhoneNo: UITextField!
  @IBOutlet weak var lblContryCode: UILabel!
  @IBOutlet weak var backView: UIView!
  @IBOutlet weak var btnLogin: UIButton!
  @IBOutlet weak var btnApple: UIButton!
  @IBOutlet weak var btnFacebook: UIButton!
  @IBOutlet weak var btnGoogle: UIButton!
  
  // MARK: - Properties
  var welcomeVC: WelcomeVC?
  let picker = ADCountryPicker()
  var txtDialCode = ""
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    picker.searchBarBackgroundColor = UIColor.white
    picker.hidesNavigationBarWhenPresentingSearch = false
    picker.defaultCountryCode = Locale.current.regionCode ?? "FR"
    picker.forceDefaultCountryCode = true
    lblContryCode.text = "\(emojiFlag(regionCode: picker.defaultCountryCode)!) +\(Constants.countryPrefixes[Locale.current.regionCode ?? "FR"]!)"
    txtDialCode = "+\(Constants.countryPrefixes[Locale.current.regionCode ?? "FR"]!)"
    picker.delegate = self
    DispatchQueue.main.async {
      self.btnLogin.layer.cornerRadius = self.btnLogin.frame.height / 2
      self.btnApple.layer.cornerRadius = self.btnApple.frame.height / 2
      self.btnFacebook.layer.cornerRadius = self.btnFacebook.frame.height / 2
      self.btnGoogle.layer.cornerRadius = self.btnGoogle.frame.height / 2
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    self.navigationController?.isNavigationBarHidden = true
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    self.backView.roundCorners([.topLeft, .topRight], radius: 18)
  }

  // MARK: - Helper Methods
  
  func moveToRegistration() {
    self.dismiss(animated: true) {
        let aboutVC = StoryBoard.Main.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationVC
        aboutVC.isModalInPresentation = true
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: aboutVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
  }
  
  // MARK: - Button Action Methods
  
  @IBAction func actionLogin(_ sender: DesignableButton) {
    setVibration()
    self.dismiss(animated: true) {
        let aboutVC = StoryBoard.Main.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
        //aboutVC.welcomeVC = self.welcomeVC
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: aboutVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
  }
  
  @IBAction func actionContinueWithApple(_ sender: UIControl) {
    setVibration()
    moveToRegistration()
  }
  
  @IBAction func actionContinueWithGoogle(_ sender: UIControl) {
    setVibration()
    moveToRegistration()
  }
  
  @IBAction func actionContinueWithFacebook(_ sender: UIControl) {
    setVibration()
    moveToRegistration()
  }
  
  @IBAction func actionSelectCountry(_ sender: UIControl) {
    setVibration()
    let pickerNavigationController = UINavigationController(rootViewController: picker)
    self.present(pickerNavigationController, animated: true, completion: nil)
  }
  
}

// MARK: - AD Country Picker
extension LoginVC: ADCountryPickerDelegate {
  func countryPicker(_ picker: ADCountryPicker, didSelectCountryWithName name: String, code: String, dialCode: String) {
    lblContryCode.text = "\(emojiFlag(regionCode: code)!) \(dialCode)"
    txtDialCode = dialCode
    picker.dismiss(animated: true) {
      DispatchQueue.main.async {
        self.tfPhoneNo.becomeFirstResponder()
      }
    }
  }
  func emojiFlag(regionCode: String) -> String? {
    let code = regionCode.uppercased()
    
    guard Locale.isoRegionCodes.contains(code) else {
      return nil
    }
    
    var flagString = ""
    for s in code.unicodeScalars {
      guard let scalar = UnicodeScalar(127397 + s.value) else {
        continue
      }
      flagString.append(String(scalar))
    }
    return flagString
  }
}
