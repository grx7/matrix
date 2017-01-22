//
//  MatrixEvent.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 20/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit
import MatrixSDK

class MatrixEvent {
    
    var event: MXEvent
    var room: MatrixRoom
    var eventFormatter: MatrixEventFormatter
    
    init(event: MXEvent, room: MatrixRoom) {
        self.event = event
        self.room = room
        self.eventFormatter = MatrixEventFormatter(event: self.event, room: self.room)
    }
    
    var timeAgo: String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(self.event.ageLocalTs / 1000))
        
        return date.timeAgo().lowercased()
    }
    
    var asPreview: String {
        return self.eventFormatter.formattedEvent(isPreview: true)
    }
    
    var asString: String {
        return self.eventFormatter.formattedEvent()
    }
    
    var senderAvatarLink: String? {
        let user = self.room.room.state.member(withUserId: self.event.sender)
        
        if let avatarUrl = user?.avatarUrl {
            if avatarUrl.hasPrefix(Constants.contentUriScheme) {
                return self.room.restClient.url(ofContentThumbnail: avatarUrl, toFitViewSize: CGSize(width: 30, height: 30), with: MXThumbnailingMethodCrop)
            }
            
            return avatarUrl
        }
        
        return nil
    }

}
