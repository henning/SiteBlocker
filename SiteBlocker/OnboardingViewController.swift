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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let pages = [OBPageViewController(),PageOne()]
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if finished && completed {
            index += 1
        }
    }

}

class OBPageViewController: UIViewController {
    let mainTextLabel = UILabel()
   let nextButton = UIButton()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.customBlack()
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.textColor = UIColor.customWhite()
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        view.addSubview(mainTextLabel)
        mainTextLabel.snp.makeConstraints { (make) in
//            ma
        }
    }
}

class PageOne: OBPageViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.setTitle("2", for: .normal)
    }
}
