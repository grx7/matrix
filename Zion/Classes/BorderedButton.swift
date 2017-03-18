//
//  BorderedButton.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 16/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

class BorderedButton: UIButton {
    
    @IBInspectable var borderColor: UIColor  = UIColor.init(white: 1, alpha: 0.85)
    @IBInspectable var borderWidth: Float = 1
    @IBInspectable var borderRadius: Float = 4

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let border = CALayer()
        border.borderColor = self.borderColor.cgColor
        border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = CGFloat(self.borderWidth)
        border.cornerRadius = CGFloat(self.borderRadius)
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }

}
