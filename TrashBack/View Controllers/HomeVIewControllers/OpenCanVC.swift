//
//  OpenCanVC.swift
//  TrashBack
//
//  Created by angrz singh on 21/01/22.
//

import UIKit

class OpenCanVC: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var noDataImage: UIImageView!
    @IBOutlet weak var noDataText: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataView: UIControl!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var profileView: UIControl!
    @IBOutlet weak var notificationCountView: UIView!
    @IBOutlet weak var notificationCountView1: UIView!
    @IBOutlet var headerview: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var profileHeight: NSLayoutConstraint!
    @IBOutlet weak var titleTapView: UIControl!
    @IBOutlet weak var btnTitle: UIButton!
    
    // MARK: - Properties
    var isStatusModel = [StatusModel]()
    var isPickup = true
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //Mark: HeaderView Configuration
        self.tableView.tableHeaderView = headerview
        self.tableView.tableHeaderView?.frame = headerview.frame
        self.tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        self.isStatusModel = [StatusModel(statusName: ValidStatus.finalize.rawValue), StatusModel(statusName: ValidStatus.valid.rawValue), StatusModel(statusName: ValidStatus.Refuse.rawValue), StatusModel(statusName: ValidStatus.Waiting.rawValue)]
        
        DispatchQueue.main.async {
            self.notificationCountView1.cornerRadius = self.notificationCountView1.frame.height/2
            self.notificationCountView.cornerRadius = self.notificationCountView.frame.height/2
        }
        
        if #available(iOS 14.0, *) {
            btnTitle.menu = createContextMenu()
            btnTitle.showsMenuAsPrimaryAction = true
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        //setupUI()
    }
    
    // MARK: - Helper Methods
    private func setupUI() {
        // Initial setup for image for Large NavBar state since the the screen always has Large NavBar once it gets opened
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear
        appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DMSans-Medium", size: 13) ?? UIFont.systemFont(ofSize: 13, weight: .medium), NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2235294118, green: 0.3176470588, blue: 0.3843137255, alpha: 1) ]
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(notificationView)
        navigationBar.addSubview(profileView)
        
        NSLayoutConstraint.activate([
            notificationView.rightAnchor.constraint(equalTo: profileView.leftAnchor, constant: -Const.ViewNoitfyRightMargin),
            notificationView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ViewNoitfyBottomMarginForSmallState),
            notificationView.heightAnchor.constraint(equalToConstant: Const.ViewNoitfyForLargeState),
            notificationView.widthAnchor.constraint(equalTo: notificationView.heightAnchor),
            
            profileView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Const.ViewProfileRightMargin),
            profileView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ViewProfileBottomMarginForSmallState),
            profileView.heightAnchor.constraint(equalToConstant: Const.ViewProfileForLargeState),
            profileView.widthAnchor.constraint(equalTo: profileView.heightAnchor)
        ])
    }
    
    
    // MARK: - Button Action Method
    
    @IBAction func action_openFilter(_ sender: UIControl) {
        setVibration()
        openOptions()
    }
    
    @IBAction func action_openMap(_ sender: UIControl) {
        setVibration()
        let aboutVC = StoryBoard.Home.instantiateViewController(withIdentifier: "MapVC") as! MapVC
        aboutVC.isModalInPresentation = true
        if isPickup {
            aboutVC.strTitle = "Carte des ramassages"
        } else {
            aboutVC.strTitle = "Carte des signalements"
        }
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: aboutVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
    
    
    @IBAction func action_openProfile(_ sender: UIControl) {
        setVibration()
        let aboutVC = StoryBoard.Settings.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        aboutVC.isModalInPresentation = true
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: aboutVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
    
    @IBAction func action_openNotification(_ sender: UIControl) {
        setVibration()
        let aboutVC = StoryBoard.Settings.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        aboutVC.isModalInPresentation = true
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: aboutVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
}

// MARK: - Action Method
extension OpenCanVC {
    
    
    
    @IBAction func action_emptyView(_ sender: UIControl) {
        setVibration()
        self.noDataView.isHidden = true
        self.tableView.isHidden = false
        self.bottomView.isHidden = false
    }
    
    func openOptions() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Filter 1", style: .default, handler: { _ in
            setVibration()
        }))
        
        alert.addAction(UIAlertAction(title: "Filter 2", style: .default, handler: { _ in
            setVibration()
        }))
        
        alert.addAction(UIAlertAction(title: "Filter 3", style: .default, handler: { _ in
            setVibration()
        }))
        
        alert.addAction(UIAlertAction(title: "Filter 4", style: .default, handler: { _ in
            setVibration()
        }))
        
        alert.addAction(UIAlertAction.init(title: Messages.txtCancel, style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func handelTypes(isPickup: Bool) {
        setVibration()
        if isPickup {
            self.isPickup = isPickup
            // self.lblType.text = "Ramassages"
            self.btnTitle.setTitle("Ramassages", for: .normal)
            self.noDataView.isHidden = false
            self.tableView.isHidden = true
            self.bottomView.isHidden = true
            self.noDataImage.image = #imageLiteral(resourceName: "canPickupEmty")
            self.noDataText.text = "Aucun ramassage effectué pour le moment.\nSors de chez toi et trouve tes premiers déchets\npour gagner des cadeaux !"
        } else {
            self.isPickup = isPickup
            //self.lblType.text = "Signalements"
            self.btnTitle.setTitle("Signalements", for: .normal)
            self.noDataView.isHidden = false
            self.tableView.isHidden = true
            self.bottomView.isHidden = true
            self.noDataImage.image = #imageLiteral(resourceName: "canReportEmty")
            self.noDataText.text = "Aucun signalement effectué pour le moment.\nSors de chez toi et signale tes premiers encombrants\npour gagner des cadeaux !"
        }
        self.tableView.reloadData()
    }
    
    private func scrollToTop() {
        let topRow = IndexPath(row: 0,
                               section: 0)
        self.tableView.scrollToRow(at: topRow,
                                   at: .top,
                                   animated: true)
    }
    
    func navigate(str:String) {
        let aboutVC = StoryBoard.Home.instantiateViewController(withIdentifier: "FinalizePickupVC") as! FinalizePickupVC
        aboutVC.receivedString = str
        aboutVC.isModalInPresentation = true
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: aboutVC)
        getNav.present(rootNavView, animated: true, completion: nil)
    }
    
    
    func createContextMenu() -> UIMenu {
        
        let renameAction = UIAction(title: "Ramassages", image: nil) { _ in
            setVibration()
            self.handelTypes(isPickup: true)
        }
        let moveAction = UIAction(title: "Signalements", image: nil) { _ in
            setVibration()
            self.handelTypes(isPickup: false)
        }
        return UIMenu(title: "", options: .displayInline, children: [renameAction, moveAction])
    }
    
}


