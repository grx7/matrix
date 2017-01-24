//
//  FlippedTableViewCell.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 24/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

class FlippedTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI))
        self.transform = transform;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
