//
//  MainViewController.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 18/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

class MainViewController: UINavigationController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if MatrixAccount.accounts().isEmpty {
            self.showAuthScreen()
        }

        self.navigationBar.barTintColor = AppColors.darkBlue
        self.navigationBar.setBottomBorderColor(color: AppColors.darkBlue, height: 1)
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
