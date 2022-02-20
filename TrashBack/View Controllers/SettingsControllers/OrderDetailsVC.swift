//
//  OrderDetailsVC.swift
//  TrashBack
//
//  Created by kishlay kishore on 26/01/22.
//

import UIKit

class OrderDetailsVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var lblTopStatus: UILabel!
    @IBOutlet weak var topShadowView: UIView!
    @IBOutlet weak var statusView: UIView!
    
    // MARK: - Varialbles
    var receivedStatus = ""
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton(tintColor: #colorLiteral(red: 0.01176470588, green: 0, blue: 0.2784313725, alpha: 1), isImage: true, #imageLiteral(resourceName: "ic_BackButton"))
        if receivedStatus == "Expédiée" {
            lblTopStatus.text = receivedStatus
            lblTopStatus.textColor = #colorLiteral(red: 0, green: 0.5762538314, blue: 1, alpha: 1)
            statusView.backgroundColor = #colorLiteral(red: 0, green: 0.5762538314, blue: 1, alpha: 1)
            topShadowView.backgroundColor = #colorLiteral(red: 0, green: 0.5762538314, blue: 1, alpha: 0.14)
        } else if receivedStatus == "Validé" {
            lblTopStatus.text = receivedStatus
            lblTopStatus.textColor = #colorLiteral(red: 0.5558025241, green: 0.8436165452, blue: 0.1671406627, alpha: 1)
            statusView.backgroundColor = #colorLiteral(red: 0.5558025241, green: 0.8436165452, blue: 0.1671406627, alpha: 1)
            topShadowView.backgroundColor = #colorLiteral(red: 0.5558025241, green: 0.8436165452, blue: 0.1671406627, alpha: 0.25)
        } else {
            lblTopStatus.text = receivedStatus
            lblTopStatus.textColor = #colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 1)
            statusView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 1)
            topShadowView.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.2392156863, alpha: 0.25)
           
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        setNavigationBarImage(for: UIImage(), color: .white, requireShadowLine: true)
        self.title = "Commande #TBC20349".localized
    }
    
    // MARK: - Button Action Methods
    
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
