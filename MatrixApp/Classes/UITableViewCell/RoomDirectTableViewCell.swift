//
//  RoomDirectTableViewCell.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 19/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

class RoomDirectTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var previewLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var avatarInitialsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.avatarInitialsLabel.isHidden = true
        
        self.avatarImageView.layer.cornerRadius = 30
        self.avatarImageView.layer.masksToBounds = true
        self.avatarImageView.layer.borderColor = UIColor.init(white: 1, alpha: 0.25).cgColor
        self.avatarImageView.layer.borderWidth = 1
        self.avatarImageView.backgroundColor = UIColor.init(white: 1, alpha: 0.2)
        
        //self.avatarImageView.downloadedFrom(link: "https://pbs.twimg.com/profile_images/700005024898748416/OyntEaBX_400x400.jpg")
    }
    
    func setAvatarInitials(_ initials: String) {
        self.avatarImageView.image = UIImage()
        self.avatarInitialsLabel.text = initials
        self.avatarInitialsLabel.isHidden = false
    }
    
    func setAvatarImage(_ imageLink: String) {
        self.avatarImageView.downloadedFrom(link: imageLink)
        self.avatarInitialsLabel.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
