//
//  OtpVC.swift
//  Chrono Green
//

import UIKit

protocol BackspaceTextFieldDelegate: AnyObject {
    func textFieldDidEnterBackspace(_ textField: BackspaceTextField)
}
class OtpVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var txtOtp1: BackspaceTextField!
    @IBOutlet weak var txtOtp2: BackspaceTextField!
    @IBOutlet weak var txtOtp3: BackspaceTextField!
    @IBOutlet weak var txtOtp4: BackspaceTextField!
    @IBOutlet weak var txtOtp5: BackspaceTextField!
    @IBOutlet weak var txtOtp6: BackspaceTextField!
    @IBOutlet weak var lblTimerCount: UILabel!
    @IBOutlet weak var btnResendCode: UIButton!
    
    // MARK: - Properties
    var verificationID: String = ""
    var mobileNo = ""
    var isRegister = false
    var mobileWithoutCode = "6 69 55 10 85"
    var count = 60  // 60sec if you want
    var resendTimer = Timer()
    var isFromSettings = false
    var textFields: [BackspaceTextField] {
        return [txtOtp1,txtOtp2,txtOtp3,txtOtp4,txtOtp5,txtOtp6]
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton(tintColor: #colorLiteral(red: 0.01176470588, green: 0, blue: 0.2784313725, alpha: 1), isImage: true, #imageLiteral(resourceName: "ic_BackButton"))
        btnResendCode.isEnabled = false
        lblTimerCount.isHidden = false
        txtOtp1.delegate = self
        txtOtp2.delegate = self
        txtOtp3.delegate = self
        txtOtp4.delegate = self
        txtOtp5.delegate = self
        txtOtp6.delegate = self
        textFields.forEach { $0.backspaceTextFieldDelegate = self }
        txtOtp1.becomeFirstResponder()
        resendTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        setNavigationBarImage(for: UIImage(), color: .white, requireShadowLine: true)
        self.title = "Vérification du téléphone".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DMSans-Medium", size: 15) ?? UIFont(), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2235294118, green: 0.3176470588, blue: 0.3843137255, alpha: 1) ]
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        resendTimer.invalidate()
    }
    
    // MARK: - Helper Methods
    
    func moveToNext() {
        setVibration()
        DispatchQueue.main.async {
            (UIApplication.shared.delegate as? AppDelegate)?.isUserLogin(true)
        }
    }
    
    override func backBtnTapAction() {
        if isFromSettings {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Button Back Action
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Action Method
extension OtpVC {
    // MARK: Confirm Button Action
    @IBAction func action_Confirm(_ sender: UIButton) {
        setVibration()
        if isFromSettings {
            if let objVC = self.navigationController?.viewControllers.filter({$0 is ProfileVC}).first {
                self.navigationController?.popToViewController(objVC, animated: true)
            } else {
                let objVC = StoryBoard.Settings.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
                self.navigationController?.pushViewController(objVC, animated: true)
            }
        } else {
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
    }
    
    
    @IBAction func btnResendCode_Action(_ sender: UIButton) {
        count = 60
        resendTimer.fire()
    }
    
    @objc func update() {
        if(count > 0) {
            count = count - 1
            print(count)
            lblTimerCount.text = "(\(count) sec)"
        }
        else {
            resendTimer.invalidate()
            lblTimerCount.text = ""
            lblTimerCount.isHidden = true
            btnResendCode.isEnabled = true
        }
    }
}

// MARK: - TextField Delegate
extension OtpVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if ((textField.text?.count)! < 1) && (string.count > 0) {
            
            if textField == txtOtp1 {
                txtOtp2.becomeFirstResponder()
            }
            if textField == txtOtp2 {
                txtOtp3.becomeFirstResponder()
            }
            if textField == txtOtp3 {
                txtOtp4.becomeFirstResponder()
            }
            if textField == txtOtp4 {
                txtOtp5.becomeFirstResponder()
            }
            if textField == txtOtp5 {
                txtOtp6.becomeFirstResponder()
            }
            if textField == txtOtp6 {
                txtOtp6.resignFirstResponder()
                moveToNext()
            }
            
            textField.text = string
            return false
            
        } else if ((textField.text?.count)! >= 1) && (string.count == 0) {
            
            if textField == txtOtp2 {
                txtOtp1.becomeFirstResponder()
            }
            if textField == txtOtp3 {
                txtOtp2.becomeFirstResponder()
            }
            if textField == txtOtp4 {
                txtOtp3.becomeFirstResponder()
            }
            if textField == txtOtp5 {
                txtOtp4.becomeFirstResponder()
            }
            if textField == txtOtp6 {
                txtOtp5.becomeFirstResponder()
            }
            if textField == txtOtp1 {
                txtOtp1.resignFirstResponder()
            }
            
            textField.text = ""
            return false
            
        } else if ((textField.text?.count)! >= 1) {
            
            textField.text = string
            return false
        }
        
        return true
    }
}
// MARK: - Backspace Tracing Delegate
extension OtpVC: BackspaceTextFieldDelegate {
    func textFieldDidEnterBackspace(_ textField: BackspaceTextField) {
        guard let index = textFields.firstIndex(of: textField) else {
            return
        }
        
        if index > 0 {
            textFields[index - 1].becomeFirstResponder()
        } else {
            view.endEditing(true)
        }
    }
}

class BackspaceTextField: UITextField {
    weak var backspaceTextFieldDelegate: BackspaceTextFieldDelegate?
    
    override func deleteBackward() {
        if text?.isEmpty ?? false {
            backspaceTextFieldDelegate?.textFieldDidEnterBackspace(self)
        }
        
        super.deleteBackward()
    }
}




