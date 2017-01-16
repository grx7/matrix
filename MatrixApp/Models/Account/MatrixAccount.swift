//
//  MatrixAccount.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 13/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit
import MatrixSDK

class MatrixAccount {

    var credentials: MXCredentials = MXCredentials()
    var restClient: MXRestClient = MXRestClient()
    var session: MXSession = MXSession()
    
    init(credentials: MXCredentials) {
        self.credentials = credentials
        self.restClient = MXRestClient(credentials: self.credentials, andOnUnrecognizedCertificateBlock: nil)
        self.session = MXSession(matrixRestClient: restClient)
    }
    
    static func authenticateUser(username: String, password: String, homeServer: String, success: @escaping ((MXCredentials) -> ()), failure: @escaping ((Error) -> ())) {
        let parameters: [AnyHashable: Any] = [
            "type": kMXLoginFlowTypePassword,
            "user": username,
            "password": password
        ]
        
        let restClient = MXRestClient(homeServer: homeServer, andOnUnrecognizedCertificateBlock: nil)!
        
        restClient.login(parameters, success: { (response) in
            if let accessToken = response?["access_token"] as? String, let matrixId = response?["user_id"] as? String, let deviceId = response?["device_id"] as? String, let homeServer = response?["home_server"] as? String {
                if let credentials = MXCredentials(homeServer: homeServer, userId: matrixId, accessToken: accessToken) {
                    credentials.deviceId = deviceId
                    success(credentials)
                }
            }
        }) { (error) in
            if error != nil {
                failure(error!)
            }
        }
    }
    
}
