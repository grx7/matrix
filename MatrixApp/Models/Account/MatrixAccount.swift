//
//  MatrixAccount.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 13/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

import MatrixSDK
import KeychainAccess

class MatrixAccount {

    var credentials: MXCredentials = MXCredentials()
    var session: MXSession = MXSession()
    var restClient: MXRestClient = MXRestClient()
    
    init(loginAndStoreUser username: String, password: String, homeServer: String, identityServer: String) {        
        let parameters: [AnyHashable: Any] = [
            "type": kMXLoginFlowTypePassword,
            "user": username,
            "password": password
        ]
        
        self.restClient = MXRestClient(homeServer: homeServer, andOnUnrecognizedCertificateBlock: nil)
        
        self.restClient.login(parameters, success: { (response) in
            if let accessToken = response?["access_token"] as? String,
                let matrixId = response?["user_id"] as? String,
                let deviceId = response?["device_id"] as? String,
                let homeServer = response?["home_server"] as? String {
                self.storeUser(username: username, accessToken: accessToken, matrixId: matrixId, deviceId: deviceId, homeServer: homeServer, identityServer: identityServer)
            }
        }) { (error) in
        }
        
    }
    
    func storeUser(username: String, accessToken: String, matrixId: String, deviceId: String, homeServer: String, identityServer: String) {
        let keychain = Keychain(service: Constants.service)
        let defaults = UserDefaults.standard
        
        do {
            try keychain.set(accessToken, key: matrixId)
            
            defaults.set([
                "username": username,
                "matrixId": matrixId,
                "deviceId": deviceId,
                "homeServer": homeServer,
                "identityServer": identityServer
            ], forKey: matrixId)
        }
        catch let error {
            print(error)
        }
        
        print("Username: \(username)\nMatrixID: \(matrixId)\nServer: \(homeServer)\nToken: \(accessToken)")
    }
    
}
