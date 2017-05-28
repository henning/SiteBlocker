//
//  ContentBlockerRequestHandler.swift
//  Extension
//
//  Created by Luke Mann on 5/17/17.
//  Copyright © 2017 Luke Mann. All rights reserved.
//

import UIKit
import MobileCoreServices

class ContentBlockerRequestHandler: NSObject, NSExtensionRequestHandling {
    
    func beginRequest(with context: NSExtensionContext) {
        
        
        let userDefaults = UserDefaults(suiteName: "group.com.lukejmann.foo")
        
        let loadEmpty = userDefaults?.bool(forKey: "loadEmpty")
        let loadLockIn = userDefaults?.bool(forKey: "loadLockIn")

        
        if loadEmpty!{
            let url =  userDefaults?.url(forKey: "empty")
            let attachment = NSItemProvider(contentsOf: url)
            let item = NSExtensionItem()
            item.attachments = [attachment]
            context.completeRequest(returningItems: [item], completionHandler: nil)
            return
        }
        if loadLockIn! {
            let url =  userDefaults?.url(forKey: "lockIn")
            let attachment = NSItemProvider(contentsOf: url)
            let item = NSExtensionItem()
            item.attachments = [attachment]
            context.completeRequest(returningItems: [item], completionHandler: nil)
            return
        }
        let url =  userDefaults?.url(forKey: "blockerList")
        let attachment = NSItemProvider(contentsOf: url)
        let item = NSExtensionItem()
        item.attachments = [attachment]
        context.completeRequest(returningItems: [item], completionHandler: nil)
    }
    
}
