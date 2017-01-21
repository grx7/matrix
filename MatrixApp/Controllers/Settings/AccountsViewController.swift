//
//  AccountsViewController.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 18/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

class AccountsViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func unwindToRooms(_ segue: UIStoryboardSegue) {
        self.parent?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension AccountsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: FixME
        return 0
        // return MatrixAccountManager.sharedInstance.accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "hey")

        // TODO: FixME
//        let account = MatrixAccountManager.sharedInstance.accounts[indexPath.row]
//        
//        cell.textLabel?.text = account.credentials.userId
//        cell.detailTextLabel?.text = account.credentials.homeServer
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // TODO: FixME
        //        return [UITableViewRowAction(style: .destructive, title: "Delete", handler: { (action, indexPath) in
//            let account = MatrixAccountManager.sharedInstance.accounts[indexPath.row]
//            
//            MatrixAccountManager.sharedInstance.deleteAccount(account: account, success: { (userId) in
//                print(MatrixAccountManager.sharedInstance.accounts)
//                tableView.reloadData()
//            }, failure: { (error) in
//                print("Error deleting user: \(error)")
//            })
//        })]
        return nil
    }
    
}
