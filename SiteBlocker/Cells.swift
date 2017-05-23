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
    
    var suggestion:Suggestion? = nil
    
    override func customSetup() {
        addSubview(button)
        removeButton.snp.makeConstraints { (make) in
            make.size.equalTo(snp.size)
            make.left.equalTo(snp.left)
            make.top.equalTo(snp.top)
            
        }
        removeButton.rx.tap.subscribe{ _ in
            print("TAPPED")
        }.addDisposableTo(disposeBag)
        simpleLabel.text = suggestion?.title
        backgroundColor = suggestion?.color
    }
    
}

