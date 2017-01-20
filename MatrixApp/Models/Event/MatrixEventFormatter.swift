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
    
    init(event: MXEvent) {
        self.event = event
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
            
            print(event)
            print(event.content)
            print(event.prevContent)
            
            return profileChange
            
            if let avatar = event.content["avatar_url"] as? String, let previousAvatar = event.prevContent["avatar_url"] as? String {
                if avatar != previousAvatar {
                    return "Avatar changed"
                }
            }
            
        } else {
            if self.event.content["membership"] as? String == "join", let displayName = self.event.content["displayname"] as? String  {
                return "\(displayName) joined"
            }
        }
        return ""
    }
    
}
