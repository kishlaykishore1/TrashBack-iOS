//
//  AppDelegate.swift
//  TrashBack
//
//  Created by kishlay kishore on 11/01/22.
//

import UIKit
import IQKeyboardManagerSwift
import GooglePlaces
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var kApplication: UIApplication?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    IQKeyboardManager.shared.enable = true
    IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Valider"
   // GMSPlacesClient.provideAPIKey("AIzaSyCazkRk26jM_XBwcVazTWDEtb2wuGKjljs")
    GMSPlacesClient.provideAPIKey("AIzaSyDl7_FSdciY-C2CLajDN_TDxcRYybJZ45A")
    GMSServices.provideAPIKey("AIzaSyDl7_FSdciY-C2CLajDN_TDxcRYybJZ45A")
    // Override point for customization after application launch.
    isUserLogin(false)
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }


}

extension AppDelegate {
  //Check User Login
  func isUserLogin(_ isLogin:Bool) {
    if isLogin {
        let homevc = StoryBoard.Home.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        let nav = UINavigationController(rootViewController: homevc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    } else {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let loginvc = storyboard.instantiateViewController(withIdentifier: "IntroVC") as! IntroVC
      let nav = UINavigationController(rootViewController: loginvc)
      window?.rootViewController = nav
      window?.makeKeyAndVisible()
    }
  }
}
