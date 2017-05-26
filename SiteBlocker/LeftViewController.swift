//
//  LeftViewController.swift
//  SiteBlocker
//
//  Created by Luke Mann on 5/25/17.
//  Copyright © 2017 Luke Mann. All rights reserved.
//

import UIKit

class LeftViewController:UIViewController {
    
    let timerBox = UIView()
    let scheduleBox = UIView()
    let lockInBox = UIView()
    let timerSwitch = UISwitch()
    let scheduleSwitch = UISwitch()
    let lockInSwitch = UISwitch()
    let dayView = UIView()
    let dayNumberLabel = UILabel()
    let dayIDLabel = UILabel()
    let hoursView = UIView()
    let hoursNumberLabel = UILabel()
    let hoursIDLabel = UILabel()
    let minutesView = UIView()
    let minutesNumberLabel = UILabel()
    let minutesIDLabel = UILabel()
    let secondsView = UIView()
    let secondsNumberLabel = UILabel()
    let secondsIDLabel = UILabel()
    let scheduleStartView = UIView()
    let scheduleEndView = UIView()
    let scheduleStartIDLabel = UILabel()
    let scheduleEndIDLabel = UILabel()
    let scheduleStartNumberLabel = UILabel()
    let scheduleEndNumberLabel = UILabel()
    let timerStartButton = UIButton()
    let scheduleButton = UIButton()
    let lockInButton = UIButton()
    let timerLabel = UILabel()
    let scheduleLabel = UILabel()
    let lockInLabel = UILabel()
    let lockInDescription = UILabel()
    let lockInTextBox = UITextField()
    let lockInSecondLabel = UILabel()
    
    override func viewDidLoad() {
        setupMainViews()
        setupTimerView()
        setupScheduleView()
        setupLockInView()
    }
    
