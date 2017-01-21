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
        case MXEventTypeRoomMessage:
            return self.formatRoomMessageEvent()
        case MXEventTypeRoomMember:
            return self.formatRoomMemberEvent()
        default:
            break
        }
        
        return ""
    }
    
    func formatRoomMessageEvent() -> String {
        let senderName = self.displayNameFor(user: self.event.sender)
        
        if let messageBody = self.event.content["body"] as? String {
            return "events.user_sent_text_message".localized(arguments: [senderName, messageBody])
        }
        
        return "events.user_sent_text_message_unknown".localized(arguments: [senderName])
    }
    
    func formatRoomMemberEvent() -> String {
        
        let senderName = self.displayNameFor(user: self.event.sender)
        
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
    
    func displayNameFor(user: String) -> String {
        if self.event.sender == self.room.session.myUser.userId {
            return "You"
        }
        
        return self.room.room.state.memberName(user)
    }
    
}
