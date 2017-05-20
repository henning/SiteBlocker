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
import Chameleon

class DomainCell: UITableViewCell {
    var domain:Domain? = nil
    
    var containerView = UIView()
    var simpleLabel = UILabel()
    let removeButton = UIButton()
    

    override func layoutSubviews() {
        addSubview(containerView)
        containerView.backgroundColor = UIColor.flatWhite()
        containerView.layer.cornerRadius = 10
        
        
        self.containerView.snp.makeConstraints { (make) in
            make.top.equalTo(snp.top).offset(5)
            make.bottom.equalTo(snp.bottom).offset(-5)
            make.width.equalTo(snp.width)
        }
        
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
                    d.remove()
                    domains.value.remove(at: i)
                    break
                }
                i+=1
            }

//            domains.value.remove(at: domains.value.i))
        }
        
        containerView.addSubview(simpleLabel)
        simpleLabel.text = domain?.simpleAddress
        simpleLabel.font = UIFont(name: "AvenirNext-Regular", size: 24)
        simpleLabel.textColor = UIColor.flatBlack()
        self.simpleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(containerView.snp.left).offset(10)
            make.right.equalTo(containerView.snp.right).offset(-10)
            make.height.equalTo(containerView.snp.height)
            make.centerY.equalTo(containerView.snp.centerY)
        }
        
        

    }
}
