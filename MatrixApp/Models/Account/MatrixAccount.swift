//
//  MatrixAccount.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 13/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

import MatrixSDK

class MatrixAccount: NSObject {

    var credentials: MXCredentials = MXCredentials()
    var session: MXSession = MXSession()
    var restClinet: MXRestClient = MXRestClient()
    
    
    
    init(credentials: MXCredentials) {
        
        let parameters: [AnyHashable: Any] = [
            "userId": "@oliverlumby:matrix.org",
            "password": "1234"
        ]
        
        print("Here goes login")
        
        restClinet.login(parameters, success: { (response) in
            print("\(response)")
        }) { (error) in
            print("\(error)");
        }
        
        //restClinet.login(parameters:
    }
    
}
