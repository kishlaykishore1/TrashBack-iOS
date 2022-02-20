//
//  HelpMentionVC.swift
//  TrashBack
//
//  Created by kishlay kishore on 23/01/22.
//

import UIKit
import MessageUI

class HelpMentionVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var headerview: UIView!
    
    // MARK: - Varialbles
    var titles = ["Nous contacter","Consulter la FAQ","Signaler un bug","Conditions Générale de Ventes","Politique de confidentialité","Logiciel tiers"]
    
    // MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: -12, right: 0)
        setBackButton(tintColor: #colorLiteral(red: 0.01176470588, green: 0, blue: 0.2784313725, alpha: 1), isImage: true, #imageLiteral(resourceName: "ic_BackButton"))
        
        //Mark: FooterView Configuration
        self.tableView.tableFooterView = headerview
        self.tableView.tableFooterView?.frame = headerview.frame
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        setNavigationBarImage(for: UIImage(), color: .white, requireShadowLine: true)
        self.title = "Aide et mentions".localized
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DMSans-Medium", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .medium), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2235294118, green: 0.3176470588, blue: 0.3843137255, alpha: 1) ]
    }
    
    // MARK: - Button Action Methods
    
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - TableView DataSource Methods

extension HelpMentionVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HelpMentionTableCell", for: indexPath) as! HelpMentionTableCell
        cell.lblTitle.text = titles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
}
// MARK: - TableView Delegate Methods
extension HelpMentionVC: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setVibration()
        switch (indexPath.row) {
        case 0:
            sendMail(email: "contact@trashback.com")
            break
        case 1:
            let settingVC = StoryBoard.Settings.instantiateViewController(withIdentifier: "FaqVC") as! FaqVC
            self.navigationController?.pushViewController(settingVC, animated: true)
            break
        case 2:
            showReportMessagePopup()
            break
        case 3:
            let webViewController: WebViewController = StoryBoard.Main.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            webViewController.titleString = "Conditions Générale de Ventes"
            webViewController.flag = true
            webViewController.url = "https://policies.google.com/terms?hl=en"
            guard let getNav = UIApplication.topViewController()?.navigationController else {
                return
            }
            let rootNavView = UINavigationController(rootViewController: webViewController)
            getNav.present( rootNavView, animated: true, completion: nil)
            break
        case 4:
            let webViewController: WebViewController = StoryBoard.Main.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            webViewController.titleString = "Politique de confidentialité"
            webViewController.url = "https://policies.google.com/privacy?hl=en"
            webViewController.flag = true
            guard let getNav = UIApplication.topViewController()?.navigationController else {
                return
            }
            let rootNavView = UINavigationController(rootViewController: webViewController)
            getNav.present( rootNavView, animated: true, completion: nil)
            break
        case 5:
            let webViewController: WebViewController = StoryBoard.Main.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            webViewController.titleString = "Logiciel tiers"
            webViewController.url = "https://www.google.co.in"
            webViewController.flag = true
            guard let getNav = UIApplication.topViewController()?.navigationController else {
                return
            }
            let rootNavView = UINavigationController(rootViewController: webViewController)
            getNav.present( rootNavView, animated: true, completion: nil)
            break
        default:
            break
        }
    }
}

// MARK: - Report Popup
extension HelpMentionVC: MFMailComposeViewControllerDelegate {
    func showReportMessagePopup() {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: Messages.txtSettingReportBug, message: Messages.bugReportTitle, preferredStyle: .alert)
            let saveAction = UIAlertAction(title: Messages.txtSettingSend, style: .destructive, handler: { alert -> Void in
                let firstTextField = alertController.textFields![0] as UITextField
                if firstTextField.text?.trim().count == 0 {
                    Common.showAlertMessage(message: Messages.txtSettingBugDetail, alertType: .error)
                    return
                }
            })
            let cancelAction = UIAlertAction(title: Messages.txtDeleteCancel, style: .default, handler: { (action : UIAlertAction!) -> Void in
                
            })
            
            alertController.addTextField { (textField : UITextField!) -> Void in
                saveAction.isEnabled = false
                textField.placeholder = Messages.txtSettingReportTextField
                textField.autocapitalizationType = .sentences
                textField.isEnabled = false
                NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: OperationQueue.main, using:
                                                        {_ in
                    let textCount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
                    let textIsNotEmpty = textCount > 0
                    saveAction.isEnabled = textIsNotEmpty
                    
                })
            }
            
            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
            self.present(alertController, animated: true, completion: {
                let firstTextField = alertController.textFields![0] as UITextField
                firstTextField.isEnabled = true
                firstTextField.becomeFirstResponder()
                
            })
        }
    }
    
    // MARK: - Send Mail
    
    func sendMail(email: String) {
        if !MFMailComposeViewController.canSendMail() {
            Common.showAlertMessage(message: Messages.mailNotFound, alertType: .warning)
            return
        }
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setToRecipients([email])
        composeVC.setSubject("Demande de contact".localized)
        composeVC.setMessageBody("", isHTML: false)
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

// MARK: - Table View Cell class
class HelpMentionTableCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
}
