//
//  NotificationPermissionVC.swift
//  Memreez
//


import UIKit
import UserNotifications

class NotificationPermissionVC: UIViewController {
    
    //MARK:- Outlets
  @IBOutlet weak var btnNotification: UIButton!
  @IBOutlet weak var lblSubHeading: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.lblSubHeading.text = "Tu sera informé de l’actualité\nde l’application et des nouveaux cadeaux\najoutés dans la boutique"
      
        DispatchQueue.main.async {
            self.btnNotification.layer.cornerRadius = self.btnNotification.frame.height / 2
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
        setBackButton(tintColor: #colorLiteral(red: 0.2235294118, green: 0.3176470588, blue: 0.3843137255, alpha: 1), isImage: true, #imageLiteral(resourceName: "downArrow"))
        setNavigationBarImage(for: UIImage(), color: .white, requireShadowLine: false)
        setRightButton(isImage: false)
    }
}

//MARK:- Action Method
extension NotificationPermissionVC {
  
    override func backBtnTapAction() {
      self.dismiss(animated: true, completion: nil)
    }
  
    override func rightBtnTapAction(sender: UIButton) {
        setVibration()
        let current = UNUserNotificationCenter.current()
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        current.requestAuthorization( options: authOptions, completionHandler: { granted, error in
            
            if error != nil {
                // Handle the error here.
            }
            
            DispatchQueue.main.async {
                self.dismiss(animated: true) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let addNewVC = storyboard.instantiateViewController(withIdentifier: "LocationPermissionVC") as! LocationPermissionVC
                guard let getNav =  UIApplication.topViewController()?.navigationController else {
                    return
                }
                let rootNavView = UINavigationController(rootViewController: addNewVC)
                if #available(iOS 13.0, *) {
                    addNewVC.isModalInPresentation = true
                } else {
                    // Fallback on earlier versions
                }
                getNav.present(rootNavView, animated: true, completion: nil)
            }
        }
        })
        Constants.kAppDelegate.kApplication?.registerForRemoteNotifications()
    }
    
    @IBAction func action_AllowNotification(_ sender: UIButton) {
        setVibration()
        let current = UNUserNotificationCenter.current()
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        current.requestAuthorization( options: authOptions, completionHandler: { granted, error in
            
            if error != nil {
                // Handle the error here.
            }
            
            DispatchQueue.main.async {
               self.dismiss(animated: true) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let addNewVC = storyboard.instantiateViewController(withIdentifier: "LocationPermissionVC") as! LocationPermissionVC
                guard let getNav =  UIApplication.topViewController()?.navigationController else {
                    return
                }
                let rootNavView = UINavigationController(rootViewController: addNewVC)
                if #available(iOS 13.0, *) {
                    addNewVC.isModalInPresentation = true
                } else {
                    // Fallback on earlier versions
                }
                getNav.present(rootNavView, animated: true, completion: nil)
            }
          }
        })
        Constants.kAppDelegate.kApplication?.registerForRemoteNotifications()
    }
   
}
