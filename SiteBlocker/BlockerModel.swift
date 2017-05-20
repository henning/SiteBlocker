//
//  BlockerModel.swift
//  SiteBlocker
//
//  Created by Luke Mann on 5/17/17.
//  Copyright © 2017 Luke Mann. All rights reserved.
//

import Foundation
import SafariServices
import RxSwift
import SwiftyJSON

let domains: Variable<[Domain]> = Variable([])

struct Domain {
    var contentBlockerAddress: String = ""
    var simpleAddress: String = ""
    
    init(simpleAddress: String) {
        self.simpleAddress=simpleAddress.lowercased()
        let parts = self.simpleAddress.components(separatedBy: ".")
        for i in 0..<parts.count{
            if parts[i]=="com"{
                if i != 0{
            self.contentBlockerAddress = ".*\(parts[i-1]).*"

                }

            }

        }
        add()
    }
    
    func add() {
        
        let url = UserDefaults(suiteName: "group.com.lukejmann.foo")!.url(forKey: "foo")
        print(url?.absoluteString)
        let origData = try! Data(contentsOf: url!)
        var json = JSON(origData)
        let jsonElement = JSON([
            "trigger":["url-filter": contentBlockerAddress],
            "action": ["type":"block"]
        ])
        json.appendIfArray(json: jsonElement)
        let string = JSON.makeProperFormat(json: json)
        let data = string.data(using: .utf8)
        try! data?.write(to: url!)
        reloadExtension()

   

    }
    
    func remove() {
        
    }
    
    
    private func reloadExtension() {
        let identifierHosts = "com.lukejmann.SiteBlocker.Extension"
        SFContentBlockerManager.reloadContentBlocker(withIdentifier: identifierHosts) { (error) -> Void in
            print(error ?? "")
            print("Reloaded.")
        }
    }
    
    }