    private func setupLockInView() {
        lockInBox.addSubview(lockInButton)
        lockInButton.layer.cornerRadius = 12
        lockInButton.backgroundColor = UIColor.customPurple()
        lockInButton.setTitle("Start", for: .normal)
        lockInButton.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 24)
        lockInButton.setTitleColor(UIColor.customWhite(), for: .normal)
        lockInButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(144)
            make.centerX.equalToSuperview()
            make.height.equalTo(43)
        }
        
        
        lockInBox.addSubview(lockInLabel)
        lockInLabel.font = UIFont(name: "AvenirNext-Regular", size: 24)
        lockInLabel.text = "Lock-In Mode"
        lockInLabel.textColor = UIColor.customBlack()
        lockInLabel.textAlignment = .center
        lockInLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(240)
        }
        
        lockInBox.addSubview(lockInSwitch)
        lockInSwitch.setOn(false, animated: false)
        lockInSwitch.snp.makeConstraints { (make) in
            make.top.equalTo(lockInLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        lockInBox.addSubview(lockInDescription)
        lockInDescription.font = UIFont(name: "AvenirNext-Regular", size: 12)
        lockInDescription.minimumScaleFactor = 0.4
        lockInDescription.text = "Enable this mode in order to only permit usage of the specified page"
        lockInDescription.textColor = UIColor.customBlack()
        lockInDescription.textAlignment = .center
        lockInDescription.snp.makeConstraints { (make) in
            make.top.equalTo(lockInSwitch.snp.bottom).offset(2)
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(40)
        }
        
        lockInBox.addSubview(lockInSecondLabel)
        lockInSecondLabel.font = UIFont(name: "AvenirNext-Regular", size: 26)
        lockInSecondLabel.text = "Site to Lock Into:"
        lockInSecondLabel.textColor = UIColor.customBlack()
        lockInSecondLabel.textAlignment = .center
        lockInSecondLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lockInDescription.snp.bottom).offset(2)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(240)
        }
        
        lockInBox.addSubview(lockInTextBox)
        lockInTextBox.autocapitalizationType = .none
        lockInTextBox.autocorrectionType = .no
        lockInTextBox.placeholder = "domain.com"
        lockInTextBox.font = UIFont(name: "AvenirNext-Regular", size: 20)
        lockInTextBox.textColor = UIColor.customBlack()
        lockInTextBox.layer.borderWidth = 0.5
        lockInTextBox.layer.borderColor = UIColor.customBlack().cgColor
        lockInTextBox.layer.cornerRadius = 8
        lockInTextBox.snp.makeConstraints { (make) in
            make.bottom.equalTo(lockInButton.snp.top).offset(-6)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(34)
        }

    }

    private func setupScheduleView() {
        scheduleBox.addSubview(scheduleButton)
        scheduleButton.layer.cornerRadius = 12
        scheduleButton.backgroundColor = UIColor.customPurple()
        scheduleButton.setTitle("Start", for: .normal)
        scheduleButton.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 24)
        scheduleButton.setTitleColor(UIColor.customWhite(), for: .normal)
        scheduleButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(144)
            make.centerX.equalToSuperview()
            make.height.equalTo(43)
        }
        
        
        scheduleBox.addSubview(scheduleLabel)
        scheduleLabel.font = UIFont(name: "AvenirNext-Regular", size: 24)
        scheduleLabel.text = "Schedule"
        scheduleLabel.textColor = UIColor.customBlack()
        scheduleLabel.textAlignment = .center
        scheduleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(240)
        }
        scheduleBox.addSubview(scheduleSwitch)
        scheduleSwitch.setOn(false, animated: false)
        scheduleSwitch.snp.makeConstraints { (make) in
            make.top.equalTo(scheduleLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        scheduleBox.addSubview(scheduleStartView)
        scheduleBox.addSubview(scheduleEndView)
        let width = (view.frame.width)/2
        
        scheduleStartView.snp.makeConstraints { (make) in
            make.top.equalTo(scheduleSwitch.snp.bottom).offset(2)
            make.bottom.equalTo(scheduleButton.snp.top).offset(-20)
            make.width.equalTo(width)
            make.right.equalTo(scheduleBox.snp.centerX)
        }
        scheduleEndView.snp.makeConstraints { (make) in
            make.top.equalTo(scheduleSwitch.snp.bottom).offset(2)
            make.bottom.equalTo(scheduleButton.snp.top).offset(-20)
            make.width.equalTo(width)
            make.left.equalTo(scheduleBox.snp.centerX)
        }
        scheduleStartView.addSubview(scheduleStartNumberLabel)
        scheduleStartView.addSubview(scheduleStartIDLabel)
        scheduleEndView.addSubview(scheduleEndNumberLabel)
        scheduleEndView.addSubview(scheduleEndIDLabel)
        scheduleStartIDLabel.textAlignment = .center
        scheduleStartNumberLabel.textAlignment = .center
        scheduleEndNumberLabel.textAlignment = .center
        scheduleEndIDLabel.textAlignment = .center
        scheduleStartNumberLabel.font = UIFont(name: "AvenirNext-Regular", size: 38)
        scheduleStartIDLabel.font = UIFont(name: "AvenirNext-Regular", size: 18)
        scheduleEndNumberLabel.font = UIFont(name: "AvenirNext-Regular", size: 38)
        scheduleEndIDLabel.font = UIFont(name: "AvenirNext-Regular", size: 18)
        scheduleStartIDLabel.text = "Start"
        scheduleStartNumberLabel.text = "8 A.M."
        scheduleEndNumberLabel.text = "9 P.M."
        scheduleEndIDLabel.text = "End"
        
        
        scheduleStartNumberLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.height.equalToSuperview().multipliedBy(0.7)
            make.centerX.equalToSuperview()
        }
        scheduleStartIDLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(5)
            make.height.equalToSuperview().multipliedBy(0.3)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        scheduleEndNumberLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.height.equalToSuperview().multipliedBy(0.7)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        scheduleEndIDLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(5)
            make.height.equalToSuperview().multipliedBy(0.3)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
    }
    
    private func setupTimerView() {
        timerBox.addSubview(timerLabel)
        timerLabel.font = UIFont(name: "AvenirNext-Regular", size: 24)
        timerLabel.text = "Timer"
        timerLabel.textAlignment = .center
        timerLabel.textColor = UIColor.customBlack()
        timerLabel.snp.makeConstraints { (make) in
            make.top.equalTo(timerBox.snp.top).offset(16)
            make.height.equalTo(30)
            make.centerX.equalTo(timerBox.snp.centerX)
            make.width.equalTo(80)
        }
        timerBox.addSubview(timerSwitch)
        timerSwitch.setOn(false, animated: false)
        timerSwitch.snp.makeConstraints { (make) in
            make.top.equalTo(timerLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        
        timerBox.addSubview(timerStartButton)
        timerStartButton.layer.cornerRadius = 12
        timerStartButton.backgroundColor = UIColor.customPurple()
        timerStartButton.setTitle("Start", for: .normal)
        timerStartButton.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 24)
        timerStartButton.setTitleColor(UIColor.customWhite(), for: .normal)
        timerStartButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(timerBox.snp.bottom).offset(-10)
            make.width.equalTo(144)
            make.centerX.equalTo(timerBox.snp.centerX)
            make.height.equalTo(43)
        }
        
        
        timerBox.addSubview(dayView)
        timerBox.addSubview(hoursView)
        timerBox.addSubview(minutesView)
        timerBox.addSubview(secondsView)
        
        
        let width = (view.frame.width-40) / 4
        dayView.snp.makeConstraints { (make) in
            make.left.equalTo(timerBox.snp.left).offset(20)
            make.width.equalTo(width)
            make.top.equalTo(timerSwitch.snp.top).offset(40)
            make.bottom.equalTo(timerStartButton.snp.top).offset(-15)
            
        }
        hoursView.snp.makeConstraints { (make) in
            make.left.equalTo(dayView.snp.right)
            make.width.equalTo(width)
            make.top.equalTo(timerSwitch.snp.top).offset(40)
            make.bottom.equalTo(timerStartButton.snp.top).offset(-15)
        }
        minutesView.snp.makeConstraints { (make) in
            make.left.equalTo(hoursView.snp.right)
            make.width.equalTo(width)
            make.top.equalTo(timerSwitch.snp.top).offset(40)
            make.bottom.equalTo(timerStartButton.snp.top).offset(-15)
            
        }
        secondsView.snp.makeConstraints { (make) in
            make.left.equalTo(minutesView.snp.right)
            make.width.equalTo(width)
            make.top.equalTo(timerSwitch.snp.top).offset(40)
            make.bottom.equalTo(timerStartButton.snp.top).offset(-15)
        }
        dayView.addSubview(dayIDLabel)
        dayView.addSubview(dayNumberLabel)
        hoursView.addSubview(hoursIDLabel)
        hoursView.addSubview(hoursNumberLabel)
        minutesView.addSubview(minutesIDLabel)
        minutesView.addSubview(minutesNumberLabel)
        secondsView.addSubview(secondsIDLabel)
        secondsView.addSubview(secondsNumberLabel)
        dayIDLabel.textAlignment = .center
        dayNumberLabel.textAlignment = .center
        hoursIDLabel.textAlignment = .center
        hoursNumberLabel.textAlignment = .center
        minutesIDLabel.textAlignment = .center
        minutesNumberLabel.textAlignment = .center
        secondsIDLabel.textAlignment = .center
        secondsNumberLabel.textAlignment = .center
        
        
        dayIDLabel.text = "Days"
        dayIDLabel.font = UIFont(name: "AvenirNext-Regular", size: 12)
        dayIDLabel.textColor = UIColor.customBlack()
        dayIDLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
            make.centerX.equalToSuperview()
        }
        hoursIDLabel.text = "Hours"
        hoursIDLabel.font = UIFont(name: "AvenirNext-Regular", size: 12)
        hoursIDLabel.textColor = UIColor.customBlack()
        hoursIDLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
            make.centerX.equalToSuperview()
        }
        minutesIDLabel.text = "Minutes"
        minutesIDLabel.font = UIFont(name: "AvenirNext-Regular", size: 12)
        minutesIDLabel.textColor = UIColor.customBlack()
        minutesIDLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
            make.centerX.equalToSuperview()
        }
        secondsIDLabel.text = "Seconds"
        secondsIDLabel.font = UIFont(name: "AvenirNext-Regular", size: 12)
        secondsIDLabel.textColor = UIColor.customBlack()
        secondsIDLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.2)
            make.centerX.equalToSuperview()
        }
        dayNumberLabel.text = "2"
        dayNumberLabel.font = UIFont(name: "AvenirNext-Regular", size: 62)
        dayNumberLabel.textColor = UIColor.customBlack()
        dayNumberLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.centerX.equalToSuperview()
        }
        hoursNumberLabel.text = "6"
        hoursNumberLabel.font = UIFont(name: "AvenirNext-Regular", size: 62)
        hoursNumberLabel.textColor = UIColor.customBlack()
        hoursNumberLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.centerX.equalToSuperview()
        }
        minutesNumberLabel.text = "36"
        minutesNumberLabel.font = UIFont(name: "AvenirNext-Regular", size: 62)
        minutesNumberLabel.textColor = UIColor.customBlack()
        minutesNumberLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.centerX.equalToSuperview()
        }
        secondsNumberLabel.text = "42"
        secondsNumberLabel.font = UIFont(name: "AvenirNext-Regular", size: 62)
        secondsNumberLabel.textColor = UIColor.customBlack()
        secondsNumberLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.centerX.equalToSuperview()
        }
        
        
    }
    
    
    
    
    private func setupMainViews(){
        view.addSubview(timerBox)
        view.addSubview(scheduleBox)
        view.addSubview(lockInBox)
        timerBox.layer.borderColor = UIColor.customBlack().cgColor
        timerBox.layer.borderWidth = 4
        timerBox.backgroundColor = UIColor.customWhite()
        timerBox.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
        }
        
        scheduleBox.layer.borderColor = UIColor.customBlack().cgColor
        scheduleBox.backgroundColor = UIColor.customWhite()
        scheduleBox.layer.borderWidth = 4
        scheduleBox.snp.makeConstraints { (make) in
            make.top.equalTo(timerBox.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
        }
        
        lockInBox.layer.borderColor = UIColor.customBlack().cgColor
        lockInBox.backgroundColor = UIColor.customWhite()
        lockInBox.layer.borderWidth = 4
        lockInBox.snp.makeConstraints { (make) in
            make.top.equalTo(scheduleBox.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
        }
    }
    
    
    
    
}
