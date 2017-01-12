//
//  AuthViewController.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 12/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    @IBOutlet var advancedView: UIView?
    @IBOutlet var advancedButton: UIButton?

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let button = self.advancedButton {
            self.toggleAdvancedOptions(sender: button)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleAdvancedOptions(sender: UIButton) {
        if let view = self.advancedView, let button = self.advancedButton {
            view.isHidden = !view.isHidden
            
            if view.isHidden {
                button.setTitle("Show Advanced", for: .normal)
            } else {
                button.setTitle("Hide Advanced", for: .normal)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