// MARK: - TableView DataSource
extension OpenCanVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isStatusModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OpenCanTableCell") as! OpenCanTableCell
        
        if isPickup {
            cell.lblName.text = "Masque"
            cell.imgView.image = #imageLiteral(resourceName: "mask2")
            if isStatusModel[indexPath.row].statusName == ValidStatus.finalize.rawValue {
                cell.lblStatus.text = isStatusModel[indexPath.row].statusName
                cell.lblStatus.textColor = #colorLiteral(red: 0, green: 0.4862745098, blue: 1, alpha: 1)
                cell.lblPoints.isHidden = true
                cell.indicatorView.backgroundColor = #colorLiteral(red: 0, green: 0.4862745098, blue: 1, alpha: 1)
                cell.bckView.backgroundColor = #colorLiteral(red: 0, green: 0.4862745098, blue: 1, alpha: 0.25)
                
            } else if isStatusModel[indexPath.row].statusName == ValidStatus.valid.rawValue {
                cell.lblStatus.text = isStatusModel[indexPath.row].statusName
                cell.lblStatus.textColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
                cell.lblPoints.isHidden = false
                cell.indicatorView.backgroundColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
                cell.bckView.backgroundColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 0.25)
                
            } else if isStatusModel[indexPath.row].statusName == ValidStatus.Refuse.rawValue {
                cell.lblStatus.text = isStatusModel[indexPath.row].statusName
                cell.lblStatus.textColor = #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1)
                cell.lblPoints.isHidden = true
                cell.indicatorView.backgroundColor = #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1)
                cell.bckView.backgroundColor = #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 0.25)
                
            } else {
                cell.lblStatus.text = isStatusModel[indexPath.row].statusName
                cell.lblStatus.textColor = #colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 1)
                cell.lblPoints.isHidden = true
                cell.indicatorView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 1)
                cell.bckView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 0.25)
            }
        } else {
            cell.lblName.text = "Décharge"
            cell.imgView.image = #imageLiteral(resourceName: "dump")
            if isStatusModel[indexPath.row].statusName == ValidStatus.Waiting.rawValue {
                cell.lblStatus.text = isStatusModel.last?.statusName
                cell.lblStatus.textColor = #colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 1)
                cell.lblPoints.isHidden = true
                cell.indicatorView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 1)
                cell.bckView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 0.25)
                
            } else if isStatusModel[indexPath.row].statusName == ValidStatus.valid.rawValue {
                cell.lblStatus.text = isStatusModel[indexPath.row].statusName
                cell.lblStatus.textColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
                cell.lblPoints.isHidden = false
                cell.indicatorView.backgroundColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1)
                cell.bckView.backgroundColor = #colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 0.25)
                
            } else if isStatusModel[indexPath.row].statusName == ValidStatus.Refuse.rawValue {
                cell.lblStatus.text = isStatusModel[indexPath.row].statusName
                cell.lblStatus.textColor = #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1)
                cell.lblPoints.isHidden = true
                cell.indicatorView.backgroundColor = #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1)
                cell.bckView.backgroundColor = #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 0.25)
                
            } else if isStatusModel[indexPath.row].statusName == ValidStatus.Waiting.rawValue  {
                cell.lblStatus.text = isStatusModel[indexPath.row].statusName
                cell.lblStatus.textColor = #colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 1)
                cell.lblPoints.isHidden = true
                cell.indicatorView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 1)
                cell.bckView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 0.25)
            }
        }
        return cell
    }
}

// MARK: - Table view Delegates Methods
extension OpenCanVC: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        if scrollView.contentOffset.y > -12 {
            UIView.animate(withDuration: 0.2) {
                self.navigationController?.navigationBar.isHidden = false
                self.title = self.btnTitle.currentTitle
                self.setupUI()
                self.topView.isHidden = true
            }
        } else if scrollView.contentOffset.y <= 0 {
            UIView.animate(withDuration: 0.2) {
                self.navigationController?.navigationBar.isHidden = true
                self.topView.isHidden = false
                
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setVibration()
        
        if isStatusModel[indexPath.row].statusName == ValidStatus.finalize.rawValue {
            navigate(str: ValidStatus.finalize.rawValue)
            
        } else if isStatusModel[indexPath.row].statusName == ValidStatus.valid.rawValue {
            navigate(str: ValidStatus.valid.rawValue)
            
        } else if isStatusModel[indexPath.row].statusName == ValidStatus.Refuse.rawValue {
            //
            
        } else {
            //
        }
        
    }
}

// MARK: - Model
struct StatusModel {
    var statusName: String
}

enum ValidStatus: String {
    case finalize = "À finaliser"
    case valid = "Validé"
    case Refuse = "Refusé"
    case Waiting = "En attente"
}
