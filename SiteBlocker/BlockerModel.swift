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

var domains: Variable<[Domain]> = Variable([])

class Domain:NSObject,NSCoding {
    var contentBlockerAddress: String = ""
    var simpleAddress: String = ""
    
    init(simpleAddress: String) {
        self.simpleAddress=simpleAddress.lowercased()
        let parts = self.simpleAddress.components(separatedBy: ".")

        var string = "*"

        string.append(simpleAddress)
        self.contentBlockerAddress = string

    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let simpleAddress = aDecoder.decodeObject(forKey: "simpleAddress") as! String
        self.init(simpleAddress: simpleAddress)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(simpleAddress, forKey: "simpleAddress")

    }
    
    func add() {
        
        let url = UserDefaults(suiteName: "group.com.lukejmann.foo")!.url(forKey: "foo")
        let origData = try! Data(contentsOf: url!)
        var json = JSON(origData)
        let jsonElement = JSON([
            "trigger":["url-filter": ".*","if-domain":[contentBlockerAddress]],
            "action": ["type":"block"]
            ])
        json.appendIfArray(json: jsonElement)
        let string = JSON.makeProperFormat(json: json)
        let data = string.data(using: .utf8)
        try! data?.write(to: url!)
        ExtensionManager.reload()
        Domain.setDomains()
        Suggestion.loadInitialSuggestions()
        
        
    }
    
    func remove() {
        let url = UserDefaults(suiteName: "group.com.lukejmann.foo")!.url(forKey: "foo")
        let origData = try! Data(contentsOf: url!)
        var json = JSON(origData)
        let jsonElement = JSON([
            "trigger":["url-filter": ".*","if-domain":[contentBlockerAddress]],
            "action": ["type":"block"]
            ])
        var i = 0
        if var array = json.array {
        for element in array {
            if element == jsonElement{
                array.remove(at: i)
            }
            else {
                i += 1
            }
        }
        let string = JSON.makeProperFormat(json: JSON(array))
        let data = string.data(using: .utf8)
        try! data?.write(to: url!)
        ExtensionManager.reload()
        Domain.setDomains()
            Suggestion.loadInitialSuggestions()
        }
    }
    
    
    static func reloadDomains() {
        let userDefaults = UserDefaults.standard
        let decoded  = userDefaults.object(forKey: "domains") as! Data
        let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Domain]
        domains = Variable(decodedTeams)
        Suggestion.loadInitialSuggestions()
    }
    
    static func setDomains() {
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: domains.value)
        userDefaults.set(encodedData, forKey: "domains")
        userDefaults.synchronize()
    }
    
}






