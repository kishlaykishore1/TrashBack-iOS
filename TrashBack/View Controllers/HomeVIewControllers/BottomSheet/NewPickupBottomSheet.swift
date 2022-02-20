//
//  NewPickupBottomSheet.swift
//  TrashBack
//
//  Created by angrz singh on 23/01/22.
//

import UIKit

class NewPickupBottomSheet: UIViewController {
    
    @IBOutlet weak var btnConfirm: UIButton!
    
    var nav = UINavigationController()
    var newPickup: Bool?
    var home: HomeVC?
    var vcKey:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        DispatchQueue.main.async {
            self.btnConfirm.cornerRadius = self.btnConfirm.frame.height/2
        }
    }
    
    @IBAction func action_confirmPickup(_ sender: UIButton) {
        setVibration()
        self.dismiss(animated: true) {
            let vc = StoryBoard.Home.instantiateViewController(withIdentifier: "TakePictureVC") as! TakePictureVC
            vc.nav = self.nav
            vc.home = self.home
            vc.newPickup = self.newPickup
            vc.vcKey = self.vcKey
            if self.vcKey == "home" {
                self.home?.hidesBottomBarWhenPushed = true
                self.home?.navigationController?.pushViewController(vc, animated: true)
            } else {
                self.nav.pushViewController(vc, animated: true)
            }
        }
    }
}
