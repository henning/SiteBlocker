//
//  LeftViewController.swift
//  SiteBlocker
//
//  Created by Luke Mann on 5/25/17.
//  Copyright © 2017 Luke Mann. All rights reserved.
//

import UIKit
import PaperSwitch
import UserNotifications
import RxSwift
import RxCocoa
import RxKeyboard



class LeftViewController:UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    let timerBox = UIView()
    let scheduleBox = UIView()
    let lockInBox = UIView()
    var timerSwitch = PaperSwitch(view: UIView(), color: UIColor.orange)
    var scheduleSwitch = PaperSwitch(view: UIView(), color: UIColor.orange)
    var lockInSwitch = PaperSwitch(view: UIView(), color: UIColor.purple)
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
    let timerButton = UIButton()
    let disposeBag = DisposeBag()
    let timerPicker = UIPickerView()
    let pickerContainer = UIVisualEffectView(effect: UIBlurEffect())
    let pickerDayLabel = UILabel()
    let pickerDayView = UIView()
    let pickerHoursLabel = UILabel()
    let pickerHoursView = UIView()
    let pickerMinutesView = UIView()
    let pickerMinutesLabel = UILabel()
    let pickerSecondsLabel = UILabel()
    let pickerSecondsView = UIView()
    let pickerTapOffButton = UIButton()
    let scheduleStartTimeButton = UIButton()
    let scheduleEndTimeButton = UIButton()
    let scheduleStartTimePicker = UIPickerView()
    let scheduleEndTimePicker = UIPickerView()
    let scheduleStartTimePickerLabel = UILabel()
    let scheduleEndTimePickerLabel = UILabel()
    var pickerViewsToHide = [UIView]()
    let hours = ["12 A.M.", "1 A.M.", "2 A.M.", "3 A.M.", "4 A.M.", "5 A.M.", "6 A.M.", "7 A.M.", "8 A.M.", "9 A.M.", "10 A.M.", "11 A.M.", "12 P.M.","1 P.M.","2 P.M.","3 P.M.","4 P.M.","5 P.M.","6 P.M.","7 P.M.","8 P.M.","9 P.M.","10 P.M.","11 P.M.",]
    let timerSwitchBind = Variable(false)
    let scheduleSwitchBind = Variable(false)
    let lockInBoxBind = Variable(false)
    let scrollView = UIScrollView()

    
    override func viewDidLoad() {
        timerSwitch = PaperSwitch(view: timerBox, color: UIColor.customGreen())
        scheduleSwitch = PaperSwitch(view: scheduleBox, color: UIColor.customGreen())
        lockInSwitch = PaperSwitch(view: lockInBox, color: UIColor.customGreen())

        if UserDefaults.standard.bool(forKey: "timerSwitch"){
            timerSwitch.setOn(true, animated: false)
        }
        if UserDefaults.standard.bool(forKey: "scheduleSwitch"){
            scheduleSwitch.setOn(true, animated: false)
        }
        if UserDefaults.standard.bool(forKey: "lockInSwitch"){
            lockInSwitch.setOn(true, animated: false)
        }
        
        let stopBlockingAction = UNNotificationAction(
            identifier: "stopBlocking",
            title: "Stop Blocking",
            options: [])
        let startBlockingAction = UNNotificationAction(
            identifier: "startBlocking",
            title: "Start Blocking",
            options: [])
        
        let startBlockingCategory = UNNotificationCategory(
            identifier: "startBlockingCategory",
            actions: [startBlockingAction],
            intentIdentifiers: [],
            options: [])
        
        let endBlockingCategory = UNNotificationCategory(
            identifier: "endBlockingCategory",
            actions: [stopBlockingAction],
            intentIdentifiers: [],
            options: [])

        UNUserNotificationCenter.current().setNotificationCategories([startBlockingCategory,endBlockingCategory])
        
        setupMainViews()
        setupTimerView()
        setupScheduleView()
        setupLockInView()
        bindSwitchs()
        bindSwitches()
    }
    
    
    
    private func bindSwitchs() {
        timerSwitch.rx.isOn.subscribe{ _ in
            if self.timerSwitch.isOn {
                
            }
            }.addDisposableTo(disposeBag)
        timerButton.rx.tap.subscribe{ _ in
            self.timerPicker.dataSource = self
            self.timerPicker.delegate = self
            self.showPickerView(picker: self.timerPicker, labels: [self.pickerDayLabel,self.pickerHoursLabel,self.pickerMinutesLabel,self.pickerSecondsLabel])
            }.addDisposableTo(disposeBag)
        
        pickerTapOffButton.rx.tap.subscribe{ _ in
            self.hidePickerView(picker: self.timerPicker, labels: [self.pickerDayLabel,self.pickerHoursLabel,self.pickerMinutesLabel,self.pickerSecondsLabel])
            
            
            }.addDisposableTo(disposeBag)
        
        scheduleStartTimeButton.rx.tap.subscribe{ _ in
            self.scheduleStartTimePicker.delegate = self
            self.scheduleStartTimePicker.dataSource = self
            self.showPickerView(picker: self.scheduleStartTimePicker, labels: [self.scheduleStartTimePickerLabel])
            }.addDisposableTo(disposeBag)
        
        
        scheduleEndTimeButton.rx.tap.subscribe{ _ in
            self.scheduleEndTimePicker.delegate = self
            self.scheduleEndTimePicker.dataSource = self
            
            self.showPickerView(picker: self.scheduleEndTimePicker, labels: [self.scheduleEndTimePickerLabel])
            }.addDisposableTo(disposeBag)
        
        
        timerStartButton.rx.tap.subscribe { _ in
            let seconds = Int(self.dayNumberLabel.text!)! * 86400 +
                Int(self.hoursNumberLabel.text!)! * 3600 +
                Int(self.minutesNumberLabel.text!)! * 60 +
                Int(self.secondsNumberLabel.text!)!
            
            self.triggerNotifications(seconds: seconds)
            }.addDisposableTo(disposeBag)
        
        scheduleButton.rx.tap.subscribe { _ in
            let startPM = self.scheduleStartNumberLabel.text?.contains("P.M.")
            let endPM = self.scheduleEndNumberLabel.text?.contains("P.M.")

            var end = Int(
                (self.scheduleEndNumberLabel.text?.replacingOccurrences(of: " A.M.", with: "").replacingOccurrences(of: " P.M.", with: ""))!
            )
            if endPM! {
                if end != 12{
                end! += 12
                }
            }
            else {
                if end == 12 {
                    end = 0
                }
            }
            var start = Int(
                (self.scheduleStartNumberLabel.text?.replacingOccurrences(of: " A.M.", with: "").replacingOccurrences(of: " P.M.", with: ""))!
            )
            if startPM! {
                if start != 12{
                    start! += 12
                }
            }
            else {
                if start == 12 {
                    start = 0
                }
            }
            self.scheduleNotification(start: start!, end: end!)
        
        }.addDisposableTo(disposeBag)
        RxKeyboard.instance.frame
            .drive(onNext: { frame in
                self.view.frame = CGRect(x: self.view.frame.minX, y: self.view.frame.minY-frame.height, width: self.view.frame.width, height: self.view.frame.height)
            })
            .disposed(by: disposeBag)
        lockInTextBox.rx.controlEvent(.editingDidEndOnExit).subscribe { _ in
            Domain.switchOnLockIn(site: self.lockInTextBox.text!)
        }.addDisposableTo(disposeBag)
        lockInButton.rx.tap.subscribe{ _ in
            self.lockInTextBox.resignFirstResponder()
            Domain.switchOnLockIn(site: self.lockInTextBox.text!)
        }.addDisposableTo(disposeBag)
    }
    
    private func bindSwitches() {
        
        timerSwitch.rx.isOn.bind(to: timerSwitchBind).addDisposableTo(disposeBag)
        scheduleSwitch.rx.isOn.bind(to: scheduleSwitchBind).addDisposableTo(disposeBag)
        lockInSwitch.rx.isOn.bind(to: lockInBoxBind).addDisposableTo(disposeBag)

        
        timerSwitchBind.asObservable().subscribe { isOn in
            if isOn.element! {
                UserDefaults.standard.set(true, forKey: "timerSwitch")
                Domain.switchToOff()
                self.timerStartButton.isEnabled = true
                self.timerButton.isEnabled = true
                self.scheduleSwitchBind.value = false
                self.lockInBoxBind.value = false
            }
            else {
                UserDefaults.standard.set(false, forKey: "timerSwitch")
                self.timerSwitch.setOn(false, animated: true)
                self.timerStartButton.isEnabled = false
                self.timerButton.isEnabled = false
            }
        }.addDisposableTo(disposeBag)
        scheduleSwitchBind.asObservable().subscribe { isOn in
            if isOn.element! {
                UserDefaults.standard.set(true, forKey: "scheduleSwitch")
                Domain.switchToOff()
                self.scheduleButton.isEnabled = true
                self.scheduleStartTimeButton.isEnabled = true
                self.scheduleEndTimeButton.isEnabled = true
                self.timerSwitchBind.value = false
                self.lockInBoxBind.value = false
            }
            else {
                UserDefaults.standard.set(false, forKey: "scheduleSwitch")
                self.scheduleSwitch.setOn(false, animated: true)
                self.scheduleButton.isEnabled = false
                self.scheduleStartTimeButton.isEnabled = false
                self.scheduleEndTimeButton.isEnabled = false
            }
        }.addDisposableTo(disposeBag)
        lockInBoxBind.asObservable().subscribe { isOn in
            Domain.switchToOff()
            if isOn.element! {
                UserDefaults.standard.set(true, forKey: "lockInSwitch")
                self.lockInButton.isEnabled = true
                self.lockInTextBox.isEnabled = true
                self.scheduleSwitchBind.value = false
                self.timerSwitchBind.value = false
            }
            else {
                UserDefaults.standard.set(false, forKey: "lockInSwitch")
                Domain.switchToOff()
                self.lockInSwitch.setOn(false, animated: true)
                self.lockInButton.isEnabled = false
                self.lockInTextBox.isEnabled = false
            }
        }.addDisposableTo(disposeBag)
    }
    
    
    
    private func scheduleNotification (start: Int, end: Int){
        Domain.switchToOff()

        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        
        if (start<end && start <= hour && hour < end) || (start>end && start >= hour && hour<end) {
            Domain.switchToOn()

        }
        
       
        
        let center = UNUserNotificationCenter.current()
        
        center.removeAllPendingNotificationRequests()
        let startContent = UNMutableNotificationContent()
        startContent.title = "Time to start blocking!"
        startContent.body = "To block sites, either tap the notification or the notification button"
        startContent.categoryIdentifier = "startBlockingCategory"
        startContent.sound = UNNotificationSound.default()
        
        var dateComponents = DateComponents()
        dateComponents.hour = start
        dateComponents.minute = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: "scheduledStart", content: startContent, trigger: trigger)
        center.delegate = self
        center.add(request)
        
        
        
        let endContent = UNMutableNotificationContent()
        endContent.title = "Blocking time is over!"
        endContent.body = "To unblock sites, either tap the notification or the notification button"
        endContent.categoryIdentifier = "endBlockingCategory"
        endContent.sound = UNNotificationSound.default()
        
        var dateComponentsEnd = DateComponents()
        dateComponentsEnd.hour = end
        dateComponentsEnd.minute = 0
        let endTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponentsEnd, repeats: true)
        let endRequest = UNNotificationRequest(identifier: "scheduledEnd", content: endContent, trigger: endTrigger)
        center.add(endRequest)

    }
    
    private func triggerNotifications(seconds: Int){
        if UserDefaults.standard.bool(forKey: "grantedPNP"){
            let center = UNUserNotificationCenter.current()
            let options: UNAuthorizationOptions = [.alert, .sound];
            
            let content = UNMutableNotificationContent()
            content.title = "Timer Done"
            content.body = "To unblock sites, either tap the notification or the notification button"
            content.sound = UNNotificationSound.default()
            content.categoryIdentifier = "stopBlocking"
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds),
                                                            repeats: false)
            let identifier = "TimerLocalNotification"
            let request = UNNotificationRequest(identifier: identifier,
                                                content: content, trigger: trigger)
            center.delegate = self
            center.add(request, withCompletionHandler: { (error) in
                if let error = error {
                    // Something went wrong
                }
                else {
                    Domain.switchToOn()
                }
            })
            
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert]) { (granted, error) in
            if granted {
                UserDefaults.standard.set(true, forKey: "grantedPNP")
            }
            else {
                UserDefaults.standard.set(false, forKey: "grantedPNP")
            }
        }
    }
    
    
    
    //MARK:- Timer Picker Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        if pickerView == scheduleStartTimePicker{
            return 1
        }
        if pickerView == scheduleEndTimePicker{
            return 1
        }
        return 4
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == timerPicker {
            switch component {
            case 0:
                return 7
            case 1:
                return 24
            case 2:
                return 60
            default:
                return 60
            }
        }
        if pickerView == scheduleStartTimePicker{
            return 24
            
        }
        if pickerView == scheduleEndTimePicker{
            return 24
            
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == timerPicker {
            
            return "\(row)"
        }
        if pickerView == scheduleStartTimePicker{
            return hours[row]
            
            
        }
        if pickerView == scheduleEndTimePicker{
            return hours[row]
            
        }
        return "error"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == timerPicker {
            
            switch component {
            case 0:
                dayNumberLabel.text = "\(row)"
            case 1:
                hoursNumberLabel.text = "\(row)"
            case 2:
                minutesNumberLabel.text = "\(row)"
            case 3:
                secondsNumberLabel.text = "\(row)"
            default:
                break
            }
        }
        if pickerView == scheduleStartTimePicker{
            scheduleStartNumberLabel.text = hours[row]
            
        }
        if pickerView == scheduleEndTimePicker{
            scheduleEndNumberLabel.text = hours[row]
            
        }
    }
    
    private func startNotifications() {
        if UserDefaults.standard.bool(forKey: "grantedPNP"){
            
        }
    }
    
    
    
    
    
    
    private func setupLockInView() {
        lockInBox.addSubview(lockInButton)
        lockInButton.layer.cornerRadius = 12
        lockInButton.backgroundColor = UIColor.customLightBlue()
        lockInButton.setTitle("Start", for: .normal)
        lockInButton.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 22)
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
        scheduleButton.backgroundColor = UIColor.customLightBlue()
        scheduleButton.setTitle("Start", for: .normal)
        scheduleButton.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 22)
        scheduleButton.setTitleColor(UIColor.customWhite(), for: .normal)
        scheduleButton.setTitleColor(UIColor.customLightBlue(), for: .selected)
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
        scheduleStartNumberLabel.text = "12 A.M."
        scheduleEndNumberLabel.text = "12 A.M."
        scheduleEndIDLabel.text = "End"
        scheduleStartIDLabel.textColor = UIColor.customBlack()
        scheduleStartNumberLabel.textColor = UIColor.customBlack()
        scheduleEndNumberLabel.textColor = UIColor.customBlack()
        scheduleEndIDLabel.textColor = UIColor.customBlack()
        
        
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
        scheduleStartView.addSubview(scheduleStartTimeButton)
        scheduleStartTimeButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
        }
        scheduleEndView.addSubview(scheduleEndTimeButton)
        scheduleEndTimeButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        pickerContainer.addSubview(scheduleStartTimePicker)
        scheduleStartTimePicker.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        pickerContainer.addSubview(scheduleEndTimePicker)
        scheduleEndTimePicker.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        pickerContainer.addSubview(scheduleEndTimePickerLabel)
        pickerContainer.addSubview(scheduleStartTimePickerLabel)
        
        scheduleEndTimePickerLabel.text = "Daily time for End Timer notification"
        scheduleStartTimePickerLabel.text = "Daily time for Start Timer notification"
        scheduleEndTimePickerLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        scheduleStartTimePickerLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 14)
        scheduleEndTimePickerLabel.textAlignment = .center
        scheduleStartTimePickerLabel.textAlignment = .center
        scheduleEndTimePickerLabel.textColor = UIColor.customBlack()
        scheduleStartTimePickerLabel.textColor = UIColor.customBlack()
        
        pickerViewsToHide.append(scheduleEndTimePickerLabel)
        pickerViewsToHide.append(scheduleStartTimePickerLabel)
        pickerViewsToHide.append(scheduleEndTimePicker)
        pickerViewsToHide.append(scheduleStartTimePicker)
        
        
        scheduleStartTimePickerLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalTo(scheduleStartTimePicker.snp.top)
            make.width.equalTo(pickerContainer.snp.width).multipliedBy(0.8)
        }
        scheduleEndTimePickerLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.bottom.equalTo(scheduleEndTimePicker.snp.top)
            make.width.equalTo(pickerContainer.snp.width).multipliedBy(0.8)
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
        timerSwitch.snp.makeConstraints { (make) in
            make.top.equalTo(timerLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        
        timerBox.addSubview(timerStartButton)
        timerStartButton.layer.cornerRadius = 12
        timerStartButton.backgroundColor = UIColor.customLightBlue()
        timerStartButton.setTitle("Start", for: .normal)
        timerStartButton.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 22)
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
        dayNumberLabel.text = "0"
        dayNumberLabel.font = UIFont(name: "AvenirNext-Regular", size: 62)
        dayNumberLabel.textColor = UIColor.customBlack()
        dayNumberLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.centerX.equalToSuperview()
        }
        hoursNumberLabel.text = "0"
        hoursNumberLabel.font = UIFont(name: "AvenirNext-Regular", size: 62)
        hoursNumberLabel.textColor = UIColor.customBlack()
        hoursNumberLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.centerX.equalToSuperview()
        }
        minutesNumberLabel.text = "0"
        minutesNumberLabel.font = UIFont(name: "AvenirNext-Regular", size: 62)
        minutesNumberLabel.textColor = UIColor.customBlack()
        minutesNumberLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.centerX.equalToSuperview()
        }
        secondsNumberLabel.text = "0"
        secondsNumberLabel.font = UIFont(name: "AvenirNext-Regular", size: 62)
        secondsNumberLabel.textColor = UIColor.customBlack()
        secondsNumberLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.centerX.equalToSuperview()
        }
        
        
        //MARK: - HERE!!!!
        timerBox.addSubview(timerButton)
        timerButton.snp.makeConstraints { (make) in
            make.top.equalTo(hoursView.snp.top)
            make.bottom.equalTo(hoursView.snp.bottom)
            make.left.equalTo(dayView.snp.left)
            make.right.equalTo(secondsView.snp.right)
        }
        view.addSubview(pickerContainer)
        pickerContainer.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(view.snp.bottom)
            make.height.equalTo(lockInBox.snp.height)
        }
        pickerContainer.addSubview(timerPicker)
        timerPicker.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        pickerContainer.addSubview(pickerDayLabel)
        pickerContainer.addSubview(pickerHoursLabel)
        pickerContainer.addSubview(pickerMinutesLabel)
        pickerContainer.addSubview(pickerSecondsLabel)
        
        pickerDayLabel.text = "Days"
        pickerHoursLabel.text = "Hours"
        pickerMinutesLabel.text = "Minutes"
        pickerSecondsLabel.text = "Seconds"
        pickerDayLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        pickerHoursLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        pickerMinutesLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        pickerSecondsLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 12)
        pickerDayLabel.textAlignment = .center
        pickerHoursLabel.textAlignment = .center
        pickerMinutesLabel.textAlignment = .center
        pickerSecondsLabel.textAlignment = .center
        
        pickerDayLabel.textColor = UIColor.customBlack()
        pickerHoursLabel.textColor = UIColor.customBlack()
        pickerMinutesLabel.textColor = UIColor.customBlack()
        pickerSecondsLabel.textColor = UIColor.customBlack()
        
        pickerDayLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(2)
            make.left.equalToSuperview()
            make.bottom.equalTo(timerPicker.snp.top)
            make.width.equalTo(pickerContainer.snp.width).dividedBy(4)
        }
        pickerHoursLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(pickerDayLabel.snp.right)
            make.bottom.equalTo(timerPicker.snp.top)
            make.width.equalTo(pickerContainer.snp.width).dividedBy(4)
        }
        pickerMinutesLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(pickerHoursLabel.snp.right)
            make.bottom.equalTo(timerPicker.snp.top)
            make.width.equalTo(pickerContainer.snp.width).dividedBy(4)
        }
        pickerSecondsLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(timerPicker.snp.top)
            make.width.equalTo(pickerContainer.snp.width).dividedBy(4)
        }
        view.addSubview(pickerTapOffButton)
        pickerTapOffButton.backgroundColor = UIColor.clear
        pickerTapOffButton.isEnabled = false
        pickerTapOffButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalTo(lockInBox.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        pickerViewsToHide.append(pickerMinutesLabel)
        pickerViewsToHide.append(pickerDayLabel)
        pickerViewsToHide.append(pickerSecondsLabel)
        pickerViewsToHide.append(pickerHoursLabel)
        pickerViewsToHide.append(timerPicker)
        
        
    }
    
    private func showPickerView(picker: UIPickerView, labels: [UILabel]?) {
        pickerViewsToHide.map {$0.isHidden = true}
        if let labels = labels {
            labels.map{$0.isHidden = false}
        }
        picker.isHidden = false
        pickerTapOffButton.isEnabled = true
        UIView.animate(withDuration: 0.2, animations: {
            self.pickerContainer.frame = CGRect(x: self.pickerContainer.frame.minX,
                                                y: self.view.frame.height-self.pickerContainer.frame.height,
                                                width: self.pickerContainer.frame.width,
                                                height: self.pickerContainer.frame.height)
            
        })
        
    }
    private func hidePickerView(picker: UIPickerView, labels: [UILabel]?){
        pickerTapOffButton.isEnabled = false
        
        UIView.animate(withDuration: 0.4, animations: {
            self.pickerContainer.frame = CGRect(x: self.pickerContainer.frame.minX,
                                                y: self.view.frame.height,
                                                width: self.pickerContainer.frame.width,
                                                height: self.pickerContainer.frame.height)
            
        }) { (done) in
            if done {
                self.pickerViewsToHide.map {$0.isHidden = true}
            }
        }
        
    }
    
    
    
    
    private func setupMainViews(){
        view.addSubview(timerBox)
        view.addSubview(scheduleBox)
        view.addSubview(lockInBox)
        
        timerBox.layer.borderColor = UIColor.customBlack().cgColor
        timerBox.layer.borderWidth = 1
//        timerBox.backgroundColor = UIColor.customWhite()
        timerBox.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
        }
        
        scheduleBox.layer.borderColor = UIColor.customBlack().cgColor
//        scheduleBox.backgroundColor = UIColor.customWhite()
        scheduleBox.layer.borderWidth = 1
        scheduleBox.snp.makeConstraints { (make) in
            make.top.equalTo(timerBox.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
        }
        
        lockInBox.layer.borderColor = UIColor.customBlack().cgColor
//        lockInBox.backgroundColor = UIColor.customWhite()
        lockInBox.layer.borderWidth = 1
        lockInBox.snp.makeConstraints { (make) in
            make.top.equalTo(scheduleBox.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
        }
        
    }
    
    
}

extension LeftViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent: UNNotification,
                                withCompletionHandler: @escaping (UNNotificationPresentationOptions)->()) {
        if willPresent.request.content.categoryIdentifier == "startBlockingCategory"{
        Domain.switchToOn()
        }
        else {
            Domain.switchToOff()
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void){
        if response.notification.request.content.categoryIdentifier == "startBlockingCategory"{
            Domain.switchToOn()
        }
        else {
            Domain.switchToOff()
        }
    }
}



