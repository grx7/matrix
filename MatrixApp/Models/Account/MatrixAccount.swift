//
//  MatrixAccount.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 13/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit
import CoreData
import MatrixSDK
import KeychainAccess

@objc(MatrixAccount)
class MatrixAccount: NSManagedObject {
    
    var credentials: MXCredentials = MXCredentials()
    var restClient: MXRestClient = MXRestClient()
    var session: MXSession = MXSession()
    
    var token: String? {
        let keychain = Keychain(service: Constants.service)
        
        do {
            let token = try keychain.get(self.userId!)
            
            return token
        } catch let error {
            print("Could not fetch token: \(error)")
        }
        
        return nil
    }

    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        
        if self.homeServer != nil && self.userId != nil && self.token != nil {
            self.credentials = MXCredentials(homeServer: self.homeServer!, userId: self.userId!, accessToken: self.token!)
            self.restClient = MXRestClient(credentials: self.credentials, andOnUnrecognizedCertificateBlock: nil)
            self.session = MXSession(matrixRestClient: restClient)
        }
    }
    
    static func accounts() -> [MatrixAccount] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MatrixAccount")
        
        do {
            let results = try context.fetch(fetchRequest)
            
            return results as! [MatrixAccount]
        } catch let error {
            print("Could not fetch: \(error)")
        }
        
        return []
    }
    
    static func activeAccount() -> MatrixAccount? {
        return self.accounts().first
    }
    
    static func saveAccount(username: String, password: String, homeServer: String, identityServer: String, success: @escaping ((MatrixAccount) -> ()), failure: @escaping ((Error) -> ())) {
        
        MatrixAccount.authenticateUser(username: username, password: password, homeServer: homeServer, success: { (credentials) in

            let keychain = Keychain(service: Constants.service)
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "MatrixAccount", in: context)
            
            let account = MatrixAccount(entity: entity!, insertInto: context)
            
            account.username = username
            account.userId = credentials.userId
            account.deviceId = credentials.deviceId
            account.homeServer = homeServer
            account.identityServer = identityServer
            
            do {
                try keychain.set(credentials.accessToken, key: credentials.userId)
                try context.save()
                
                NotificationCenter.default.post(name: Notifications.accountAdded, object: account)
            } catch let error {
                print("Could not save: \(error)")
            }
            
        }) { (error) in
            failure(error)
        }

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
    
//    var credentials: MXCredentials = MXCredentials()
//    var restClient: MXRestClient = MXRestClient()
//    var session: MXSession = MXSession()
//    
//    init(credentials: MXCredentials) {
//        self.credentials = credentials
//        self.restClient = MXRestClient(credentials: self.credentials, andOnUnrecognizedCertificateBlock: nil)
//        self.session = MXSession(matrixRestClient: restClient)
//    }
//    
//    static func authenticateUser(username: String, password: String, homeServer: String, success: @escaping ((MXCredentials) -> ()), failure: @escaping ((Error) -> ())) {
//        let parameters: [AnyHashable: Any] = [
//            "type": kMXLoginFlowTypePassword,
//            "user": username,
//            "password": password
//        ]
//        
//        let restClient = MXRestClient(homeServer: homeServer, andOnUnrecognizedCertificateBlock: nil)!
//        
//        restClient.login(parameters, success: { (response) in
//            if let accessToken = response?["access_token"] as? String, let matrixId = response?["user_id"] as? String, let deviceId = response?["device_id"] as? String, let homeServer = response?["home_server"] as? String {
//                if let credentials = MXCredentials(homeServer: homeServer, userId: matrixId, accessToken: accessToken) {
//                    credentials.deviceId = deviceId
//                    success(credentials)
//                }
//            }
//        }) { (error) in
//            if error != nil {
//                failure(error!)
//            }
//        }
//    }
    
}


extension MatrixAccount {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MatrixAccount> {
        return NSFetchRequest<MatrixAccount>(entityName: "MatrixAccount");
    }
    
    @NSManaged public var deviceId: String?
    @NSManaged public var homeServer: String?
    @NSManaged public var identityServer: String?
    @NSManaged public var userId: String?
    @NSManaged public var username: String?

}
