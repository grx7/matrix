//
//  InitialViewController.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 12/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("showAuth")
        
        self.showAuthScreen()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
