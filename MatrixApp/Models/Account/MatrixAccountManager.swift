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
                if let userId = account["matrixId"] as? String, let homeServer = account["homeServer"] as? String, let deviceId = account["deviceId"] as? String, let accessToken = self.tokenFor(userId: userId), let credentials = MXCredentials(homeServer: homeServer, userId: userId, accessToken: accessToken) {
                    credentials.deviceId = deviceId
                    
                    self.accounts.append(MatrixAccount(credentials: credentials))
                }
            }
        }
        
        if (UserDefaults.standard.string(forKey: Constants.activeAccount) == nil) && (self.accounts.count > 0) {
            UserDefaults.standard.set(self.accounts.first?.credentials.userId, forKey: Constants.activeAccount)
        }
    }
    
    func hasAccounts() -> Bool {
        return (self.accounts.count > 0)
    }
    
    func getActiveAccount() -> MatrixAccount? {
        self.loadAccounts()
        
        if let activeAccountId = UserDefaults.standard.string(forKey: Constants.activeAccount) {
            return self.accounts.filter({ (account) -> Bool in
                return account.credentials.userId == activeAccountId
            }).first
        }
        
        return nil
    }
    
    func addAccount(username: String, password: String, homeServer: String, identityServer: String, success: @escaping ((MatrixAccount) -> ()), failure: @escaping ((Error) -> ())) {
        MatrixAccount.authenticateUser(username: username, password: password, homeServer: homeServer, success: { (credentials) in
            if let account = self.storeAccount(username: username, accessToken: credentials.accessToken, matrixId: credentials.userId, deviceId: credentials.deviceId, homeServer: credentials.homeServer, identityServer: identityServer) {
                self.loadAccounts()
                
                NotificationCenter.default.post(name: Notifications.accountAdded, object: account)
                
                success(account)
            } else {
                print("Could not store!")
            }
            
        }) { (error) in
            failure(error)
        }
    }
    
    private func storeAccount(username: String, accessToken: String, matrixId: String, deviceId: String, homeServer: String, identityServer: String) -> MatrixAccount? {
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
            defaults.set(matrixId, forKey: Constants.activeAccount)
            
            return MatrixAccount(credentials: MXCredentials(homeServer: homeServer, userId: matrixId, accessToken: accessToken))
        }
        catch _ {
            return nil
        }
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
