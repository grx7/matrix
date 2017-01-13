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
        
        
    }
    
}
