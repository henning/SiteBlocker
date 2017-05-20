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


class ViewController: UIViewController {

    var addNewTextBox = UITextField()
    var addNeButton = UIButton()
    var separatorLine = UIView()
    var tableView = UITableView()
    var disposeBag = DisposeBag()
    var lastDomainsCount = 0
    
    override func viewDidLoad() {
        self.tableView.register(DomainCell.self as AnyClass, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        bindAddButtonTap()
        bindTableView()
        self.view.backgroundColor = UIColor(red: 52/255, green: 73/255, blue: 93/255, alpha: 1.0)
    }
    
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
//            self.expandText()
        }.addDisposableTo(disposeBag)

        self.addNewTextBox.rx.controlEvent(UIControlEvents.editingDidEndOnExit).subscribe { _ in
            let d = Domain(simpleAddress: self.addNewTextBox.text!)
            domains.value.append(d)
            d.add()
            self.addNewTextBox.resignFirstResponder()
            }.addDisposableTo(disposeBag)

    }
    

    
    override func viewWillLayoutSubviews() {
        view.addSubview(addNewTextBox)
        addNewTextBox.layer.borderColor = view.backgroundColor?.cgColor
        addNewTextBox.textColor = UIColor(red: 211/255, green: 207/255, blue: 207/255, alpha: 1.0)
        addNewTextBox.font = UIFont(name: "AvenirNext-UltraLight", size: 36)
        addNewTextBox.text = "Add New"
        addNewTextBox.textAlignment = .left
        addNewTextBox.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp.left).offset(16)
            make.right.equalTo(view.snp.right).offset(-16)
            make.top.equalTo(view.snp.top).offset(40)
            make.height.equalTo(50)
            make.centerX.equalTo(view.snp.centerX)
}
        
        view.addSubview(separatorLine)
        separatorLine.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.width.equalTo(addNewTextBox.snp.width)
            make.centerX.equalTo(addNewTextBox.snp.centerX)
            make.top.equalTo(addNewTextBox.snp.bottom).offset(10)
        }
        separatorLine.backgroundColor = addNewTextBox.textColor
        
        view.addSubview(tableView)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = view.backgroundColor
        tableView.separatorColor = view.backgroundColor
        tableView.allowsSelection = false
        tableView.snp.makeConstraints({ (make) in
            make.top.equalTo(separatorLine.snp.bottom).offset(16)
            make.bottom.equalTo(view.snp.bottom).offset(-16)
            make.width.equalTo(addNewTextBox.snp.width)
            make.centerX.equalTo(addNewTextBox.snp.centerX)

        })
    }

//    func

}

extension ViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
}
