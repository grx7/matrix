//
//  NoticeMessageTableViewCell.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 22/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

class NoticeMessageTableViewCell: UITableViewCell {

    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var noticeView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.noticeView.layer.cornerRadius = 4
        self.noticeView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
