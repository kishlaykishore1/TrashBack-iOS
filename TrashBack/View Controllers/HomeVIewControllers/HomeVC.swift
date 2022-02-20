//
//  HomeVC.swift
//  TrashBack
//
//  Created by angrz singh on 21/01/22.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation
import SPStorkController

class HomeVC: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ourPartnerCollectionView: UICollectionView!
    @IBOutlet weak var FeaturedCollectionView: UICollectionView!
    @IBOutlet weak var announceCollectionView: UICollectionView!
    @IBOutlet weak var notificationCountView: UIView!
    
    var behavior = MSCollectionViewPeekingBehavior()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setPermissionUI()
        scrollView.delegate = self
        
        self.behavior = MSCollectionViewPeekingBehavior(cellSpacing: 10, cellPeekWidth: 10)
        self.announceCollectionView.configureForPeekingBehavior(behavior: behavior)
        DispatchQueue.main.async {
            self.notificationCountView.cornerRadius = self.notificationCountView.frame.height/2
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Helper Methods
    func setPermissionUI() {
        let aboutVC = StoryBoard.Main.instantiateViewController(withIdentifier: "NotificationPermissionVC") as! NotificationPermissionVC
        aboutVC.isModalInPresentation = true
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: aboutVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
    
    // scroll view delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.scrollView.contentOffset.y == 0 {
            self.imageHeight.constant = 300
        } else if self.scrollView.contentOffset.y < 0 {
            self.imageHeight.constant = 300 + abs(self.scrollView.contentOffset.y)
        }
    }
    
    @IBAction func btnViewAll_Action(_ sender: UIControl) {
        setVibration()
        self.tabBarController?.selectedIndex = 3
    }
    
    @IBAction func btnLearnMore_Action(_ sender: UIControl) {
        setVibration()
        let webViewController: WebViewController = StoryBoard.Main.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        webViewController.titleString = "La vie des déchets"
        webViewController.url = "https://www.google.co.in"
        webViewController.flag = true
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: webViewController)
        getNav.present( rootNavView, animated: true, completion: nil)
        
    }
    
    @IBAction func btnViewAllPartners_Action(_ sender: UIControl) {
        setVibration()
        let addNewVC = StoryBoard.Settings.instantiateViewController(withIdentifier: "OurPartnersVC") as! OurPartnersVC
        addNewVC.isFromHome = true
        addNewVC.isModalInPresentation = true
        guard let getNav =  UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: addNewVC)
        getNav.present(rootNavView, animated: true, completion: nil)
        
    }
    
}

// MARK: -  Actions
extension HomeVC {
    
    @IBAction func action_profileTap(_ sender: UIControl) {
        setVibration()
        let aboutVC = StoryBoard.Settings.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        aboutVC.isModalInPresentation = true
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: aboutVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
    
    @IBAction func action_notificationBell(_ sender: UIControl) {
       setVibration()
        let aboutVC = StoryBoard.Settings.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        aboutVC.isModalInPresentation = true
        guard let getNav = UIApplication.topViewController()?.navigationController else {
            return
        }
        let rootNavView = UINavigationController(rootViewController: aboutVC)
        getNav.present( rootNavView, animated: true, completion: nil)
    }
    
    @IBAction func action_addPickup(_ sender: UIControl) {
      setVibration()
      openBottomSheet()
    }
    
    @IBAction func action_exchange(_ sender: UIControl) {
        setVibration()
        self.tabBarController?.selectedIndex = 3
    }
    
    func navigateToTakePictureVC() {
        let vc = StoryBoard.Home.instantiateViewController(withIdentifier: "TakePictureVC") as! TakePictureVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openBottomSheet() {
        setVibration()
        let vc = StoryBoard.Home.instantiateViewController(withIdentifier: "CommonBottomSheet") as! CommonBottomSheet
        vc.home = self
        vc.vcKey = "home"
        //vc.nav = self.navigationController ?? UINavigationController()
        let transitionDelegate = SPStorkTransitioningDelegate()
        transitionDelegate.customHeight = CGFloat(UIScreen.main.bounds.height/2)
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
}

// MARK: - CollectionView DataSource
extension HomeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == announceCollectionView {
            return 3
        } else if collectionView == FeaturedCollectionView {
            return 4
        } else {
            return 4
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == announceCollectionView {
            let cell = announceCollectionView.dequeueReusableCell(withReuseIdentifier: "AnnouceCollectionCell", for: indexPath) as! AnnouceCollectionCell
            return cell
        } else if collectionView == FeaturedCollectionView {
            let cell = FeaturedCollectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedGiftsCollectionCell", for: indexPath) as! FeaturedGiftsCollectionCell
            return cell
        } else {
            let cell = ourPartnerCollectionView.dequeueReusableCell(withReuseIdentifier: "OurPartnersCollectionCell", for: indexPath) as! OurPartnersCollectionCell
            return cell
        }
    }
}

// MARK: - CollectionView Delegate
extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
            behavior.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            print(behavior.currentIndex)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == announceCollectionView {
         return CGSize(width: announceCollectionView.frame.width/1.2, height: announceCollectionView.frame.height)
        } else if collectionView == FeaturedCollectionView {
            return CGSize(width: FeaturedCollectionView.frame.width/2.2, height: FeaturedCollectionView.frame.height)
        } else {
            return CGSize(width: ourPartnerCollectionView.frame.width/3, height: ourPartnerCollectionView.frame.width/3)
        }
    }
}
