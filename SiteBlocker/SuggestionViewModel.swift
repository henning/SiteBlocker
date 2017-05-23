//
//  SuggestionViewModel.swift
//  SiteBlocker
//
//  Created by Luke Mann on 5/22/17.
//  Copyright © 2017 Luke Mann. All rights reserved.
//

import UIKit
import RxSwift

let suggestions: Variable<[Suggestion]> = Variable([Suggestion(color: UIColor.black, title:"HERE")])


struct Suggestion {
    var color:UIColor
    var title: String
    
    init(color: UIColor, title:String) {
        self.color = color
        self.title = title
    }
}
