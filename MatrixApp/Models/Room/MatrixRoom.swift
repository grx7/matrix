//
//  MatrixRoom.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 19/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit
import MatrixSDK

class MatrixRoom {

    var room: MXRoom
    var session: MXSession
    var restClient: MXRestClient
    
    init(room: MXRoom) {
        self.room = room
        self.session = room.mxSession
        self.restClient = room.mxSession.matrixRestClient
    }
    
    func avatarUrl(size: CGSize) -> String? {
        if self.directChat() {
            for member in self.room.state.members {
                if (member.userId != self.session.myUser.userId) && (member.avatarUrl != nil) {
                    return self.fullAvatarUrl(url: member.avatarUrl!, size: size)
                }
            }
        }
        
        return nil
    }
    
    func initials() -> String {
        var name = ""
        if self.directChat() {
            for member in self.room.state.members {
                if (member.userId != self.session.myUser.userId) && (member.displayname != nil) {
                    name = member.displayname
                    break
                }
            }
        } else {
            name = self.room.state.displayname
        }
        
        let initials = name.capitalized.components(separatedBy: " ")
        
        return initials.reduce("") { $0.0 + String($0.1.characters.first!) }
    }
    
    func preview() -> String {
        let type = (self.directChat()) ? "Direct" : "Group"

        switch self.room.state.membership {
        case MXMembershipInvite:
            return "Tap to Join - \(type)"
        case MXMembershipJoin:
            return self.lastEvent().asString()
        default:
            return ""
        }
    }
    
    func displayName() -> String {
        if self.directChat() {
            for member in self.room.state.members {
                if (member.userId != self.session.myUser.userId) && (member.displayname != nil) {
                    return member.displayname
                }
            }
        }
        
        if (self.room.state.displayname != nil) {
            return self.room.state.displayname!
        }
        
        return ""
    }
    
    func directChat() -> Bool {
        if self.room.state.members.count == 2 {
            return true
        }
        
        return false
    }
    
    func lastActivity() -> String {
        return self.lastEvent().timeAgo()
    }
    
    private func lastEvent() -> MatrixEvent {
        return MatrixEvent(event: self.room.lastMessageWithType(in: [kMXEventTypeStringRoomName, kMXEventTypeStringRoomTopic, kMXEventTypeStringRoomAvatar, kMXEventTypeStringRoomMember, kMXEventTypeStringRoomCreate, kMXEventTypeStringRoomJoinRules, kMXEventTypeStringRoomPowerLevels, kMXEventTypeStringRoomAliases, kMXEventTypeStringRoomCanonicalAlias, kMXEventTypeStringRoomEncrypted, kMXEventTypeStringRoomEncryption, kMXEventTypeStringRoomGuestAccess, kMXEventTypeStringRoomKey, kMXEventTypeStringRoomHistoryVisibility, kMXEventTypeStringRoomMessage, kMXEventTypeStringRoomMessageFeedback, kMXEventTypeStringRoomRedaction, kMXEventTypeStringRoomThirdPartyInvite, kMXEventTypeStringRoomTag, kMXEventTypeStringPresence]))
    }

    private func fullAvatarUrl(url: String, size: CGSize) -> String {
        if url.hasPrefix(Constants.contentUriScheme) {
            return self.restClient.url(ofContentThumbnail: url, toFitViewSize: size, with: MXThumbnailingMethodCrop)
        }
        
        return url
    }
    
}
