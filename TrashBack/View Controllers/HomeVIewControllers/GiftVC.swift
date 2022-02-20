//
//  GiftVC.swift
//  TrashBack
//
//  Created by angrz singh on 21/01/22.
//

import UIKit
import SPStorkController

class GiftVC: UIViewController,UIScrollViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var notificationCountView: UIView!
    @IBOutlet weak var headerCollectionView: UICollectionView!
    @IBOutlet var topHeaderview: UIView!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var profileView: UIControl!
    
    // MARK: - Varialbles
    let arrText = ["À la une", "High-Tech", "Maison", "Art de la table", "High-Tech", "Maison", "Art de la table"]
    var index = 0
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0)
        //Mark: HeaderView Configuration
        self.tableView.tableHeaderView = topHeaderview
        self.tableView.tableHeaderView?.frame = topHeaderview.frame
        DispatchQueue.main.async {
            self.notificationCountView.cornerRadius = self.notificationCountView.frame.height/2
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.navigationBar.sizeToFit()
        }
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DMSans-Medium", size: 13)!, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2235294118, green: 0.3176470588, blue: 0.3843137255, alpha: 1) ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "DMSans-Bold", size: 35)!, NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2235294118, green: 0.3176470588, blue: 0.3843137255, alpha: 1)]
        self.navigationItem.title = "Cadeaux"
        setupUI()
    }
    
    // MARK: - Helper Methods
    private func setupUI() {
        // Initial setup for image for Large NavBar state since the the screen always has Large NavBar once it gets opened
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(notificationView)
        navigationBar.addSubview(profileView)
        
        NSLayoutConstraint.activate([
            notificationView.rightAnchor.constraint(equalTo: profileView.leftAnchor, constant: -Const.ViewNoitfyRightMargin),
            notificationView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ViewNoitfyBottomMarginForLargeState),
            notificationView.heightAnchor.constraint(equalToConstant: Const.ViewNoitfyForLargeState),
            notificationView.widthAnchor.constraint(equalTo: notificationView.heightAnchor),
            
            profileView.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -Const.ViewProfileRightMargin),
            profileView.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -Const.ViewProfileBottomMarginForLargeState),
            profileView.heightAnchor.constraint(equalToConstant: Const.ViewProfileForLargeState),
            profileView.widthAnchor.constraint(equalTo: profileView.heightAnchor)
            ])
    }
    
    private func moveAndResizeButtons(for height: CGFloat) {
        let coeff: CGFloat = {
            let delta = height - Const.NavBarHeightSmallState
            let heightDifferenceBetweenStates = (Const.NavBarHeightLargeState - Const.NavBarHeightSmallState)
            return delta / heightDifferenceBetweenStates
        }()

        let factor = Const.ViewProfileSizeForSmallState / Const.ViewProfileForLargeState
        let factor1 = Const.ViewProfileSizeForSmallState / Const.ViewProfileForLargeState
        
        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()
        
        let scale1: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor1)
            return min(1.0, sizeAddendumFactor + factor1)
        }()
        
        // Value of difference between icons for large and small states
        let sizeDiff = Const.ViewNoitfyForLargeState * (1.0 - factor) // 8.0
        let sizeDiff1 = Const.ViewProfileForLargeState * (1.0 - factor1)
        let yTranslation: CGFloat = {
            /// This value = 14. It equals to difference of 12 and 6 (bottom margin for large and small states). Also it adds 8.0 (size difference when the image gets smaller size)
            let maxYTranslation = Const.ViewNoitfyBottomMarginForLargeState - Const.ViewNoitfyBottomMarginForSmallState + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff * (Const.ViewNoitfyBottomMarginForSmallState + sizeDiff))))
        }()
        
        let yTranslation1: CGFloat = {
            /// This value = 14. It equals to difference of 12 and 6 (bottom margin for large and small states). Also it adds 8.0 (size difference when the image gets smaller size)
            let maxYTranslation = Const.ViewProfileBottomMarginForLargeState - Const.ViewProfileBottomMarginForSmallState + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff * (Const.ViewProfileBottomMarginForSmallState + sizeDiff))))
        }()

        let xTranslation = max(0, sizeDiff - coeff * sizeDiff)
        let xTranslation1 = max(0, sizeDiff1 - coeff * sizeDiff1)

        notificationView.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
        
        profileView.transform = CGAffineTransform.identity
            .scaledBy(x: scale1, y: scale1)
            .translatedBy(x: xTranslation1, y: yTranslation1)
    }
    
    @objc func transitionMethod() {
        setVibration()
        let vc = StoryBoard.Home.instantiateViewController(withIdentifier: "ConfirmOrderVC") as! ConfirmOrderVC
        vc.nav = self
        let transitionDelegate = SPStorkTransitioningDelegate()
        transitionDelegate.customHeight = CGFloat(UIScreen.main.bounds.height/1.85)
        transitionDelegate.showIndicator = false
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: vc)
        rootNavView.transitioningDelegate = transitionDelegate
        rootNavView.modalPresentationStyle = .custom
        rootNavView.modalPresentationCapturesStatusBarAppearance = true
        getNav.present(rootNavView, animated: true, completion: nil)
    }
    
    // MARK: - Button Action Methods
    
    @IBAction func btnNotify_Action(_ sender: UIView) {
        setVibration()
        let aboutVC = StoryBoard.Settings.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        aboutVC.isModalInPresentation = true
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: aboutVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
    
    @IBAction func btnProfile_Action(_ sender: UIView) {
        setVibration()
        let aboutVC = StoryBoard.Settings.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        aboutVC.isModalInPresentation = true
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: aboutVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
    
}

// MARK: - TableView DataSource Methods
extension GiftVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyGiftsTableCell", for: indexPath) as! MyGiftsTableCell
        if indexPath.row == 1 || indexPath.row == 3 {
            cell.imgRibbon.isHidden = true
            cell.lblRibbon.isHidden = true
        } else {
            cell.imgRibbon.isHidden = false
            cell.lblRibbon.isHidden = false
        }
        cell.btnChoise.addTarget(self, action: #selector(transitionMethod), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
// MARK: - TableView Delegate Methods
extension GiftVC: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        transitionMethod()
        
    }
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let height = navigationController?.navigationBar.frame.height else { return }
        moveAndResizeButtons(for: height)
    }
}

