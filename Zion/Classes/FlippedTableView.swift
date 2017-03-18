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
        
        self.transform = CGAffineTransform(scaleX: 1, y: -1)
    }

}
