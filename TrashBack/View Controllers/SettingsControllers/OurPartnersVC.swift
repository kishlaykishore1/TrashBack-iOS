//
//  OurPartnersVC.swift
//  TrashBack
//
//  Created by kishlay kishore on 26/01/22.
//

import UIKit

class OurPartnersVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Varialbles
    var isFromHome = false
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        setBackButton(tintColor: #colorLiteral(red: 0.01176470588, green: 0, blue: 0.2784313725, alpha: 1), isImage: true, #imageLiteral(resourceName: "ic_BackButton"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        setNavigationBarImage(for: UIImage(), color: .white, requireShadowLine: true)
        self.title = "Nos partenaires".localized
    }

    // MARK: - Button Action Methods
    
    override func backBtnTapAction() {
        setVibration()
        if isFromHome {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: - TableView DataSource Methods

extension OurPartnersVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PartnersTableCell", for: indexPath) as! PartnersTableCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
// MARK: - TableView Delegate Methods
extension OurPartnersVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setVibration()
        
    }
}

// MARK: - Table View Cell class

class PartnersTableCell: UITableViewCell {
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblPartnerName: UILabel!
    @IBOutlet weak var lblPartnerType: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
}
