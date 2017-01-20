//
//  String+Matrix.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 20/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

extension String {
    
    func localized(arguments: [String] = []) -> String {
        return String(format: NSLocalizedString(self, comment: ""), arguments: arguments)
    }
    
}
