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

class MatrixAccount: NSObject {

    var credentials: MXCredentials = MXCredentials()
    var session: MXSession = MXSession()
    var restClient: MXRestClient = MXRestClient()
    
    
    init(credentials: MXCredentials) {
        
//        let keychain = Keychain(service: "com.buckle.matrix-token")
//        
//        do {
//            try keychain.set(NSKeyedArchiver.archivedData(withRootObject: parameters), key: "testthisplz")
//        }
//        catch let error {
//            print(error)
//        }
//        
//        print("Here goes login")
//        
//        if let data = try? keychain.getData("testthisplz") {
//            print(NSKeyedUnarchiver.unarchiveObject(with: data!))
//        }
    
        
        //restClinet.login(parameters:
    }
    
    init(loginAndStoreUser username: String, password: String, homeServer: String, identityServer: String) {
        
        let parameters: [AnyHashable: Any] = [
            "type": kMXLoginFlowTypePassword,
            "user": username,
            "password": password
        ]
        
        self.restClient = MXRestClient(homeServer: homeServer, andOnUnrecognizedCertificateBlock: nil)
        
        self.restClient.login(parameters, success: { (response) in
            print("\(response)")
        }) { (error) in
            print("\(error)");
        }
        
    }
    
}
