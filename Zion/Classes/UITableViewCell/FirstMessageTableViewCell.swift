//
//  FirstMessageTableViewCell.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 22/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

class FirstMessageTableViewCell: MessageTableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.avatarImageView.layer.cornerRadius = 15
        self.avatarImageView.layer.masksToBounds = true
        self.avatarImageView.layer.borderColor = UIColor.init(white: 1, alpha: 0.25).cgColor
        self.avatarImageView.layer.borderWidth = 1
        self.avatarImageView.backgroundColor = UIColor.init(white: 1, alpha: 0.2)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