// MARK: - Collection View Methods
extension GiftVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrText.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCollectionCell", for: indexPath) as! HeaderCollectionCell
        cell.lblTitle.text = arrText[indexPath.row]
        cell.lblTitle.textAlignment = .center
        if index == indexPath.row {
          cell.lblTitle.font = UIFont(name: "DMSans-Medium", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .medium)
          cell.lblTitle.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
          cell.backView.backgroundColor = #colorLiteral(red: 0.2235294118, green: 0.3176470588, blue: 0.3843137255, alpha: 1)
        } else {
          cell.lblTitle.font = UIFont(name: "DMSans-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .regular)
          cell.lblTitle.textColor = #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4117647059, alpha: 1)
          cell.backView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (arrText[indexPath.row] as NSString).size(withAttributes: nil)
        return CGSize(width: size.width + 40, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setVibration()
        index = indexPath.row
        collectionView.reloadData()
    }
}
// MARK: - Table View Cell class

class MyGiftsTableCell: UITableViewCell {
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var imgRibbon: UIImageView!
    @IBOutlet weak var lblRibbon: UILabel!
    @IBOutlet weak var btnChoise: UIControl!
    
}

// MARK: - Collection View Cell class

class HeaderCollectionCell: UICollectionViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var backView: UIView!
    
    
}

 struct Const {
    /// Image height/width for Large NavBar state
    static let ViewNoitfyForLargeState: CGFloat = 32
    static let ViewProfileForLargeState: CGFloat = 32
    
    //static let ImageSizeForLargeState: CGFloat = 40
    /// Margin from right anchor of safe area to right anchor of Image
    static let ViewNoitfyRightMargin: CGFloat = 12
    static let ViewProfileRightMargin: CGFloat = 16
    /// Margin from bottom anchor of NavBar to bottom anchor of Image for Large NavBar state
    static let ViewNoitfyBottomMarginForLargeState: CGFloat = 12
    static let ViewProfileBottomMarginForLargeState: CGFloat = 12
    /// Margin from bottom anchor of NavBar to bottom anchor of Image for Small NavBar state
    static let ViewNoitfyBottomMarginForSmallState: CGFloat = 6
    static let ViewProfileBottomMarginForSmallState: CGFloat = 6
    //static let ImageBottomMarginForSmallState: CGFloat = 6
    /// Image height/width for Small NavBar state
    static let ViewNoitfySizeForSmallState: CGFloat = 32
    static let ViewProfileSizeForSmallState: CGFloat = 32
    //static let ImageSizeForSmallState: CGFloat = 32
    /// Height of NavBar for Small state. Usually it's just 44
    static let NavBarHeightSmallState: CGFloat = 44
    /// Height of NavBar for Large state. Usually it's just 96.5 but if you have a custom font for the title, please make sure to edit this value since it changes the height for Large state of NavBar
    static let NavBarHeightLargeState: CGFloat = 96.5
}
