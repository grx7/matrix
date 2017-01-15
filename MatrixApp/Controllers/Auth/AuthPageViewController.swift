//
//  AuthPageViewController.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 15/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

class AuthPageViewController: UIPageViewController {

    var pages = [UIViewController]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        let page1: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "authPageTour")
        let page2: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "authPageTourTwo")
        let page3: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "authPageLogin")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        self.setViewControllers([page1], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
    }

}

extension AuthPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.index(of: viewController)!
        let nextIndex = abs((currentIndex + 1) % pages.count)
        
        if (nextIndex < 1) {
            return nil
        }
            
        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.index(of: viewController)!
        let previousIndex = abs((currentIndex - 1) % pages.count)
        
        if (previousIndex > 0) {
            return nil
        }
        
        return pages[previousIndex]
    }
    
}
