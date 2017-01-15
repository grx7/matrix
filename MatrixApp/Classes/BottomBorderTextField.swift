//
//  BottomBorderTextField.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 13/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

class BottomBorderTextField: UITextField {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.init(white: 1, alpha: 0.85).cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName : UIColor.init(white: 1, alpha: 0.7)])
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 6, y: bounds.origin.y + 6, width: bounds.size.width - 12, height: bounds.size.height - 12);
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds);
    }

}
