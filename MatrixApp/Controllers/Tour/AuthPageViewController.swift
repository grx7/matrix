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
        let page3: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "authPageTourThree")
        let page4: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "authPageLogin")
        let page5: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "authPageRegister")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        pages.append(page4)
        pages.append(page5)
        
        self.setViewControllers([page1], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
    }

}

extension AuthPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func indexOfViewController(viewController: UIViewController) -> Int {
        guard let index = pages.index(of: viewController) else {
            return NSNotFound
        }
        
        return index
    }

    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController: viewController)
        
        if (index == NSNotFound) || (index + 1 == pages.count) {
            return nil
        }
        
        index += 1
        
        return pages[index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController: viewController)
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        
        return pages[index]
    }
    
}
