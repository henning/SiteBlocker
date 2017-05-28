//
//  RightViewController.swift
//  SiteBlocker
//
//  Created by Luke Mann on 5/28/17.
//  Copyright © 2017 Luke Mann. All rights reserved.
//

import UIKit


 class RightViewController: UIViewController {
    let settingsLabel = UILabel()
    let settingsGroupView = TableGroup()
    let likeGroupView = TableGroup()
    let dontLikeGroupView = TableGroup()
    let aboutGroupView = TableGroup()

     override func viewDidLoad() {
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.layoutIfNeeded()

        print(view.snp.height)
        print(view.frame.width.squareRoot())
        
//        view.snp.makeConstraints { (make) in
//            make.left.equalTo(view.frame.minX)
//            make.height.equalTo(view.frame.height)
//            make.width.equalTo(view.frame.width)
//            make.top.equalTo(view.frame.minY)
//        }
//        
        view.backgroundColor = UIColor.customWhite()
        
        
        view.addSubview(settingsLabel)
        settingsLabel.font = UIFont(name: "AvenirNext-Regular", size: 36)
        settingsLabel.textAlignment = .center
        settingsLabel.text = "Settings"
        settingsLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            print("ewdede\(view.frame.height)")

            make.height.equalToSuperview().dividedBy(736/41)
        }

        
        view.addSubview(settingsGroupView)
        settingsGroupView.title1 = "Enable Content Blocker"
        settingsGroupView.title2 = "Enable Notifications"
        settingsGroupView.subtitle = "I forgot to enable something in settings"
        settingsGroupView.snp.makeConstraints { (make) in
            make.top.equalTo(settingsLabel.snp.bottom).offset(23)
            make.height.equalToSuperview().dividedBy(736/118)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        settingsGroupView.setupViews()

        
        view.addSubview(likeGroupView)
        likeGroupView.title1 = "Recommend the app"
        likeGroupView.title2 = "Leave a good review"
        likeGroupView.subtitle = "I really like the app"
        likeGroupView.snp.makeConstraints { (make) in
            make.top.equalTo(settingsGroupView.snp.bottom).offset(23)
            make.height.equalToSuperview().dividedBy(736/118)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        likeGroupView.setupViews()

        view.addSubview(dontLikeGroupView)
        dontLikeGroupView.title1 = "Report A Bug"
        dontLikeGroupView.title2 = "Suggest A Feature"
        dontLikeGroupView.subtitle = "The app could be better"
        dontLikeGroupView.snp.makeConstraints { (make) in
            make.top.equalTo(likeGroupView.snp.bottom).offset(23)
            make.height.equalToSuperview().dividedBy(736/118)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        dontLikeGroupView.setupViews()

        
        view.addSubview(aboutGroupView)
        aboutGroupView.title1 = "App Website"
        aboutGroupView.title2 = "Luke Mann Website"
        aboutGroupView.subtitle = "Who made this app?"
        aboutGroupView.snp.makeConstraints { (make) in
            make.top.equalTo(dontLikeGroupView.snp.bottom).offset(23)
            make.height.equalToSuperview().dividedBy(736/118)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        aboutGroupView.setupViews()
        
        
    }
    
}

class TableGroup:UIView {
    var subtitle = "Subtitle"
    let subtitleLabel = UILabel()
    let subView1 = UIView()
    let subView2 = UIView()
    var title1 = "Title 1"
    var title2 = "Title 2"
    let link1 = "Link 1"
    let link2 = "Link 1"
    let titleLabel1 = UILabel()
    let titleLabel2 = UILabel()
    let button1 = UIButton()
    let button2 = UIButton()
    let imageView1 = UIImageView(image: #imageLiteral(resourceName: "arrow"))
    let imageView2 = UIImageView(image: #imageLiteral(resourceName: "arrow"))
    
     func setupViews() {
        print("wDihUIEGIUH")
        print(frame.height)
        
        addSubview(subtitleLabel)
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont(name: "AvenirNext-Regular", size: 14)
        subtitleLabel.textAlignment = .left
        subtitleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(8)
            make.width.equalToSuperview().offset(-16)
            make.height.equalTo(snp.height).dividedBy(125/20)
        }
        
        addSubview(subView1)
        subView1.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        subView1.layer.borderWidth = 1
        subView1.layer.borderColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
        
        subView1.snp.makeConstraints { (make) in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(-1)
            make.right.equalToSuperview().offset(1)
            make.height.equalTo(snp.height).multipliedBy(0.407)
        }
        
        subView1.addSubview(titleLabel1)
        titleLabel1.text = title1
        titleLabel1.font = UIFont(name: "AvenirNext-Regular", size: 18)
        titleLabel1.textColor = UIColor.customBlue()
        titleLabel1.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().dividedBy(47/25)
            make.left.equalToSuperview().offset(12)
            make.width.equalToSuperview().dividedBy(414/350)
        }
        
        subView1.addSubview(imageView1)
        imageView1.contentMode = .scaleAspectFill
        imageView1.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(subView1.snp.height).multipliedBy(0.5)
            make.right.equalToSuperview().dividedBy(1.06)
        }
        
        subView1.addSubview(button1)
        button1.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        addSubview(subView2)
        subView2.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        subView2.layer.borderWidth = 1
        subView2.layer.borderColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1).cgColor
        
        subView2.snp.makeConstraints { (make) in
            make.top.equalTo(subView1.snp.bottom).offset(-1)
            make.left.equalToSuperview().offset(-1)
            make.right.equalToSuperview().offset(1)
            make.height.equalTo(snp.height).multipliedBy(0.407)
        }
        
        subView2.addSubview(titleLabel2)
        titleLabel2.text = title2
        titleLabel2.font = UIFont(name: "AvenirNext-Regular", size: 18)
        titleLabel2.textColor = UIColor.customBlue()
        titleLabel2.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().dividedBy(47/25)
            make.left.equalToSuperview().offset(12)
            make.width.equalToSuperview().dividedBy(414/350)
        }
        
        subView2.addSubview(imageView2)
        imageView2.contentMode = .scaleAspectFill
        imageView2.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(subView2.snp.height).multipliedBy(0.5)
            make.right.equalToSuperview().dividedBy(1.06)
        }
        
        subView2.addSubview(button2)
        button2.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }

        
    }
}
