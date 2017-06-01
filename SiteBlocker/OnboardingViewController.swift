//
//  OnboardingViewController.swift
//  SiteBlocker
//
//  Created by Luke Mann on 5/30/17.
//  Copyright © 2017 Luke Mann. All rights reserved.
//

import UIKit

class OnboardingViewController: UIPageViewController,UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var index = 0
    @available(iOS 5.0, *)
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{

        guard let viewControllerIndex = pages.index(of: viewController as! OBPageViewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard pages.count > previousIndex else {
            return nil
        }
        
        return pages[previousIndex]
        
    }
    
    @available(iOS 5.0, *)
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        
        guard let viewControllerIndex = pages.index(of: viewController as! OBPageViewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = pages.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return pages[nextIndex]

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        reloadInputViews()
        setViewControllers([pages[0]], direction: .forward, animated: true, completion: nil)
        // Do any additional setup after loading the view.
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let pages = [PageOne(),PageTwo(),PageThree()]
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if finished && completed {
            index += 1
        }
    }

}

class OBPageViewController: UIViewController {
    let mainTextLabel = UILabel()
   var nextButton = UIButton()
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.customBlack()
        nextButton.titleLabel?.textColor = UIColor.customWhite()
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.frame.height * (3/4))
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        view.addSubview(mainTextLabel)
        mainTextLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top).offset(-10)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        mainTextLabel.font = UIFont(name: "AvenirNext-Regular", size: 20)
        mainTextLabel.adjustsFontSizeToFitWidth = true
        mainTextLabel.textColor = UIColor.white
        mainTextLabel.numberOfLines = 8
        mainTextLabel.textAlignment = .center
        
        nextButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 25)!
        nextButton.setTitleColor(UIColor.customGrey(), for: .normal)

        
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(mainTextLabel.snp.top)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.top.equalToSuperview().offset(50)
        }
        
    }
}



class PageOne: OBPageViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.setTitle("Next", for: .normal)
        mainTextLabel.text = "Welcome to Site Blocker! This is an app desinged for blocking Safari websites."
        imageView.image = #imageLiteral(resourceName: "tempiPhone")
    }
}

class PageTwo:OBPageViewController {
    let notificationsButton = UIButton()
    let contentBlockingButton = UIButton()
    let actualNextButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationsButton.setTitle("Notifications Settings", for: .normal)
        mainTextLabel.text = "To get started, we'll need two things. First, notifactions to alert you when a sessions is done (you need to interact with the notificatin for the session to end). Second, you need to enable this app as a content blocker in Safari."
        contentBlockingButton.setTitle("Content Blocker Settings", for: .normal)
        actualNextButton.setTitle("Next", for: .normal)
        imageView.image = #imageLiteral(resourceName: "tempiPhone")
        view.addSubview(notificationsButton)
        view.addSubview(contentBlockingButton)
        view.addSubview(actualNextButton)
        notificationsButton.snp.makeConstraints { (make) in
            make.top.equalTo(view.frame.height * (3/4))
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(500)
        }
        contentBlockingButton.snp.makeConstraints { (make) in
            make.size.equalTo(notificationsButton.snp.size)
            make.top.equalTo(notificationsButton.snp.bottom)
            make.centerX.equalTo(notificationsButton.snp.centerX)
        }
        actualNextButton.snp.makeConstraints { (make) in
            make.size.equalTo(notificationsButton.snp.size)
            make.top.equalTo(contentBlockingButton.snp.bottom)
            make.centerX.equalTo(notificationsButton.snp.centerX)
        }
        contentBlockingButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 25)!
        actualNextButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 25)!
        notificationsButton.titleLabel?.font = UIFont(name: "AvenirNext-DemiBold", size: 25)!
        notificationsButton.setTitleColor(UIColor.customGrey(), for: .normal)
        contentBlockingButton.setTitleColor(UIColor.customGrey(), for: .normal)
        actualNextButton.setTitleColor(UIColor.customGrey(), for: .normal)



    }
}

class PageThree:OBPageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.setTitle("Lets Go!", for: .normal)
        mainTextLabel.text = "Help! I can't block apps!                                                                         Unfortunately, due to Apple restrictions this is impossible. If you really want to prevent usage of these sites, try using the web version. Not only can you control your usage, but you also get an environment with less distractions."
        imageView.image = #imageLiteral(resourceName: "tempiPhone")
    }
}
