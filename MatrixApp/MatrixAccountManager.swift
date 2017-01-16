//
//  MatrixAccountManager.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 14/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit
import KeychainAccess
import MatrixSDK

class MatrixAccountManager {

    static let sharedInstance = MatrixAccountManager()
    
    var accounts: [MatrixAccount] = []
    
    private init() {
        self.loadAccounts()
    }
    
    private func loadAccounts() {
        if let data = UserDefaults.standard.object(forKey: Constants.userAccounts) as? [AnyObject] {
            for account in data {
                if let userId = account["matrixId"] as? String,
                    let homeServer = account["homeServer"] as? String,
                    let deviceId = account["deviceId"] as? String,
                    let accessToken = self.tokenFor(userId: userId),
                    let credentials = MXCredentials(homeServer: homeServer, userId: userId, accessToken: accessToken) {
                        credentials.deviceId = deviceId
                
                        self.accounts.append(MatrixAccount(credentials: credentials))
                }
            }
        }
    }
    
    func hasAccounts() -> Bool {
        return (self.accounts.count > 0)
    }
    
    func addAccount(username: String, password: String, homeServer: String, identityServer: String, success: @escaping (() -> ()), failure: ((Error) -> ())) {
        MatrixAccount.authenticateUser(username: username, password: password, homeServer: homeServer, success: { (credentials) in
            if self.storeUser(username: username, accessToken: credentials.accessToken, matrixId: credentials.userId, deviceId: credentials.deviceId, homeServer: credentials.homeServer, identityServer: identityServer) {
                self.loadAccounts()
                success()
            } else {
                print("Could not store!")
            }
            
        }) { (error) in
            // could not authenticate user
            print("\(error)")
        }
    }
    
    func storeUser(username: String, accessToken: String, matrixId: String, deviceId: String, homeServer: String, identityServer: String) -> Bool {
        let keychain = Keychain(service: Constants.service)
        let defaults = UserDefaults.standard
        
        do {
            try keychain.set(accessToken, key: matrixId)
            
            var accounts: [[String: String]] = defaults.object(forKey: Constants.userAccounts) as? [[String: String]] ?? []
            
            accounts.append([
                "username": username,
                "matrixId": matrixId,
                "deviceId": deviceId,
                "homeServer": homeServer,
                "identityServer": identityServer
            ])
            
            defaults.set(accounts, forKey: Constants.userAccounts)
        }
        catch _ {
            return false
        }
        
        return true
    }
    
    func tokenFor(userId: String) -> String? {
        let keychain = Keychain(service: Constants.service)
        
        do {
            let token = try keychain.get(userId)
            
            return token
        } catch _ {
            return nil
        }
    }
    
    func deleteAccount(matrixId: String) {
        // check exists
        // delete access token from keychain
        // delete account from user defaults
        // update AccountManager
        // perform success closure
    }
    
}
