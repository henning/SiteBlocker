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
          let url =  userDefaults?.url(forKey: "foo")
    
        //        let foo = NSItemProvider(
        let attachment = NSItemProvider(contentsOf: url)
        //        let foo =
        
        
        
        let item = NSExtensionItem()
        item.attachments = [attachment]
        
        context.completeRequest(returningItems: [item], completionHandler: nil)
    }
    
}
