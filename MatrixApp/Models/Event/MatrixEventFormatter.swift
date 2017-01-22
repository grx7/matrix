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
    
    /**
     Returns a string with the event formatted to present to the user.
     
     - Parameters:
     - isPreview: Whether the string should include user identifiers
     
     - Returns: The event rendered as a String.
     */
    func formattedEvent(isPreview: Bool = false) -> String {
        switch self.event.eventType {
        case MXEventTypeRoomMessage:
            return self.formatRoomMessageEvent(includeName: isPreview)
        case MXEventTypeRoomMember:
            return self.formatRoomMemberEvent()
        default:
            break
        }
        
        return ""
    }
    
    /**
     Returns a string for message events.
     
     - Parameters:
     - includeName: Whether the string should include user identifiers
     
     - Returns: The event rendered as a String.
     */
    func formatRoomMessageEvent(includeName: Bool = false) -> String {
        let senderName = self.displayNameFor(userId: self.event.sender)
        
        if let messageBody = self.event.content["body"] as? String {
            if includeName {
                return String(format: "%@: %@", senderName, messageBody)
            }
            
            return messageBody
        }
        
        return "events.user_sent_text_message_unknown".localized(arguments: [senderName])
    }
    
    /**
     Returns a string for the Room Member events.
     
     - Returns: The event rendered as a String.
     */
    func formatRoomMemberEvent() -> String {
        
        let senderName = self.displayNameFor(userId: self.event.sender)
        
        if self.event.isUserProfileChange() {

            if let displayName = self.event.content["displayname"] as? String, let previousName = event.prevContent["displayname"] as? String, senderName != previousName {
                return "events.user_changed_name".localized(arguments: [previousName, displayName])
            }
                
            if let avatar = event.content["avatar_url"] as? String, let previousAvatar = event.prevContent["avatar_url"] as? String, avatar != previousAvatar {
                return "events.user_changed_avatar".localized(arguments: [senderName])
            }
            
        } else {
            if let membership = self.event.content["membership"] as? String {
                return { () -> String in
                    switch membership {
                    case "join":
                        return "events.user_joined_room".localized(arguments: [senderName])
                    case "leave":
                        return "events.user_left_room".localized(arguments: [senderName])
                    case "invite":
                        return "events.user_invited_room".localized(arguments: [senderName])
                    default:
                        return ""
                    }
                }()
            }
        }
        return ""
    }
    
    /**
     Gets the display name for a user.
     
     - Parameters:
     - userId: Fully-qualified ID of the user
     
     - Returns: The display name of the provided user.
     */
    func displayNameFor(userId: String) -> String {
        if self.event.sender == self.room.session.myUser.userId {
            return "You"
        }
        
        return self.room.room.state.memberName(userId)
    }
    
}
