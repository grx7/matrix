//
//  RoomDirectTableViewCell.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 19/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

class RoomTableViewCell: UITableViewCell {

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
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.init(white: 1, alpha: 0.1)
        self.selectedBackgroundView = backgroundView
    }
    
    func setCell(room: MatrixRoom) {
        if let avatarUrl = room.avatarUrl(size: CGSize(width: 60, height: 60)) {
            self.setAvatarImage(avatarUrl)
        } else {
            self.setAvatarInitials(room.initials())
        }
        
        self.setBackgroundHighlight((room.notificationCount() > 0) ? true : false)
        self.timeLabel.text = room.lastActivity()
        self.nameLabel.text = room.displayName()
        self.previewLabel.text = room.preview()
    }
    
    private func setAvatarInitials(_ initials: String) {
        self.avatarImageView.image = UIImage()
        self.avatarInitialsLabel.text = initials
        self.avatarInitialsLabel.isHidden = false
    }
    
    private func setAvatarImage(_ imageLink: String) {
        self.avatarImageView.downloadedFrom(link: imageLink)
        self.avatarInitialsLabel.isHidden = true
    }
    
    private func setBackgroundHighlight(_ highlighted: Bool) {
        if highlighted {
            self.backgroundColor = UIColor.init(white: 1, alpha: 0.05)
        } else {
            self.backgroundColor = UIColor.clear
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
