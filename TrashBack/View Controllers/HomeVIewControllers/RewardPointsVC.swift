//
//  RewardPointsVC.swift
//  TrashBack
//
//  Created by angrz singh on 25/01/22.
//

import UIKit
import CryptoKit

class RewardPointsVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var secondImg: UIImageView!
    @IBOutlet weak var lblPoint: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnPerformance: UIButton!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblMsgHeader: UILabel!
    
    // MARK: - Variables
    var nav = UINavigationController()
    var newPickup: Bool?
    var reuseView = false
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if newPickup ?? false {
            secondImg.isHidden = true
            imgView.isHidden = false
            lblPoint.text = "+50 pts"
            lblMsgHeader.text = "Bravo et merci !"
            imgView.image = #imageLiteral(resourceName: "fullRock")
            lblMessage.text = "Continue tes ramassages pour accumuler plus de points."
        } else if reuseView {
            secondImg.isHidden = true
            imgView.isHidden = false
            lblPoint.text = ""
            lblMsgHeader.text = "Super !"
            imgView.image = #imageLiteral(resourceName: "ic_Box")
            lblMessage.text = "Ta commande a bien été enregistrée.\nTu devrais la recevoir sous 10 à 20 jours."
        } else {
            secondImg.isHidden = false
            imgView.isHidden = true
            lblPoint.text = "+10 pts"
            lblMsgHeader.text = "Bravo et merci !"
            secondImg.image = #imageLiteral(resourceName: "truck")
            lblMessage.text = "Nous contacterons les services municipaux pour leur faire part de ton signalement."
        }
        
        DispatchQueue.main.async {
            self.btnPerformance.cornerRadius = self.btnPerformance.frame.height/2
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Button Action Methods
    
    @IBAction func action_backToHome(_ sender: UIButton) {
        setVibration()
        (UIApplication.shared.delegate as? AppDelegate)?.isUserLogin(true)
    }
    
    @IBAction func btnPerformance_Action(_ sender: UIButton) {
        setVibration()
        let activityItem = CustomActivityItemProvider(placeholderItem: "", titleOfBlog: "")
        let activityViewController = UIActivityViewController(activityItems: [activityItem], applicationActivities: nil)
        activityViewController.setValue(Messages.txtAppShareSubject, forKey: "Subject")
        present(activityViewController, animated: true, completion: nil)
    }
    
}
