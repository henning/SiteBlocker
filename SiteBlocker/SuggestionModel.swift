//
//  SuggestionViewModel.swift
//  SiteBlocker
//
//  Created by Luke Mann on 5/22/17.
//  Copyright © 2017 Luke Mann. All rights reserved.
//

import UIKit
import RxSwift

var suggestions: Variable<[Suggestion]> = Variable([
//    Suggestion(color: UIColor(red: 58/255, green: 76/255, blue: 127/255, alpha: 1.0)
//        , title:"facebook.com"),
//    Suggestion(color: UIColor(red: 228/255, green: 42/255, blue: 38/255, alpha: 1.0)
//        , title:"youtube.com"),
//    Suggestion(color: UIColor(red: 253/255, green: 74/255, blue: 33/255, alpha: 1.0)
//        , title:"reddit.com"),
//    Suggestion(color: UIColor(red: 113/255, green: 173/255, blue: 218/255, alpha: 1.0)
//        , title:"twitter.com"),
//    Suggestion(color: UIColor(red: 136/255, green: 63/255, blue: 166/255, alpha: 1.0)
//        , title:"twitch.com"),
//    Suggestion(color: UIColor(red: 192/255, green: 23/255, blue: 153/255, alpha: 1.0)
//        , title:"instagram.com"),

    ])

var suggestionsToLoad : Variable<[Suggestion]> = Variable([])



class Suggestion: Equatable {
    var color:UIColor
    var title: String
    var shouldShow:Bool {
        didSet{
            Suggestion.bindSuggestionsToLoad()
        }
    }
    
    public static func == (lhs: Suggestion, rhs: Suggestion) -> Bool{
        if lhs.title == rhs.title {
            return true
        }
        return false
    }
    
    init(color: UIColor, title:String,shouldShow:Bool) {
        self.color = color
        self.title = title
        self.shouldShow = shouldShow
    }
    
//    required convenience init(coder aDecoder: NSCoder) {
//        let color = aDecoder.decodeObject(forKey: "color") as! UIColor
//        let title = aDecoder.decodeObject(forKey: "title") as! String
//        let shouldShow = aDecoder.decodeObject(forKey: "shouldShow") as! Bool
//        self.init(color: color, title: title,shouldShow:shouldShow)
//    }
//    
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(color, forKey: "color")
//        aCoder.encode(title, forKey: "title")
//        aCoder.encode(shouldShow, forKey: "shouldShow")
//    }
//    
//    static func loadSuggestions(){
//        
//    }
//    
//    static func reloadSuggestions() {
//        let userDefaults = UserDefaults.standard
//        let decoded  = userDefaults.object(forKey: "suggestions") as! Data
//        let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Suggestion]
//        suggestions = Variable(decodedTeams)
//    }
//    
//    static func setSuggestions() {
//        let userDefaults = UserDefaults.standard
//        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: suggestions.value)
//        userDefaults.set(encodedData, forKey: "suggestions")
//        userDefaults.synchronize()
//    }
    
    static func loadInitialSuggestions() {
         suggestions = Variable([
                Suggestion(color: UIColor(red: 58/255, green: 76/255, blue: 127/255, alpha: 1.0)
                    , title:"facebook.com"
                    , shouldShow: true
            ),
                Suggestion(color: UIColor(red: 228/255, green: 42/255, blue: 38/255, alpha: 1.0)
                    , title:"youtube.com"
                    , shouldShow: true
            ),
                Suggestion(color: UIColor(red: 253/255, green: 74/255, blue: 33/255, alpha: 1.0)
                    , title:"reddit.com"
                    , shouldShow: true
            ),
                Suggestion(color: UIColor(red: 113/255, green: 173/255, blue: 218/255, alpha: 1.0)
                    , title:"twitter.com"
                    , shouldShow: true
            ),
                Suggestion(color: UIColor(red: 136/255, green: 63/255, blue: 166/255, alpha: 1.0)
                    , title:"twitch.com"
                    , shouldShow: true
            ),
                Suggestion(color: UIColor(red: 192/255, green: 23/255, blue: 153/255, alpha: 1.0)
                    , title:"instagram.com"
                    , shouldShow: true
            ),
            
            ])
        suggestionsToLoad.value = []
        for suggestion in suggestions.value {
            suggestionsToLoad.value.append(suggestion)
        }
        let sug = suggestions
        let sugl = suggestionsToLoad
        for suggestion in suggestions.value {
            for domain in domains.value {
                if suggestion.title == domain.simpleAddress {
                    suggestion.shouldShow = false
                }
            }
        }
        
        Suggestion.bindSuggestionsToLoad()
        
    }
    
     static func bindSuggestionsToLoad() {
//        suggestions.asObservable().subscribe{ suggestion in
//            suggestionsToLoad = Variable([])
//            for element in suggestion.element! {
//                if element.shouldShow{
//                    suggestionsToLoad.value.append(element)
//                }
//            }
//        }
            for suggestion in suggestions.value {
                if !suggestion.shouldShow{
                    for sug in suggestionsToLoad.value {
                        if sug == suggestion{
                            suggestionsToLoad.value.removeObject(object: suggestion)
                        }
                    }
                }
        }
        
    }
}

extension Array {
    mutating func removeObject<U: Equatable>(object: U) -> Bool {
        for (idx, objectToCompare) in self.enumerated() {  //in old swift use enumerate(self)
            if let to = objectToCompare as? U {
                if object == to {
                    self.remove(at: idx)
                    return true
                }
            }
        }
        return false
    }
}
