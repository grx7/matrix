//
//  MatrixAccountManager.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 14/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

class MatrixAccountManager {

    static let sharedInstance = MatrixAccountManager()
    
    private init() {
        self.loadAccounts()
    }
    
    private func loadAccounts() {
        // Load user accounts from defaults
        // Parse returned array into array of MatrixAccounts
        UserDefaults.standard.object(forKey: "userAccounts")
    }
    
    func hasAccounts() -> Bool {
        // check self.accounts.count > 0
        return false
    }
    
    func addAccount(username: String, password: String, homeServer: String, identityServer: String) {
        // attempt login
        // retrieve access token
        // store access token in keychain
        // store account in userdefaults
        // update user defaults
        // update AccountManager
        // perform success closure
    }
    
    func deleteAccount(matrixId: String) {
        // check exists
        // delete access token from keychain
        // delete account from user defaults
        // update AccountManager
        // perform success closure
    }
    
}
