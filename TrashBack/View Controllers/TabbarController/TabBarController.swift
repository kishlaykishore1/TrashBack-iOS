//
//  TabBarController.swift
//  TrashBack
//
//  Created by angrz singh on 21/01/22.
//

import UIKit
import SPStorkController

class TabBarController: UITabBarController {
    
    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height } ()
    var toMakeButtonUp = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.navigationController?.isNavigationBarHidden = true
        setupTabs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let newTabBarHeight = defaultTabBarHeight
        var newFrame = tabBar.frame
        newFrame.size.height = newTabBarHeight
        newFrame.origin.y = view.frame.size.height - newTabBarHeight
        tabBar.frame = newFrame
        
        DispatchQueue.main.async {
            self.tabBar.isTranslucent = false
            self.tabBar.backgroundColor = .white
            self.tabBar.tintColor = #colorLiteral(red: 0.6039215686, green: 0.7137254902, blue: 0.7490196078, alpha: 1)
            
            self.tabBar.layer.shadowOffset = CGSize(width: 0, height: -4)
            self.tabBar.layer.shadowRadius = 5.0
            self.tabBar.layer.shadowColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
            self.tabBar.layer.shadowOpacity = 0.5
        }
    }
    
    fileprivate func setupTabs() {
        
        let homeVC = StoryBoard.Home.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        homeVC.tabBarItem = UITabBarItem(title: "Accueil", image: #imageLiteral(resourceName: "home"), selectedImage: #imageLiteral(resourceName: "homeSelected"))
        homeVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2235294118, green: 0.3176470588, blue: 0.3843137255, alpha: 1)], for: .selected)
        
        let openCanVC = StoryBoard.Home.instantiateViewController(withIdentifier: "OpenCanVC") as! OpenCanVC
        openCanVC.tabBarItem = UITabBarItem(title: "Historique", image: UIImage(named: "open-can"), selectedImage: #imageLiteral(resourceName: "open-canSelected"))
        openCanVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2235294118, green: 0.3176470588, blue: 0.3843137255, alpha: 1)], for: .selected)
        
        let emptyVC = UIViewController()
        emptyVC.tabBarItem = UITabBarItem(title: nil, image: nil, selectedImage: nil)
        
        let giftVC = StoryBoard.Home.instantiateViewController(withIdentifier: "GiftVC") as! GiftVC
        giftVC.tabBarItem = UITabBarItem(title: "Cadeaux", image: #imageLiteral(resourceName: "gift"), selectedImage: #imageLiteral(resourceName: "giftSelected"))
        giftVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2235294118, green: 0.3176470588, blue: 0.3843137255, alpha: 1)], for: .selected)
        
        let rankingVC = StoryBoard.Home.instantiateViewController(withIdentifier: "RankingVC") as! RankingVC
        rankingVC.tabBarItem = UITabBarItem(title: "Classements", image: #imageLiteral(resourceName: "ranking"), selectedImage: #imageLiteral(resourceName: "rankingSelected"))
        rankingVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2235294118, green: 0.3176470588, blue: 0.3843137255, alpha: 1)], for: .selected)
        
        let controllers = [homeVC, openCanVC, emptyVC, giftVC, rankingVC]
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
        
        guard let tabBar = self.tabBar as? CustomTabBar else { return }
        tabBar.didTapButton = { [unowned self] in
            self.openBottomSheet()
        }
    }
    
    func openBottomSheet() {
        setVibration()
        let vc = StoryBoard.Home.instantiateViewController(withIdentifier: "CommonBottomSheet") as! CommonBottomSheet
        vc.nav = self.navigationController ?? UINavigationController()
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

// MARK: - UITabBarController Delegate
extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        setVibration()
        guard let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) else {
            return true
        }
        // Your middle tab bar item index.
        // In my case it's 2.
        if selectedIndex == 2 {
            return false
        }
        return true
    }
}
