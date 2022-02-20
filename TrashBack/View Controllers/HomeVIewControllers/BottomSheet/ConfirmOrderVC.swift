//
//  ConfirmOrderVC.swift
//  TrashBack
//
//  Created by kishlay kishore on 29/01/22.
//

import UIKit

class ConfirmOrderVC: UIViewController {
// MARK: - Outlets
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var lblAvailablePoints: UILabel!
    @IBOutlet weak var lblPointsAfterPurchase: UILabel!
    @IBOutlet weak var lblUserFullName: UILabel!
    @IBOutlet weak var lblUserAddress: UILabel!
    @IBOutlet weak var btnConfirmOrder: UIButton!
    
    // MARK: - Variables
    
    var nav: GiftVC?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.btnConfirmOrder.layer.cornerRadius = self.btnConfirmOrder.frame.height / 2
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Button Action Methods
    
    @IBAction func btnModifyAddress_Action(_ sender: UIView) {
      setVibration()
        self.dismiss(animated: true) {
            let vc = StoryBoard.Settings.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
            vc.isFromTab = true
            vc.isModalInPresentation = true
            guard let getNav =  UIApplication.topViewController()?.navigationController else {
              return
            }
            let rootNavView = UINavigationController(rootViewController: vc)
            getNav.present(rootNavView, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnConfirmOrder_Action(_ sender: UIButton) {
      setVibration()
        setVibration()
        self.dismiss(animated: true) {
            let vc = StoryBoard.Home.instantiateViewController(withIdentifier: "RewardPointsVC") as! RewardPointsVC
            vc.reuseView = true
            guard let getNav =  UIApplication.topViewController()?.navigationController else {
              return
            }
            let rootNavView = UINavigationController(rootViewController: vc)
            rootNavView.modalPresentationStyle = .fullScreen
            getNav.present(rootNavView, animated: true, completion: nil)
        }
    }
}
