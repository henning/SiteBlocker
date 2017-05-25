//
//  SuggestionViewModel.swift
//  SiteBlocker
//
//  Created by Luke Mann on 5/22/17.
//  Copyright © 2017 Luke Mann. All rights reserved.
//

import UIKit
import RxSwift

var suggestions: Variable<[Suggestion]> = Variable([])
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
                    , title:"twitch.tv"
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
            for suggestion in suggestions.value {
                if !suggestion.shouldShow{
                    for sug in suggestionsToLoad.value {
                        if sug == suggestion{
                            let _  = suggestionsToLoad.value.removeObject(object: suggestion)
                        }
                    }
                }
        }
        
    }
}

extension Array {
    mutating func removeObject<U: Equatable>(object: U) -> Bool {
        for (idx, objectToCompare) in self.enumerated() {
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
