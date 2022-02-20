//
//  MyOrdersVC.swift
//  TrashBack
//
//  Created by kishlay kishore on 26/01/22.
//

import UIKit

class MyOrdersVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    // MARK: - Varialbles
    var titles = ["Expédiée","Validé","Préparation"]
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isHidden = true
        self.emptyView.isHidden = false
        self.tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        setBackButton(tintColor: #colorLiteral(red: 0.01176470588, green: 0, blue: 0.2784313725, alpha: 1), isImage: true, #imageLiteral(resourceName: "ic_BackButton"))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        setNavigationBarImage(for: UIImage(), color: .white, requireShadowLine: true)
        self.title = "Mes commandes".localized
    }

    // MARK: - Button Action Methods
    
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnEmptyView_Action(_ sender: UIControl) {
        self.tableView.isHidden = false
        self.emptyView.isHidden = true
    }
}

// MARK: - TableView DataSource Methods

extension MyOrdersVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyOrdersTableCell", for: indexPath) as! MyOrdersTableCell
        cell.lblStatus.text = titles[indexPath.row]
        if indexPath.row == 0 {
            cell.lblStatus.textColor = #colorLiteral(red: 0, green: 0.5762538314, blue: 1, alpha: 1)
            cell.statusView.backgroundColor = #colorLiteral(red: 0, green: 0.5762538314, blue: 1, alpha: 1)
            cell.shadowView.backgroundColor = #colorLiteral(red: 0, green: 0.5762538314, blue: 1, alpha: 0.14)
        } else if indexPath.row == 1 {
            cell.lblStatus.textColor = #colorLiteral(red: 0.5558025241, green: 0.8436165452, blue: 0.1671406627, alpha: 1)
            cell.statusView.backgroundColor = #colorLiteral(red: 0.5558025241, green: 0.8436165452, blue: 0.1671406627, alpha: 1)
            cell.shadowView.backgroundColor = #colorLiteral(red: 0.5558025241, green: 0.8436165452, blue: 0.1671406627, alpha: 0.25)
           
        } else {
            cell.lblStatus.textColor = #colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 1)
            cell.statusView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 1)
            cell.shadowView.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.2392156863, alpha: 0.25)
           
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
// MARK: - TableView Delegate Methods
extension MyOrdersVC: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setVibration()
        switch (indexPath.row) {
        case 0:
            let settingVC = StoryBoard.Settings.instantiateViewController(withIdentifier: "OrderDetailsVC") as! OrderDetailsVC
            settingVC.receivedStatus = "Expédiée"
            self.navigationController?.pushViewController(settingVC, animated: true)
            break
        case 1:
            let settingVC = StoryBoard.Settings.instantiateViewController(withIdentifier: "OrderDetailsVC") as! OrderDetailsVC
            settingVC.receivedStatus = "Validé"
            self.navigationController?.pushViewController(settingVC, animated: true)
            break
        case 2:
            let settingVC = StoryBoard.Settings.instantiateViewController(withIdentifier: "OrderDetailsVC") as! OrderDetailsVC
            settingVC.receivedStatus = "Préparation"
            self.navigationController?.pushViewController(settingVC, animated: true)
            break
        default:
            break
        }
    }
}

// MARK: - Table View Cell class

class MyOrdersTableCell: UITableViewCell {
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var shadowView: UIView!
}
