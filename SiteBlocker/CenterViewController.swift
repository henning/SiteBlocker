//
//  ViewController.swift
//  SiteBlocker
//
//  Created by Luke Mann on 5/17/17.
//  Copyright © 2017 Luke Mann. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa


class CenterViewController: UIViewController {
    
    var addNewTextBox = UITextField()
    var addNewView = UIView()
    var separatorLine = UIView()
    var mainTableView = UITableView()
    var addNewTableView = UITableView()
    var addNewLabel = UILabel()
    var disposeBag = DisposeBag()
    var errorMessage = UILabel()
    let backgroundButton = UIButton()
    var connectedIndicatorLabel = UILabel()
    var expanded = false
    var contracted = true
    
    
    
    
    //MARK:- Bindings
    private func bindTableView() {
        domains.asObservable()
            .bind(to: mainTableView.rx.items(cellIdentifier: "Cell")) { _, domain, cell in
                let domainCell = cell as! DomainCell
                domainCell.backgroundColor = self.view.backgroundColor
                domainCell.domain = domain
                
            }.addDisposableTo(disposeBag)
        suggestionsToLoad.asObservable()
            .bind(to: addNewTableView.rx.items(cellIdentifier: "SuggestionCell")) { _, suggestion, cell in
                let suggestionCell = cell as! SuggestionCell
                suggestionCell.backgroundColor = self.addNewView.backgroundColor
                suggestionCell.suggestion = suggestion
                cell.clipsToBounds = true
                suggestionCell.vc = self
            }.addDisposableTo(disposeBag)
        
        
    }
    
    private func bindAddButtonTap() {
        self.addNewTextBox.rx.controlEvent(UIControlEvents.editingChanged).subscribe { _ in
            }.addDisposableTo(disposeBag)
        
        
        self.addNewTextBox.rx.controlEvent(UIControlEvents.editingDidBegin).subscribe{ _ in
            self.expandTextBox()
            self.addNewTextBox.text = nil
            }.addDisposableTo(disposeBag)
        
        self.backgroundButton.rx.tap.subscribe{ _ in
            self.shrinkTextBox()
        }
    }
    
    private func bindIndicator() {
        UserDefaults(suiteName: "group.com.lukejmann.foo")!.rx.observe(Bool.self, "loadEmpty").subscribe{ bool in
            self.reloadIndicator()
            }.addDisposableTo(disposeBag)
    }
    
    private func reloadIndicator() {
        let userDefaults = UserDefaults(suiteName: "group.com.lukejmann.foo")
        let loadEmpty = userDefaults?.bool(forKey: "loadEmpty")
        if loadEmpty! {
            connectedIndicatorLabel.backgroundColor = UIColor.customOrange()
            connectedIndicatorLabel.text = "Sites not blocked"
        }
        else {
            connectedIndicatorLabel.backgroundColor = UIColor.customGreen()
            connectedIndicatorLabel.text = "Sites currently blocked"
        }
    }
    
