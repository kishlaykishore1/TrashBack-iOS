//
//  NotificationVC.swift
//  TrashBack
//
//  Created by kishlay kishore on 23/01/22.
//

import UIKit

class NotificationVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    // MARK: - Varialbles
    var titles = ["Cadeaux expédié 🎁","Tu es le premier du classement ce mois-ci 🏆","Cadeaux expédié 🎁"]
    var subTitles = ["Ton cadeau t’a bien été envoyé à ton adresse postale ! Merci pour ta commande.","Bravo ! Tu es arrivé premier ! Tu remportes un cadeau\nspécial. Clique ici pour le commander.","Ton cadeau t’a bien été envoyé à ton adresse postale ! Merci pour ta commande."]
    
    // MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.isHidden = true
        self.emptyView.isHidden = false
        self.tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        setBackButton(tintColor: #colorLiteral(red: 0.01176470588, green: 0, blue: 0.2784313725, alpha: 1), isImage: true, #imageLiteral(resourceName: "downArrow"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        setNavigationBarImage(for: UIImage(), color: .white, requireShadowLine: true)
        self.title = "Notifications".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DMSans-Medium", size: 13) ?? UIFont(), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2235294118, green: 0.3176470588, blue: 0.3843137255, alpha: 1) ]
    }
    
    // MARK: - Button Action Methods
    
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnEmptyView_Action(_ sender: UIControl) {
        self.tableView.isHidden = false
        self.emptyView.isHidden = true
    }
    
}

// MARK: - TableView DataSource Methods

extension NotificationVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableCell", for: indexPath) as! NotificationTableCell
        cell.lblTitle.text = titles[indexPath.row]
        cell.lblSubTitle.text = subTitles[indexPath.row]
        if indexPath.row == 2 {
            cell.newNotiView.isHidden = true
            cell.backView.backgroundColor = .clear
        }
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
// MARK: - TableView Delegate Methods
extension NotificationVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setVibration()
    }
}

// MARK: - Table View Cell class
class NotificationTableCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var newNotiView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
}
