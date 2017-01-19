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
        if self.room.isDirect {
            for member in self.room.state.members {
                if (member.userId != self.session.myUser.userId) && (member.avatarUrl != nil) {
                    return self.restClient.url(ofContentThumbnail: member.avatarUrl!, toFitViewSize: size, with: MXThumbnailingMethodCrop)
                }
            }
        }
        
        return nil
    }
    
    func initials() -> String {
        var name = ""
        if self.room.isDirect {
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
    
}
