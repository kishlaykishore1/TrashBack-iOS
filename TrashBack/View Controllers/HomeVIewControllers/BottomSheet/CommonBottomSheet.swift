//
//  CommonBottomSheet.swift
//  TrashBack
//
//  Created by angrz singh on 23/01/22.
//

import UIKit
import SPStorkController

class CommonBottomSheet: UIViewController {
    
    var nav = UINavigationController()
    var home: HomeVC?
    var vcKey:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func action_newPickup(_ sender: UIControl) {
        setVibration()
        self.dismiss(animated: true) {
            self.openNewPickupSheet(newPickup: true)
        }
    }
    
    @IBAction func action_reportAndBulkyItem(_ sender: UIControl) {
        setVibration()
        self.dismiss(animated: true) {
            let vc = StoryBoard.Home.instantiateViewController(withIdentifier: "TakePictureVC") as! TakePictureVC
            vc.newPickup = false
            vc.vcKey = self.vcKey
            if self.vcKey == "home" {
                self.home?.hidesBottomBarWhenPushed = true
                vc.home = self.home
                self.home?.navigationController?.pushViewController(vc, animated: true)
            } else {
                vc.nav = self.nav
                self.nav.pushViewController(vc, animated: true)
            }
        }
    }
    
    func openNewPickupSheet(newPickup: Bool) {
        // let currentViewController = UIApplication.shared.windows.first?.rootViewController
        let vc = StoryBoard.Home.instantiateViewController(withIdentifier: "NewPickupBottomSheet") as! NewPickupBottomSheet
        if vcKey == "home" {
            vc.home = self.home
            vc.vcKey = self.vcKey
        } else {
            vc.nav = self.nav
        }
        vc.newPickup = newPickup
        let transitionDelegate = SPStorkTransitioningDelegate()
        transitionDelegate.showIndicator = false
        transitionDelegate.customHeight = CGFloat(UIScreen.main.bounds.height - 200)
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: vc)
        rootNavView.transitioningDelegate = transitionDelegate
        rootNavView.modalPresentationStyle = .custom
        rootNavView.modalPresentationCapturesStatusBarAppearance = true
        getNav.present(rootNavView, animated: true, completion: nil)
    }
}
