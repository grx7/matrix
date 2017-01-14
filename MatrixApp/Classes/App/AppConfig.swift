//
//  AppConfig.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 14/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

class AppConfig {

    static let sharedInstance = AppConfig()
    private init() {}
    
    private var configData: [String: Any]?
    
    func get(key: String) -> Any? {
        if self.configData == nil {
            self.loadConfigData()
        }
        
        if let data = self.configData?[key] {
            return data
        }
        
        return nil
    }
    
    func getString(key: String) -> String? {
        if let data = self.get(key: key) as? String {
            return data
        }
        
        return nil
    }
    
    func getDefault(string: String?, key: String, defaultValue: String = "") -> String {
        if (string != nil) && !(string?.isEmpty)! {
            return string!
        }
        
        return self.getString(key: key) ?? defaultValue
    }
    
    private func loadConfigData() {
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
            self.configData = NSDictionary(contentsOfFile: path) as! [String : Any]?
        }
    }
    
}
