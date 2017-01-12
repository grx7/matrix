//
//  GradientView.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 12/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

class GradientView: UIView {

    @IBInspectable var firstColor: UIColor  = UIColor.blue
    @IBInspectable var secondColor: UIColor = UIColor.red
    
    init(frame: CGRect, firstColor: UIColor, secondColor: UIColor) {
        self.firstColor = firstColor
        self.secondColor = secondColor
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        let gradient: CAGradientLayer = CAGradientLayer()
        
        if let sublayers = self.layer.sublayers {
            if let sublayer: CAGradientLayer = sublayers[0] as? CAGradientLayer {
                sublayer.removeFromSuperlayer()
            }
        }
        
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.bounds.size.width, height: self.bounds.size.height)
        
        self.layer.insertSublayer(gradient, at: 0)
    }

}
