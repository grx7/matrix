//
//  UINavigationBar+Matrix.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 18/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

extension UINavigationBar {

    func setBottomBorderColor(color: UIColor, height: CGFloat) {
        let bottomBorderRect = CGRect(x: 0, y: frame.height, width: frame.width, height: height)
        let bottomBorderView = UIView(frame: bottomBorderRect)
        bottomBorderView.backgroundColor = color
        addSubview(bottomBorderView)
    }
    
}
