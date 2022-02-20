//
//  ModifyPhoneNoVC.swift
//  TrashBack
//
//  Created by kishlay kishore on 23/01/22.
//

import UIKit

class ModifyPhoneNoVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tfPhoneNo: UITextField!
    @IBOutlet weak var lblContryCode: UILabel!
    
    // MARK: - Varialbles
    let picker = ADCountryPicker()
    var txtDialCode = ""
    
    // MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton(tintColor: #colorLiteral(red: 0.01176470588, green: 0, blue: 0.2784313725, alpha: 1), isImage: true, #imageLiteral(resourceName: "ic_BackButton"))
        picker.searchBarBackgroundColor = UIColor.white
        picker.hidesNavigationBarWhenPresentingSearch = false
        picker.defaultCountryCode = Locale.current.regionCode ?? "FR"
        picker.forceDefaultCountryCode = true
        lblContryCode.text = "\(emojiFlag(regionCode: picker.defaultCountryCode)!) +\(Constants.countryPrefixes[Locale.current.regionCode ?? "FR"]!)"
        txtDialCode = "+\(Constants.countryPrefixes[Locale.current.regionCode ?? "FR"]!)"
        picker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        setNavigationBarImage(for: UIImage(), color: .white, requireShadowLine: true)
        self.title = "Vérification du téléphone".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DMSans-Medium", size: 15) ?? UIFont(), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2235294118, green: 0.3176470588, blue: 0.3843137255, alpha: 1) ]
    }
    
    // MARK: - Button Action Methods
    
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnModify_Action(_ sender: UIControl) {
        setVibration()
        let aboutVC = StoryBoard.Main.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
        aboutVC.isFromSettings = true
        self.navigationController?.pushViewController(aboutVC, animated: true)
        
    }
    
    @IBAction func actionSelectCountry(_ sender: UIControl) {
        setVibration()
        let pickerNavigationController = UINavigationController(rootViewController: picker)
        self.present(pickerNavigationController, animated: true, completion: nil)
    }
    
}

// MARK: - AD Country Picker
extension ModifyPhoneNoVC: ADCountryPickerDelegate {
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
