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
        UserDefaults.standard.object(forKey: "userAccounts")
    }
    
}
