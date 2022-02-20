//
//  SettingsVC.swift
//  TrashBack
//
//  Created by kishlay kishore on 23/01/22.
//

import UIKit
import SafariServices
import StoreKit

class SettingsVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var headerview: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDob: UILabel!
    
    @IBOutlet var footerView: UIView!
    
    // MARK: - Varialbles
    private var gradientLayer = CAGradientLayer()
    let titleArr = ["Mon profil", "Mes commandes", "Découvrir la vie des déchets", "Programme de parrainage","Noter l'application","Nos partenaires","Revoir le tutoriel","Aide et mentions"]
    let iconArr = [#imageLiteral(resourceName: "ic_User"), #imageLiteral(resourceName: "Ic_ShoppingBag"), #imageLiteral(resourceName: "ic_FishBone"), #imageLiteral(resourceName: "ic_Share"), #imageLiteral(resourceName: "ic_Star"), #imageLiteral(resourceName: "ic_Flags"), #imageLiteral(resourceName: "ic_TwoCiecle"), #imageLiteral(resourceName: "ic_info")]
    
    // MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton(tintColor: #colorLiteral(red: 0.01176470588, green: 0, blue: 0.2784313725, alpha: 1), isImage: true, #imageLiteral(resourceName: "ic_BackButton"))
        //Mark: FooterView Configuration
        self.tableView.tableFooterView = footerView
        self.tableView.tableFooterView?.frame = footerView.frame
        
        //Mark: HeaderView Configuration
        self.tableView.tableHeaderView = headerview
        self.tableView.tableHeaderView?.frame = headerview.frame
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground()
        self.navigationController?.navigationBar.isHidden = false
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowImage = UIImage()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DMSans-Medium", size: 13) ?? UIFont.systemFont(ofSize: 13, weight: .medium), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2235294118, green: 0.3176470588, blue: 0.3843137255, alpha: 1) ]
        self.title = "Mon compte".localized
        self.navigationController?.navigationBar.standardAppearance = appearance
        
    }
    
    // MARK: - Gradient View
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if gradientLayer.superlayer != nil {
            gradientLayer.removeFromSuperlayer()
        }
        
        let topColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1)
        let bottomColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.frame = tableView.bounds
        let backgroundView = UIView(frame: tableView.bounds)
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        tableView.backgroundView = backgroundView
    }
    // MARK: - Helper Methods
    
    func logoutFromDevice() {
        Global.clearAllAppUserDefaults()
        self.dismiss(animated: true) {
            (UIApplication.shared.delegate as? AppDelegate)?.isUserLogin(false)
        }
    }
    
    func setGradientBackground() {
        let colorTop =  #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1).cgColor
        let colorBottom = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func showSocialMedia(_ link: String) {
        if let url = URL(string: link) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
    // MARK: - Button Actions
    
    override func backBtnTapAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSocial_Action(_ sender: UIButton) {
        setVibration()
        switch (sender.tag) {
        case 101:
            showSocialMedia("https://www.facebook.com")
            //FB
            break
        case 102:
            showSocialMedia("https://www.instagram.com")
            //Insta
            break
        case 103:
            showSocialMedia("https://twitter.com")
            //Twitter
            break
        default:
            showSocialMedia("https://www.linkedin.com")
            //Linkdin
            break
        }
    }
    
    @IBAction func btnLogout_Action(_ sender: UIButton) {
        setVibration()
        DispatchQueue.main.async {
            let alert  = UIAlertController(title: Messages.txtDeleteAlert, message: Messages.logoutMsg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Messages.txtDeleteConfirm, style: .destructive, handler: { _ in
                self.logoutFromDevice()
            }))
            alert.addAction(UIAlertAction(title: Messages.txtDeleteCancel, style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnDelete_Action(_ sender: UIButton) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Attention !".localized, message: "Voulez-vous vraiment supprimer votre compte ? Attention, cette action est irréversible !".localized, preferredStyle: .alert)
            let logoutAction = UIAlertAction(title: "Supprimer mon compte".localized, style: .destructive, handler: { alert -> Void in
                
            })
            let cancelAction = UIAlertAction(title: "Annuler".localized, style: .cancel, handler: { (action : UIAlertAction!) -> Void in
            })
            alertController.addAction(logoutAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}

// MARK: - TableView Datasourec Methods
extension SettingsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableCell", for: indexPath) as! SettingsTableCell
        cell.imgOptions.image = iconArr[indexPath.row]
        cell.lblOptionName.text = titleArr[indexPath.row]
        return cell
    }
    
}

// MARK: - TableView delegates Methods
extension SettingsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setVibration()
        switch (indexPath.row) {
        case 0:
            let settingVC = StoryBoard.Settings.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
            self.navigationController?.pushViewController(settingVC, animated: true)
            break
        case 1:
            let settingVC = StoryBoard.Settings.instantiateViewController(withIdentifier: "MyOrdersVC") as! MyOrdersVC
            self.navigationController?.pushViewController(settingVC, animated: true)
            break
        case 2:
            let webViewController: WebViewController = StoryBoard.Main.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            webViewController.titleString = "Découvrir la vie des déchets"
            webViewController.url = "https://www.google.co.in"
            webViewController.flag = true
            guard let getNav = UIApplication.topViewController()?.navigationController else {
                return
            }
            let rootNavView = UINavigationController(rootViewController: webViewController)
            getNav.present( rootNavView, animated: true, completion: nil)
            break
        case 3:
            let settingVC = StoryBoard.Settings.instantiateViewController(withIdentifier: "SponsorshipProgramVC") as! SponsorshipProgramVC
            self.navigationController?.pushViewController(settingVC, animated: true)
            break
        case 4:
            SKStoreReviewController.requestReview()
            break
        case 5:
            let settingVC = StoryBoard.Settings.instantiateViewController(withIdentifier: "OurPartnersVC") as! OurPartnersVC
            self.navigationController?.pushViewController(settingVC, animated: true)
            break
        case 6:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let addNewVC = storyboard.instantiateViewController(withIdentifier: "IntroVC") as! IntroVC
            addNewVC.isFromSettings = true
            //addNewVC.modalPresentationStyle = .fullScreen
            guard let getNav =  UIApplication.topViewController()?.navigationController else {
                return
            }
            let rootNavView = UINavigationController(rootViewController: addNewVC)
            rootNavView.modalPresentationStyle = .fullScreen
            getNav.present(rootNavView, animated: true, completion: nil)
            break
        case 7:
            let settingVC = StoryBoard.Settings.instantiateViewController(withIdentifier: "HelpMentionVC") as! HelpMentionVC
            self.navigationController?.pushViewController(settingVC, animated: true)
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
//MARK: - Table View Cell Class
class SettingsTableCell: UITableViewCell {
    @IBOutlet weak var imgOptions: UIImageView!
    @IBOutlet weak var lblOptionName: UILabel!
    
}
