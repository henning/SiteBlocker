//
//  SuggestionViewModel.swift
//  SiteBlocker
//
//  Created by Luke Mann on 5/22/17.
//  Copyright © 2017 Luke Mann. All rights reserved.
//

import UIKit
import RxSwift

let suggestions: Variable<[Suggestion]> = Variable([
    Suggestion(color: UIColor(red: 58/255, green: 76/255, blue: 127/255, alpha: 1.0)
        , title:"facebook.com"),
    Suggestion(color: UIColor(red: 228/255, green: 42/255, blue: 38/255, alpha: 1.0)
        , title:"youtube.com"),
    Suggestion(color: UIColor(red: 253/255, green: 74/255, blue: 33/255, alpha: 1.0)
        , title:"reddit.com"),
    Suggestion(color: UIColor(red: 113/255, green: 173/255, blue: 218/255, alpha: 1.0)
        , title:"twitter.com"),
    Suggestion(color: UIColor(red: 136/255, green: 63/255, blue: 166/255, alpha: 1.0)
        , title:"twitch.com"),
    Suggestion(color: UIColor(red: 192/255, green: 23/255, blue: 153/255, alpha: 1.0)
        , title:"instagram.com"),

    ])


struct Suggestion {
    var color:UIColor
    var title: String
    
    init(color: UIColor, title:String) {
        self.color = color
        self.title = title
    }
}