    //MARK:- Beginning views
    override func viewDidLoad() {
        bindAddButtonTap()
        bindTableView()
        bindIndicator()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if !UserDefaults.standard.bool(forKey: "hasLoaded"){
            present(OnboardingViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil), animated: true, completion: nil)
            
        }

        
    }
    
    func setupViews(){
        
        
        self.view.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 93/255, alpha: 1.0)
        view.addSubview(backgroundButton)
        view.addSubview(mainTableView)
        view.addSubview(addNewView)
        addNewView.addSubview(addNewTextBox)
        addNewView.addSubview(addNewLabel)
        addNewView.addSubview(addNewTableView)
        addNewTextBox.delegate = self
        
        
        //MARK: - Add New View
        addNewView.autoresizesSubviews = false
        addNewView.translatesAutoresizingMaskIntoConstraints = false
                        self.addNewView.layer.cornerRadius = 12

        addNewView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left).offset(16)
            make.right.equalTo(view.snp.right).offset(-16)
            make.top.equalTo(view.snp.top).offset(40)
            make.height.equalTo(60)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        //MARK: - Add New Textbox
        addNewTextBox.layer.borderColor = view.backgroundColor?.cgColor
        addNewTextBox.textColor = UIColor.customBlack()
        addNewTextBox.font = UIFont(name: "AvenirNext-UltraLight", size: 36)
        addNewTextBox.textAlignment = .left
        addNewTextBox.text = nil
        addNewTextBox.autocorrectionType = .no
        addNewTextBox.autocapitalizationType = .none
        addNewTextBox.snp.makeConstraints { (make) in
            make.top.equalTo(addNewView.snp.top).offset(10)
            make.left.equalTo(addNewView.snp.left).offset(2)
            make.right.equalTo(addNewView.snp.right).offset(-2)
            make.bottom.equalTo(addNewView.snp.bottom).offset(-2)
        }
        addNewLabel.layer.borderColor = view.backgroundColor?.cgColor
        addNewLabel.textColor = UIColor(red: 211/255, green: 207/255, blue: 207/255, alpha: 1.0)
        addNewLabel.font = UIFont(name: "AvenirNext-UltraLight", size: 36)
        addNewLabel.textAlignment = .left
        addNewLabel.text = "Add New"
        addNewLabel.snp.makeConstraints { (make) in
            make.size.equalTo(addNewTextBox.snp.size)
            make.left.equalTo(addNewTextBox.snp.left)
            make.top.equalTo(addNewTextBox.snp.top)
            
        }
        
        
        
        //MARK: - Separator Line
        view.addSubview(separatorLine)
        separatorLine.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.width.equalTo(addNewView.snp.width)
            make.centerX.equalTo(addNewView.snp.centerX)
            make.top.equalTo(addNewView.snp.bottom).offset(2)
        }
        separatorLine.backgroundColor = UIColor.customWhite(alpha: 0.8)
        
        //MARK: - Tableview
        self.mainTableView.register(DomainCell.self as AnyClass, forCellReuseIdentifier: "Cell")
        mainTableView.delegate = self
        mainTableView.tableFooterView = UIView()
        mainTableView.backgroundColor = view.backgroundColor
        mainTableView.separatorColor = view.backgroundColor
        mainTableView.allowsSelection = false
        mainTableView.snp.makeConstraints({ (make) in
            make.top.equalTo(separatorLine.snp.bottom).offset(16)
            make.bottom.equalTo(view.snp.bottom).offset(-16)
            make.width.equalTo(addNewView.snp.width)
            make.centerX.equalTo(addNewView.snp.centerX)
        })
        
        // MARK: - Suggestion TableView
        self.addNewTableView.register(SuggestionCell.self as AnyClass, forCellReuseIdentifier: "SuggestionCell")
        addNewTableView.delegate = self
        addNewTableView.tableFooterView = UIView()
        addNewTableView.backgroundColor = addNewView.backgroundColor
        addNewTableView.separatorColor = addNewView.backgroundColor
        addNewTableView.allowsSelection = false
        addNewTableView.snp.makeConstraints({ (make) in
            make.top.equalTo(addNewView.snp.top).offset(60 + 10)
            make.height.equalTo(350)
            make.left.equalTo(addNewView.snp.left).offset(4)
            make.right.equalTo(addNewView.snp.right).offset(-4)
        })
        addNewTableView.clipsToBounds = true
        addNewView.clipsToBounds = true
        
        //MARK:- Error Message
        view.addSubview(errorMessage)
        errorMessage.textColor = UIColor.customWhite()
        errorMessage.font = UIFont(name: "AvenirNext-DemiBold", size: 9)
        errorMessage.text = "Make sure the address is in the following format: \"domain.com(or .org, etc.)\""
        errorMessage.alpha = 0
        errorMessage.snp.makeConstraints { (make) in
            make.bottom.equalTo(addNewView.snp.top).offset(4)
            make.height.equalTo(22)
            make.left.equalTo(addNewView.snp.left).offset(12)
            make.right.equalTo(addNewView.snp.right).offset(-12)
        }
        
        //MARK:- background button
        backgroundButton.setTitle("", for: .normal)
        backgroundButton.isEnabled = false
        backgroundButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
            
        }
        
        view.bringSubview(toFront: backgroundButton)
        view.bringSubview(toFront: addNewView)
        
        view.addSubview(connectedIndicatorLabel)
        
        connectedIndicatorLabel.text = "Blocker Connected"
        connectedIndicatorLabel.textAlignment = .center
        connectedIndicatorLabel.textColor = UIColor.customWhite()
        connectedIndicatorLabel.backgroundColor = UIColor.customGreen()
        connectedIndicatorLabel.font = UIFont(name: "AvenirNext-Regular", size: 14)
        
        connectedIndicatorLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(20)
        }
        
    }
    
    
    //MARK:- Show/hide animations
    private func expandTextBox() {

        backgroundButton.isEnabled = true
        UIView.animate(withDuration: 0.5, animations: {
            self.addNewView.frame = CGRect(x: self.addNewView.frame.minX,
                                           y: self.addNewView.frame.minY,
                                           width: self.addNewView.frame.width,
                                           height: 350)
                            self.addNewView.backgroundColor = UIColor.customWhite(alpha: 1.0)
                            self.addNewLabel.alpha = 0

        }) { (done) in
            if done {
                self.expanded = true
            }
        }
        
    }
    
    func shrinkTextBox() {
            backgroundButton.isEnabled = false
            hideErrorMessage()

        UIView.animate(withDuration: 0.3, animations: {
            self.addNewView.frame = CGRect(x: self.addNewView.frame.minX,
                                           y: self.addNewView.frame.minY,
                                           width: self.addNewView.frame.width,
                                           height: 60)
            self.addNewView.backgroundColor = UIColor.customWhite(alpha: 0)
            self.addNewLabel.alpha = 1.0
            self.addNewTextBox.resignFirstResponder()
            self.addNewTextBox.text = nil
            
        }) { (done) in
            if done {

                                        self.contracted = true
            }
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if CenterViewController.correctFormat(string: self.addNewTextBox.text!){
            let d = Domain(simpleAddress: self.addNewTextBox.text!)
            domains.value.append(d)
            d.add()
            shrinkTextBox()
        }
        else {
            showErrorMessage()
        }
        return false
    }
    
    static func correctFormat(string:String)->Bool{
        let s = "abcdefghijklmnopqrstuvwkyzABCDEFGHIJKLMNOPQRSTUVWXYZ."
        let characterSet = CharacterSet(charactersIn: s).inverted
        let words = string.components(separatedBy: characterSet)
        if words.count > 1 || words[0] == "" || !words[0].contains("."){
            return false
        }
        return true
        
    }
    
    private func showErrorMessage(){
        UIView.animate(withDuration: 0.5) {
            self.errorMessage.alpha = 1.0
        }
    }
    
    private func hideErrorMessage(){
        UIView.animate(withDuration: 0.5) {
            self.errorMessage.alpha = 0
        }
    }
    
    private func checkStatus() {
        print("Expanded: \(expanded)")
        print("Contracted: \(contracted)")
        print("")
        print("")
        print("")
        print("")

    }
    
    
    
}


//MARK: - Table Cell Height
extension CenterViewController:UITableViewDelegate,UITextFieldDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}


