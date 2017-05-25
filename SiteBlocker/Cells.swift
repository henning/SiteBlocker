//
//  DomainsTableViewController.swift
//  SiteBlocker
//
//  Created by Luke Mann on 5/17/17.
//  Copyright © 2017 Luke Mann. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CustomTableCell: UITableViewCell{
    var containerView = UIView()
    var simpleLabel = UILabel()
    var disposeBag = DisposeBag()

    func customSetup() {
        //
    }
    
    override func layoutSubviews() {
        addSubview(containerView)
        containerView.backgroundColor = UIColor.customWhite()
        containerView.layer.cornerRadius = 10
        
        
        self.containerView.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(5)
            make.bottom.equalTo(snp.bottom).offset(-5)
            make.width.equalTo(snp.width)
        }
        containerView.addSubview(simpleLabel)
        simpleLabel.font = UIFont(name: "AvenirNext-Regular", size: 24)
        simpleLabel.textColor = UIColor.customBlack()
        self.simpleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(containerView.snp.left).offset(10)
            make.right.equalTo(containerView.snp.right).offset(-10)
            make.height.equalTo(containerView.snp.height)
            make.centerY.equalTo(containerView.snp.centerY)
        }
        customSetup()
    }
}


class DomainCell: CustomTableCell {
    var domain:Domain? = nil
    
     let removeButton = UIButton()
    
    override func customSetup(){
        simpleLabel.text = domain?.simpleAddress
        addSubview(removeButton)
        removeButton.setImage(#imageLiteral(resourceName: "remove"), for: .normal)
        removeButton.imageView?.contentMode = .scaleAspectFill
        self.removeButton.snp.makeConstraints { (make) in
            make.height.equalTo(containerView.snp.height).multipliedBy(0.3)
            make.width.equalTo(removeButton.snp.height)
            make.centerY.equalTo(containerView.snp.centerY)
            make.right.equalTo(containerView.snp.right).offset(-16)
        }
        removeButton.rx.tap.subscribe { (onNext) in
            var i = 0
            for d in domains.value {
                if self.domain?.simpleAddress == d.simpleAddress {
                    domains.value.remove(at: i)
                    d.remove()
                    break
                }
                i+=1
            }
            
            }.addDisposableTo(disposeBag)

    }
    


}

class SuggestionCell: DomainCell {
    let button = UIButton()
    
    var vc:ViewController? = nil
    
    var canLoadAgain = true
    
    var suggestion:Suggestion? = nil
    
    override func customSetup() {
         simpleLabel.text = suggestion?.title
        simpleLabel.textColor = UIColor.customWhite()
        containerView.backgroundColor = suggestion?.color
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.left.equalTo(containerView.snp.left)
            make.right.equalTo(containerView.snp.right)
            make.top.equalTo(containerView.snp.top)
            make.bottom.equalTo(containerView.snp.bottom)
        }
        button.rx.tap.subscribe { _ in
            self.suggestion?.shouldShow = false
//            if self.canLoadAgain {
            let d = Domain(simpleAddress: self.suggestion!.title)
            domains.value.append(d)
            d.add()
            self.vc?.shrinkTextBox()
//            for i in 0..<suggestions.value.count{
//                if suggestions.value[i].title == self.suggestion?.title{
//                    suggestions.value.remove(at: i)
////                    self.canLoadAgain=false
//                    break
//                }
//            }
//            }
            }.addDisposableTo(disposeBag)
    }
    
}

