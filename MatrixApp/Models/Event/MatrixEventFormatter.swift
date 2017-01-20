//
//  MatrixEventFormatter.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 20/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit
import MatrixSDK

class MatrixEventFormatter {

    var event: MXEvent
    var room: MatrixRoom
    
    init(event: MXEvent, room: MatrixRoom) {
        self.event = event
        self.room = room
    }
    
    func formattedEvent() -> String {
        switch self.event.eventType {
        case MXEventTypeRoomMember:
            return self.formatRoomMemberEvent()
        default:
            break
        }
        
        return ""
    }
    
    func formatRoomMemberEvent() -> String {
        if self.event.isUserProfileChange() {
            
            var profileChange = ""
            
            if let displayName = event.content["displayname"] as? String {
                
                profileChange = "\(displayName)"
                
                if let previousDisplayName = event.prevContent["displayname"] as? String, displayName != previousDisplayName {
                    profileChange = "\(profileChange) changed name from \(previousDisplayName)"
                }
                
            }
            
            return profileChange
            
            if let avatar = event.content["avatar_url"] as? String, let previousAvatar = event.prevContent["avatar_url"] as? String {
                if avatar != previousAvatar {
                    return "Avatar changed"
                }
            }
            
        } else {
            if self.event.content["membership"] as? String == "join", let displayName = self.event.content["displayname"] as? String  {
                return "\(self.displayNameFor(user: self.event.sender, provided: displayName)) joined"
            }
        }
        return ""
    }
    
    func displayNameFor(user: String, provided: String? = "") -> String {
        if self.event.sender == self.room.session.myUser.userId {
            return "you"
        }
        
        return user
    }
    
}
