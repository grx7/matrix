//
//  FlippedTableView.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 24/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

class FlippedTableView: UITableView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI))
        self.transform = transform
        
        self.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, self.bounds.size.width-10)
    }

}
