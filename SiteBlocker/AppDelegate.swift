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

//        let url = Bundle.main.url(forResource: "blockerList", withExtension: "json")
        //       let url =  FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.lukejmann.foo")?.appendingPathComponent("test.json")
        //        let data = try! Data(contentsOf: url!)
        
        
        
        
        let fileName = "blockerList"
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let data = try! Data(contentsOf: (Bundle.main.url(forResource: "blockerList", withExtension: "json")as! URL))
        
//        let url:URL? = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("json")
//        let url = Bundle.main.url(forResource: "blockerList", withExtension: "json")
        
        let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.lukejmann.foo")?.appendingPathComponent("blockerList.json")
        
        
        
        do {
            // Write to the file
            try data.write(to: url!)
        } catch let error as NSError {
            print("Failed writing to URL: \(url), Error: " + error.localizedDescription)
        }
        
        
        
        
        
        print(url?.absoluteString)
        
        
        
        
        
        
        let userDefaults = UserDefaults(suiteName: "group.com.lukejmann.foo")
        if let userDefaults = userDefaults {
            userDefaults.set(url, forKey: "foo")
        }
        
        let identifierHosts = "com.lukejmann.SiteBlocker.Extension"
        SFContentBlockerManager.reloadContentBlocker(withIdentifier: identifierHosts) { (error) -> Void in
            print(error ?? "")
            print("Reloaded.")
        }
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window?.rootViewController = ViewController()
        
        self.window?.backgroundColor = UIColor.white
        
        self.window?.makeKeyAndVisible()
        
        
        return true
    }


}

