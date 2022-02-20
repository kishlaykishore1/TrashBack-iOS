//
//  SponsorshipProgramVC.swift
//  TrashBack
//
//  Created by kishlay kishore on 27/01/22.
//

import UIKit

class SponsorshipProgramVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var lblTopHeading: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    
    // MARK: - Varialbles
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton(tintColor: #colorLiteral(red: 0.01176470588, green: 0, blue: 0.2784313725, alpha: 1), isImage: true, #imageLiteral(resourceName: "ic_BackButton"))
        self.lblTopHeading.text = "Envie de recommander\nTrashBack ?"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        setNavigationBarImage(for: UIImage(), color: .white, requireShadowLine: true)
        self.title = "Programme de parrainage".localized
    }
    
    // MARK: - Button Action Methods
    
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnShareCode_Action(_ sender: UIButton) {
        setVibration()
        let activityItem = CustomActivityItemProvider(placeholderItem: "", titleOfBlog: "")
        let activityViewController = UIActivityViewController(activityItems: [activityItem], applicationActivities: nil)
        activityViewController.setValue(Messages.txtAppShareSubject, forKey: "Subject")
        present(activityViewController, animated: true, completion: nil)
    }
}
