//
//  RankingVC.swift
//  TrashBack
//
//  Created by angrz singh on 21/01/22.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation
import MonthYearPicker

class RankingVC: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var notificationCountView: UIView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet var topHeaderview: UIView!
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var profileView: UIControl!
    @IBOutlet weak var lblSelection1: UILabel!
    @IBOutlet weak var lblSelection2: UILabel!
    @IBOutlet weak var txtDateField: UITextField!
    
    // MARK: - Varialbles
    var behavior = MSCollectionViewPeekingBehavior()
    var rank = 0
    let titleArr = ["Jean Dujardin", "Anne-Sophie Lapix", "Jean Dujardin", "Daniel Terreaux","Jean Dujardin","Jean Dujardin","Anne-Sophie"]
    let iconArr = [#imageLiteral(resourceName: "profile"), #imageLiteral(resourceName: "profil3 copy"), #imageLiteral(resourceName: "profile"), #imageLiteral(resourceName: "profil1"), #imageLiteral(resourceName: "profile"), #imageLiteral(resourceName: "profil1"), #imageLiteral(resourceName: "profil3 copy")]
    let arrSection = ["Ta position","Classement général"]
    lazy var datePicker: MonthYearPickerView = {
        let picker = MonthYearPickerView(frame: CGRect.init(x: 0.0, y: (view.bounds.height - 216) / 2, width: view.bounds.width, height: 216))
        let date = Calendar.current.date(byAdding: .year, value: -13, to: Date())
        picker.minimumDate = date
        picker.maximumDate = Date()
        return picker
    }()
    var toolBar = UIToolbar()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //PickerViewConnection()
        //Mark: HeaderView Configuration
        self.tableView.tableHeaderView = topHeaderview
        self.tableView.tableHeaderView?.frame = topHeaderview.frame
        
        self.behavior = MSCollectionViewPeekingBehavior(cellSpacing: 10, cellPeekWidth: 10)
        self.bannerCollectionView.configureForPeekingBehavior(behavior: behavior)
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
        self.navigationItem.title = "Classements"
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
    
    func openOptions() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Classements mensuels", style: .default, handler: { _ in
            self.lblSelection1.text = "Classements mensuels"
        }))
        
        alert.addAction(UIAlertAction(title: "Classements annuels", style: .default, handler: { _ in
            self.lblSelection1.text = "Classements annuels"
        }))
        alert.addAction(UIAlertAction.init(title: Messages.txtCancel, style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    // MARK:  Picker View Setup
        func PickerViewConnection() {
            datePicker.backgroundColor = UIColor.white
            datePicker.setValue(UIColor.black, forKey: "textColor")
            datePicker.autoresizingMask = .flexibleWidth
            datePicker.contentMode = .center
            datePicker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
            
            toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width , height: 50))
            toolBar.barStyle = UIBarStyle.black
            toolBar.isTranslucent = true
            let done = UIBarButtonItem(title: "Valider", style: .done, target: self, action: #selector(onDoneButtonTapped))
            let cancel = UIBarButtonItem(title: "Annuler", style: .plain, target: self, action: #selector(onCancelButtonTapped))
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            toolBar.setItems([cancel, flexibleSpace, done], animated: false)
        }
    
    // MARK: The Function For the Picker Done button
        @objc func onDoneButtonTapped() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM yyyy"
            dateFormatter.locale = Locale(identifier: "fr")
            self.lblSelection2.text = dateFormatter.string(from: datePicker.date)
            
            toolBar.removeFromSuperview()
            datePicker.removeFromSuperview()
        }
        // MARK:  The Function For the Picker Cancel button
        @objc func onCancelButtonTapped() {
            toolBar.removeFromSuperview()
            datePicker.removeFromSuperview()
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
    
    @IBAction func viewRanking_Action(_ sender: UIView) {
        setVibration()
        openOptions()
    }
    
    @IBAction func viewDate_Action(_ sender: UIView) {
//        setVibration()
//        Constants.kAppDelegate.window?.addSubview(datePicker)
        //Constants.kAppDelegate.window?.addSubview(toolBar)
//        self.view.addSubview(datePicker)
//        self.view.addSubview(toolBar)
    }
}

// MARK: - TextFiels Delegate Methods
extension RankingVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtDateField {
            setVibration()
            textField.inputView = datePicker
        }
        //        DispatchQueue.main.async {
        //          textField.resignFirstResponder()
        //        }
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField == txtDateField {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM yyyy"
            dateFormatter.locale = Locale(identifier: "fr")
            txtDateField.text = dateFormatter.string(from: datePicker.date)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

// MARK: - TableView Datasourec Methods
extension RankingVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return titleArr.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RankingTableCell", for: indexPath) as! RankingTableCell
            cell.imgProfile.image = #imageLiteral(resourceName: "profile")
            cell.lblName.text = "Jean Dujardin"
            cell.lblRankings.text = "5"
            cell.backView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            cell.backView.borderWidth = 0.6
            cell.backView.borderColor = #colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 1)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RankingTableCell", for: indexPath) as! RankingTableCell
            cell.imgProfile.image = iconArr[indexPath.row]
            cell.lblName.text = titleArr[indexPath.row]
            cell.lblRankings.text = "\(indexPath.row + 1)"
            
            if indexPath.row == 4 {
                cell.backView.borderWidth = 2.5
                cell.backView.borderColor = #colorLiteral(red: 0.2235294118, green: 0.3176470588, blue: 0.3843137255, alpha: 1)
            } else {
                cell.backView.borderWidth = 0.6
                cell.backView.borderColor = #colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 1)
            }
            
            let leftColor = #colorLiteral(red: 0.2235294118, green: 0.3176470588, blue: 0.3843137255, alpha: 1)
            let rightColor = #colorLiteral(red: 0.4196078431, green: 0.537254902, blue: 0.6078431373, alpha: 1)
            
            if self.rank == indexPath.row {
                DispatchQueue.main.async {
                    cell.backView.addGradientBackground(firstColor: leftColor, secondColor: rightColor)
                    cell.lblName.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                    cell.lblPoints.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.39)
                    cell.lblRankings.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                }
            } else {
               // cell.backView.removeAllSublayers()
                cell.backView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                cell.lblName.textColor = #colorLiteral(red: 0.2156862745, green: 0.2274509804, blue: 0.2392156863, alpha: 1)
                cell.lblPoints.textColor = #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4117647059, alpha: 1)
                cell.lblRankings.textColor = #colorLiteral(red: 0.2156862745, green: 0.2274509804, blue: 0.2392156863, alpha: 1)
            }
            return cell
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 44))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 16, y: 8, width: headerView.frame.width, height: headerView.frame.height)
        label.text = arrSection[section]
        label.font = UIFont(name: "DMSans-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = #colorLiteral(red: 0.4117647059, green: 0.4117647059, blue: 0.4117647059, alpha: 1)
        headerView.addSubview(label)
        
        return headerView
    }
}
// MARK: - TableView delegates Methods
extension RankingVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setVibration()
        if indexPath.section == 1 {
            let aboutVC = StoryBoard.Home.instantiateViewController(withIdentifier: "HistoryVC") as! HistoryVC
            aboutVC.userName = titleArr[indexPath.row]
            aboutVC.isModalInPresentation = true
            guard let getNav = UIApplication.topViewController()?.navigationController else {
                return
            }
            let rootNavView = UINavigationController(rootViewController: aboutVC)
            getNav.present( rootNavView, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       guard let height = navigationController?.navigationBar.frame.height else { return }
       moveAndResizeButtons(for: height)
   }
}

// MARK: - CollectionView DataSource
extension RankingVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AnnouceCollectionCell", for: indexPath) as! AnnouceCollectionCell
        return cell
    }
}

// MARK: - CollectionView Delegate
extension RankingVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(behavior.currentIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/1.2, height: collectionView.frame.height)
    }
}
//MARK: - Table View Cell Class
class RankingTableCell: UITableViewCell {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var lblRankings: UILabel!
    @IBOutlet weak var backView: UIView!
    
}



