//
//  WelcomeVC.swift
//  Ganesha
//
//  Created by kishlay kishore on 01/06/21.
//

import UIKit
import SPStorkController
import AuthenticationServices

class WelcomeVC: UIViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak var lblPrivacyPolicy: TTTAttributedLabel!
  @IBOutlet weak var btnAppleLogin: UIButton!
  
  // MARK: - View Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    
    DispatchQueue.main.async {
      self.btnAppleLogin.layer.cornerRadius = self.btnAppleLogin.frame.height / 2
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    self.navigationController?.navigationBar.isHidden = true
  }
  
  // MARK: - Button Action Methods
  @IBAction func btnContinueWithApple_Action(_ sender: UIButton) {
    setVibration()
//    self.dismiss(animated: true) {
      DispatchQueue.main.async {
          let aboutVC = StoryBoard.Main.instantiateViewController(withIdentifier: "RegistrationVC") as! RegistrationVC
          aboutVC.isModalInPresentation = true
          guard let getNav = UIApplication.topViewController()?.navigationController else {
              return
          }
          let rootNavView = UINavigationController(rootViewController: aboutVC)
          getNav.present( rootNavView, animated: true, completion: nil)
      }
        
    //}
  }
  
  @IBAction func btnContinueWithEmail_Action(_ sender: UIButton) {
    setVibration()
    openLoginOptions()
    
  }
  
  // login Function
  func openLoginOptions() {
    let loginVC = StoryBoard.Main.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
    let transitionDelegate = SPStorkTransitioningDelegate()
    loginVC.transitioningDelegate = transitionDelegate
    loginVC.modalPresentationStyle = .custom
    loginVC.welcomeVC = self
    loginVC.modalPresentationCapturesStatusBarAppearance = true
    transitionDelegate.showIndicator = false
    self.present(loginVC, animated: true, completion: nil)
  }
}

// MARK:- TermsOfUse Label Set
extension WelcomeVC {
  func setup() {
    lblPrivacyPolicy.numberOfLines = 0
    let txt1 = "En continuant vous reconnaissez avoir lu notre".localized
    let txt2 = "et vous acceptez nos".localized
    let txt3 = "."
    
    let strPP = Messages.txtPPNewsFeed
    let strTC = Messages.txtTCNewsFeed
    
    let string = "\(txt1) \(strPP) \(txt2) \(strTC)\(txt3)"
    let nsString = string as NSString
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = 1
    
    let fullAttributedString = NSAttributedString(string:string, attributes: [
      NSAttributedString.Key.paragraphStyle: paragraphStyle,
      NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.42),
      NSAttributedString.Key.font: UIFont.init(name: "SFUIDisplay-Regular", size: 11) ?? UIFont()
    ])
    
    lblPrivacyPolicy.textAlignment = .center
    lblPrivacyPolicy.attributedText = fullAttributedString
    
    let rangePP = nsString.range(of: strPP)
    let rangeTC = nsString.range(of: strTC)
    
    let ppLinkAttributes: [String: Any] = [
      NSAttributedString.Key.foregroundColor.rawValue: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.42),
      NSAttributedString.Key.underlineStyle.rawValue: false,
      NSAttributedString.Key.font.rawValue: UIFont.init(name: "SFUIDisplay-Semibold", size: 11) ?? UIFont()
    ]
    
    lblPrivacyPolicy.activeLinkAttributes = ppLinkAttributes
    lblPrivacyPolicy.linkAttributes = ppLinkAttributes
    
    let urlPP = URL(string: "action://PP")!
    let urlTC = URL(string: "action://TC")!
    lblPrivacyPolicy.addLink(to: urlPP, with: rangePP)
    lblPrivacyPolicy.addLink(to: urlTC, with: rangeTC)
    
    lblPrivacyPolicy.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.42)
    lblPrivacyPolicy.delegate = self
  }
}

//MARK:- TTTAttributedLabelDelegate
extension WelcomeVC: TTTAttributedLabelDelegate {
  func attributedLabel(_ label: TTTAttributedLabel!, didSelectLinkWith url: URL!) {
    setVibration()
    if url.absoluteString == "action://TC" {
      let webViewController: WebViewController = StoryBoard.Main.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
      webViewController.titleString = "Conditions Génerales"
      webViewController.flag = true
      webViewController.url = "https://policies.google.com/terms?hl=en"
      guard let getNav = UIApplication.topViewController()?.navigationController else {
        return
      }
      let rootNavView = UINavigationController(rootViewController: webViewController)
      getNav.present( rootNavView, animated: true, completion: nil)
    } else {
      let webViewController: WebViewController = StoryBoard.Main.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
      webViewController.titleString = "Politique de confidentialité"
      webViewController.url = "https://policies.google.com/privacy?hl=en"
      webViewController.flag = true
      guard let getNav = UIApplication.topViewController()?.navigationController else {
        return
      }
      let rootNavView = UINavigationController(rootViewController: webViewController)
      getNav.present( rootNavView, animated: true, completion: nil)
    }
  }
}
