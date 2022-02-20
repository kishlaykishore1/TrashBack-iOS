//
//  HistoryVC.swift
//  TrashBack
//
//  Created by kishlay kishore on 08/02/22.
//

import UIKit

class HistoryVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Varialbles
    var titles = ["Décharge","Décharge","Masque","Masque"]
    var userName = ""
    
    // MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        setBackButton(tintColor: #colorLiteral(red: 0.01176470588, green: 0, blue: 0.2784313725, alpha: 1), isImage: true, #imageLiteral(resourceName: "downArrow"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        setNavigationBarImage(for: UIImage(), color: .white, requireShadowLine: true)
        self.title = "Historique de \(userName)".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DMSans-Medium", size: 13) ?? UIFont(), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2235294118, green: 0.3176470588, blue: 0.3843137255, alpha: 1) ]
    }
    
    // MARK: - Button Action Methods
    
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - TableView DataSource
extension HistoryVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OpenCanTableCell") as! OpenCanTableCell
        
            cell.lblName.text = titles[indexPath.row]
            cell.imgView.image = #imageLiteral(resourceName: "mask2")
            cell.lblStatus.text = "Validé"
            cell.lblStatus.textColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
            cell.lblPoints.isHidden = false
            cell.indicatorView.backgroundColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
            cell.bckView.backgroundColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 0.25)
        return cell
    }
}

// MARK: - Table view Delegates Methods
extension HistoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setVibration()
        let aboutVC = StoryBoard.Home.instantiateViewController(withIdentifier: "FinalizePickupVC") as! FinalizePickupVC
        aboutVC.receivedString = "Validé"
        aboutVC.isFromHistory = true
        self.navigationController?.pushViewController(aboutVC, animated: true)
    }
}
