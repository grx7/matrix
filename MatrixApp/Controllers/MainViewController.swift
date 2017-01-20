//
//  MainViewController.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 18/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

class MainViewController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.navigationBar.setBottomBorderColor(color: UIColor.init(red: 58/255, green: 77/255, blue: 84/255, alpha: 1), height: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAuthScreen() {
        self.performSegue(withIdentifier: "showAuth", sender: self)
    }

}
