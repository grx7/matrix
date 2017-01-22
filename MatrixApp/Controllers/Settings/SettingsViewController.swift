//
//  SettingsViewController.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 22/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func unwindToRooms(_ segue: UIStoryboardSegue) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = AppColors.darkBlue
        self.navigationController?.navigationBar.setBottomBorderColor(color: AppColors.darkBlue, height: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
//        return MatrixAccount.accounts().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "hey")
        
//        let account = MatrixAccount.accounts()[indexPath.row]
//        
//        cell.backgroundColor = UIColor.clear
//        cell.textLabel?.textColor = UIColor.white
//        cell.textLabel?.text = account.userId
//        cell.detailTextLabel?.textColor = UIColor.white
//        cell.detailTextLabel?.text = account.homeServer
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return nil
    }

}
