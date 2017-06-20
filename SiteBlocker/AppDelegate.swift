//
//  AppDelegate.swift
//  SiteBlocker
//
//  Created by Luke Mann on 5/17/17.
//  Copyright © 2017 Luke Mann. All rights reserved.
//

import UIKit
import SafariServices

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if UserDefaults.standard.bool(forKey: "hasLoaded"){
            Domain.reloadDomains()
        }
        else {
            UserDefaults.standard.set(true, forKey: "constantSwitch")
        }
        Suggestion.loadInitialSuggestions()
        Suggestion.bindSuggestionsToDomains()

        ExtensionManager.setupJSON()
        ExtensionManager.reload()
        

        self.window = UIWindow(frame: UIScreen.main.bounds)
        let snapVC = SwipeNavigationController(centerViewController: CenterViewController.singleton)
        snapVC.leftViewController = LeftViewController.singleton
        snapVC.rightViewController = RightViewController()
        self.window?.rootViewController = snapVC
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        
        return true
}
}




