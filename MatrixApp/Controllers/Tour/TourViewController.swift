//
//  TourViewController.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 17/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

class TourViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var pages = [UIViewController]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(accountAdded), name: Notifications.accountAdded, object: nil)
        
        self.scrollView.isPagingEnabled = true
        self.scrollView.bounces = false
        self.scrollView.delegate = self
        
        self.pages.append((storyboard?.instantiateViewController(withIdentifier: "authPageTour"))!)
        self.pages.append((storyboard?.instantiateViewController(withIdentifier: "authPageTourTwo"))!)
        self.pages.append((storyboard?.instantiateViewController(withIdentifier: "authPageTourThree"))!)
        self.pages.append((storyboard?.instantiateViewController(withIdentifier: "authPageLogin"))!)
        self.pages.append((storyboard?.instantiateViewController(withIdentifier: "authPageRegister"))!)
        
        for (index, viewController) in self.pages.enumerated() {
            self.scrollView.addSubview(viewController.view)
            
            viewController.view.frame.origin.x = (CGFloat(index) * self.view.frame.width)
        }
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width * CGFloat(self.pages.count), height: self.view.frame.height)
    }
    
    func accountAdded() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UIScrollViewDelegate

extension TourViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.endEditing(true)
    }
    
}
