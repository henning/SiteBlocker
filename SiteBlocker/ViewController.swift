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
import Hero


class ViewController: UIViewController {
    
    var addNewTextBox = UITextField()
    var addNewView = UIButton()
    var separatorLine = UIView()
    var tableView = UITableView()
    var disposeBag = DisposeBag()
    var lastDomainsCount = 0
    
    
    
    private func bindTableView() {
        domains.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "Cell")) { _, domain, cell in
                let domainCell = cell as! DomainCell
                domainCell.backgroundColor = self.view.backgroundColor
                domainCell.domain = domain
                
                
            }
            .addDisposableTo(disposeBag)
    }
    
    private func bindAddButtonTap() {
        self.addNewTextBox.rx.controlEvent(UIControlEvents.editingChanged).subscribe { _ in
//            self.addNewTextBox.text = self.addNewTextBox.text?.lowercased()
            }.addDisposableTo(disposeBag)
        
        self.addNewTextBox.rx.controlEvent(UIControlEvents.editingDidEndOnExit).subscribe { _ in
            let d = Domain(simpleAddress: self.addNewTextBox.text!)
//            domains.value.append(d)
//            d.add()
//            self.addNewTextBox.resignFirstResponder()
//            self.addNewTextBox.text = "Add New"
            self.shrinkTextBox()
            }.addDisposableTo(disposeBag)
        self.addNewTextBox.rx.controlEvent(UIControlEvents.editingDidBegin).subscribe{ _ in
            self.expandTextBox()
//            self.addNewTextBox.text = ""
            }.addDisposableTo(disposeBag)
        
    }
    
    
    
    override func viewDidLoad() {
        bindAddButtonTap()
        bindTableView()
        setupViews()
    }
    
    func setupViews(){
        self.view.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 93/255, alpha: 1.0)
//        view.addSubview(tableView)
//        tableView.isHidden = true

        
        //MARK: - Add New View
        view.addSubview(addNewView)
        addNewView.autoresizesSubviews = false
        addNewView.translatesAutoresizingMaskIntoConstraints = false 
        addNewView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left).offset(16)
            make.right.equalTo(view.snp.right).offset(-16)
            make.top.equalTo(view.snp.top).offset(30)
            make.height.equalTo(60)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        //MARK: - Add New Textbox
        addNewTextBox.layer.borderColor = view.backgroundColor?.cgColor
        addNewTextBox.textColor = UIColor(red: 211/255, green: 207/255, blue: 207/255, alpha: 1.0)
        addNewTextBox.font = UIFont(name: "AvenirNext-UltraLight", size: 36)
//        addNewTextBox.text = "Add New"
        addNewTextBox.textAlignment = .left
        addNewView.addSubview(addNewTextBox)
        addNewTextBox.autocorrectionType = .no
        addNewTextBox.autocapitalizationType = .none
        addNewTextBox.snp.makeConstraints { (make) in
            make.top.equalTo(addNewView.snp.top).offset(10)
            make.left.equalTo(addNewView.snp.left).offset(2)
            make.right.equalTo(addNewView.snp.right).offset(-2)
            make.bottom.equalTo(addNewView.snp.bottom).offset(-2)
        }
        
        //MARK: - Separator Line
        view.addSubview(separatorLine)
        separatorLine.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.width.equalTo(addNewView.snp.width)
            make.centerX.equalTo(addNewView.snp.centerX)
            make.top.equalTo(addNewView.snp.bottom).offset(2)
        }
        separatorLine.backgroundColor = addNewTextBox.textColor
        
        //MARK: - Tableview
//        self.tableView.register(DomainCell.self as AnyClass, forCellReuseIdentifier: "Cell")
//        tableView.delegate = self
//        tableView.tableFooterView = UIView()
//        tableView.backgroundColor = view.backgroundColor
//        tableView.separatorColor = view.backgroundColor
//        tableView.allowsSelection = false
//        tableView.snp.makeConstraints({ (make) in
//            make.top.equalTo(separatorLine.snp.bottom).offset(16)
//            make.bottom.equalTo(view.snp.bottom).offset(-16)
//            make.width.equalTo(addNewView.snp.width)
//            make.centerX.equalTo(addNewView.snp.centerX)
//        })
    }
    
    
    private func expandTextBox() {
        self.addNewView.backgroundColor = UIColor.customWhite()
        fadeFromClear()
        for i in 0..<2000{
            let when = DispatchTime.now() + .milliseconds(Int(Double(i)*0.125))
            DispatchQueue.main.asyncAfter(deadline: when) {
                let origFrame = self.addNewView.frame
                let newFrame = CGRect(x: origFrame.minX, y: origFrame.minY, width: origFrame.width, height: origFrame.height + 0.15)
                self.addNewView.frame = newFrame
                self.addNewView.layer.cornerRadius = 12
                
            }
        }
    }
    
    private func shrinkTextBox() {
        self.addNewView.backgroundColor = UIColor.customWhite()
//        fadeFromClear()
//        for i in 0..<2000{
//            let when = DispatchTime.now() + .milliseconds(Int(Double(i)*0.125))
//            DispatchQueue.main.asyncAfter(deadline: when) {
//                let origFrame = self.addNewView.frame
//                let newFrame = CGRect(x: origFrame.minX, y: origFrame.minY, width: origFrame.width, height: origFrame.height + 0.15)
//                self.addNewView.frame = newFrame
//                self.addNewView.layer.cornerRadius = 12
//                
//            }
//        }

    }
    
    private func fadeToClear(){
        
    }
    private func fadeFromClear() {
//        for i in 1..<2000{
//            let when = DispatchTime.now() + .milliseconds(Int(Double(i)*0.125))
//            DispatchQueue.main.asyncAfter(deadline: when) {
//            let float = CGFloat((Double(i)/2000))
//            self.addNewTextBox.backgroundColor = UIColor.customWhite(alpha: float)
//                
//            }
//        }
    }

    
}

extension ViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}
