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
    
    /// How long ago the event occured in human format.
    var timeAgo: String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(self.event.ageLocalTs / 1000))
        
        return date.timeAgo().lowercased()
    }
    
    /// String to convey event message with user identifiers included.
    var asPreview: String {
        return self.eventFormatter.formattedEvent(isPreview: true)
    }
    
    /// String to convey event message.
    var asString: String {
        return self.eventFormatter.formattedEvent()
    }
    
    /// The avatar of the sending user.
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
    
    var isNotice: Bool {
        switch self.event.eventType {
        case MXEventTypeRoomMessage:
            return false
        case MXEventTypeRoomMember:
            return true
        default:
            return false
        }
    }
    
    func isPartOfChain(previousEvent: MatrixEvent) -> Bool {
        if (self.event.sender == previousEvent.event.sender) && (self.event.eventType == MXEventTypeRoomMessage) && !previousEvent.isNotice {
            return true
        }
        
        return false
    }
    
    func shouldShowEventInChat() -> Bool {
        if self.event.eventType == MXEventTypeRoomMessage {
            return true
        }
        
        if self.event.eventType == MXEventTypeRoomMember {
            if self.event.isUserProfileChange() {
                if let displayName = self.event.content["displayname"] as? String,
                    let avatarUrl = self.event.content["avatar_url"] as? String,
                    let prevDisplayName = self.event.prevContent["displayname"] as? String,
                    let prevAvatarUrl = self.event.prevContent["avatar_url"] as? String {

                    if (displayName != prevDisplayName) || (avatarUrl != prevAvatarUrl) {
                        return true
                    }
                }
                
                return false
            }
            
            if (self.event.content["membership"] as? String) != nil {
                return true
            }
            
        }
        
        return false
    }

}
