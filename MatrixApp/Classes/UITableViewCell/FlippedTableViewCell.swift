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
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        self.selectedBackgroundView = backgroundView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.transform = CGAffineTransform(scaleX: 1, y: -1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
